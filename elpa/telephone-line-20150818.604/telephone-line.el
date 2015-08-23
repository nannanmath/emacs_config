;;; telephone-line.el --- Rewrite of Powerline

;; Copyright (C) 2015 Daniel Bordak

;; Author: Daniel Bordak <dbordak@fastmail.fm>
;; URL: https://github.com/dbordak/telephone-line
;; Version: 0.2
;; Keywords: mode-line
;; Package-Requires: ((emacs "24.3") (cl-lib "0.5") (memoize "1.0.1") (names "0.5") (s "1.9.0") (seq "1.8"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Telephone Line is a library for customizing the mode-line that is
;; based on the Vim Powerline. Themes can be created by customizing
;; the telephone-line-lhs and telephone-line-rhs variables.
;;

;;; Code:

(require 'telephone-line-separators)
(require 'telephone-line-segments)

(require 'seq)
(require 's)
(require 'cl-lib)

;;;###autoload
(define-namespace telephone-line-

(defgroup telephone-line nil
  "Fancy separated mode-line."
  :group 'mode-line)

(defface accent-active
  '((t (:foreground "white" :background "grey22" :inherit mode-line)))
  "Accent face for mode-line."
  :group 'telephone-line)

(defface accent-inactive
  '((t (:foreground "white" :background "grey11" :inherit mode-line-inactive)))
  "Accent face for inactive mode-line."
  :group 'telephone-line)

(defface evil
  '((t (:foreground "white" :weight bold :inherit mode-line)))
  "Meta-face used for property inheritance on all telephone-line-evil faces."
  :group 'telephone-line-evil)

(defface evil-insert
  '((t (:background "green" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Insert state."
  :group 'telephone-line-evil)

(defface evil-normal
  '((t (:background "red" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Normal state."
  :group 'telephone-line-evil)

(defface evil-visual
  '((t (:background "orange" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Visual{,-Block,-Line} state."
  :group 'telephone-line-evil)

(defface evil-replace
  '((t (:background "black" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Replace state."
  :group 'telephone-line-evil)

(defface evil-motion
  '((t (:background "blue" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Motion state."
  :group 'telephone-line-evil)

(defface evil-operator
  '((t (:background "sky blue" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Operator state."
  :group 'telephone-line-evil)

(defface evil-emacs
  '((t (:background "blue violet" :inherit telephone-line-evil)))
  "Face used in evil color-coded segments when in Emacs state."
  :group 'telephone-line-evil)

(defcustom primary-left-separator #'telephone-line-abs-left
  "The primary separator to use on the left-hand side."
  :group 'telephone-line
  :type 'function)

(defcustom primary-right-separator #'telephone-line-abs-right
  "The primary separator to use on the right-hand side."
  :group 'telephone-line
  :type 'function)

(defcustom secondary-left-separator #'telephone-line-abs-hollow-left
  "The secondary separator to use on the left-hand side.

Secondary separators do not incur a background color change."
  :group 'telephone-line
  :type 'function)

(defcustom secondary-right-separator #'telephone-line-abs-hollow-right
  "The secondary separator to use on the right-hand side.

Secondary separators do not incur a background color change."
  :group 'telephone-line
  :type 'function)

(defun fill (reserve &optional face)
  "Return RESERVE empty space on the right, optionally with a FACE." ;;TODO: Add face
  (propertize " "
              'display `((space :align-to (- (+ right right-fringe right-margin)
                                             ,reserve)))))

(defun -set-selected-window ()
  (when (not (minibuffer-window-active-p (frame-selected-window)))
    (setq selected-window (frame-selected-window))))

(add-hook 'window-configuration-change-hook #'-set-selected-window)
(defadvice select-window (after select-window activate)
  "Set telephone-line's selected window value for use in determining the active mode-line."
  (-set-selected-window))
(defadvice select-frame (after select-frame activate)
  "Set telephone-line's selected window value for use in determining the active mode-line."
  (-set-selected-window))

(defun selected-window-active ()
  "Return whether the current window is active."
  (and (boundp 'selected-window)
       (eq selected-window (selected-window))))

(defun face-map (sym)
  "Return the face corresponding to SYM for the selected window's active state."
  (-face-map sym (selected-window-active)))

;;TODO: Custom alist
(defun -face-map (sym active)
  "Return the face corresponding to SYM for the given ACTIVE state."
  (cond ((eq sym 'evil) (evil-face active))
        ((eq sym 'accent) (if active 'telephone-line-accent-active
                            'telephone-line-accent-inactive))
        (active 'mode-line)
        (t 'mode-line-inactive)))

;;TODO: Custom alist
(defun opposite-face-sym (sym)
  "Return the 'opposite' of the given SYM."
  (cdr (assoc
        sym '((evil . nil)
              (accent . nil)
              (nil . accent)))))

(defun evil-face (active)
  "Return an appropriate face for the current evil mode, given whether the frame is ACTIVE."
  (cond ((not active) 'mode-line-inactive)
        ((not (boundp 'evil-state)) 'mode-line)
        (t (intern (concat "telephone-line-evil-" (symbol-name evil-state))))))

;;TODO: Clean this up
(defun -separator-generator (primary-sep)
  (lambda (acc e)
    (let ((cur-color-sym (car e))
          (prev-color-sym (cdr acc))
          (cur-subsegments (cdr e))
          (accumulated-segments (car acc)))

      (cons
       (if accumulated-segments
           (cl-list*
            cur-subsegments ;New segment
            ;; Separator
            `(:eval (funcall #',primary-sep
                             (telephone-line-face-map ',prev-color-sym)
                             (telephone-line-face-map ',cur-color-sym)))
            accumulated-segments) ;Old segments
         (list cur-subsegments))
       cur-color-sym))))

(defun propertize-segment (pred face segment)
  (unless (s-blank? (s-trim (format-mode-line segment)))
    (if pred
        `(:propertize (" " ,segment " ") face ,face)
      `(" " ,segment " "))))

;;TODO: Clean this up
(defun add-subseparators (subsegments sep-func color-sym)
  (let* ((cur-face (face-map color-sym))
         (opposite-face (face-map (opposite-face-sym color-sym)))
         (subseparator (funcall sep-func cur-face opposite-face)))
    (propertize-segment
     color-sym cur-face
     (cdr (seq-mapcat
           (lambda (subseg)
             (when subseg
               (list subseparator subseg)))
           (mapcar (lambda (f) (funcall f cur-face))
                   subsegments))))))

;;TODO: Clean this up
(defun add-separators (segments primary-sep secondary-sep)
  "Interpolates SEGMENTS with PRIMARY-SEP and SECONDARY-SEP.

Primary separators are added at initialization.  Secondary
separators, as they are conditional, are evaluated on-the-fly."
  (car (seq-reduce
        (-separator-generator primary-sep)
        (mapcar (lambda (segment-pair)
                  (seq-let (color-sym &rest subsegments) segment-pair
                    (cons color-sym
                          `(:eval
                            (telephone-line-add-subseparators
                             ',subsegments #',secondary-sep ',color-sym)))))
                (seq-reverse segments))
        '(nil . nil))))

(defun width (values num-separators)
  "Get the column-length of VALUES, with NUM-SEPARATORS interposed."
  (let ((base-width (string-width (format-mode-line values)))
        (separator-width (/ (telephone-line-separator-width)
                            (float (frame-char-width)))))
    (if window-system
        (+ base-width
           ;; Separators are (ceiling separator-width)-space strings,
           ;; but their actual width is separator-width. base-width
           ;; already includes the string width of those spaces, so we
           ;; need the difference.
           (* num-separators (- separator-width (ceiling separator-width))))
      base-width)))

(defcustom lhs '((accent . (telephone-line-vc-segment))
                 (nil    . (telephone-line-minor-mode-segment
                            telephone-line-buffer-segment)))
  "Left hand side segment alist."
  :type '(alist :key-type segment-color :value-type subsegment-list)
  :group 'telephone-line)

(defcustom rhs '((nil    . (telephone-line-misc-info-segment
                            telephone-line-major-mode-segment))
                 (accent . (telephone-line-position-segment)))
  "Right hand side segment alist."
  :type '(alist :key-type segment-color :value-type subsegment-list)
  :group 'telephone-line)

(defun -generate-mode-line-lhs ()
  (add-separators lhs
                  primary-left-separator
                  secondary-left-separator))

(defun -generate-mode-line-rhs ()
  (add-separators rhs
                  primary-right-separator
                  secondary-right-separator))

(defun -generate-mode-line ()
  `(,@(telephone-line--generate-mode-line-lhs)
    (:eval (telephone-line-fill
            (telephone-line-width
             ',(telephone-line--generate-mode-line-rhs)
             ,(- (length telephone-line-rhs) 1))))
    ,@(telephone-line--generate-mode-line-rhs)))

(defvar -default-mode-line mode-line-format)

:autoload
(define-minor-mode mode
  "Toggle telephone-line on or off."
  :group 'telephone-line
  :global t
  :lighter nil
  (setq-default mode-line-format
                (if telephone-line-mode
                    `("%e" ,@(telephone-line--generate-mode-line))
                  -default-mode-line)))

) ; End of namespace

(provide 'telephone-line)
;;; telephone-line.el ends here
