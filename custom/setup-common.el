(provide 'setup-common)

;; startup setting
(setq inhibit-startup-message t)
(global-linum-mode t)
(column-number-mode t)
(menu-bar-mode -1)
; (scroll-bar-mode -1)
(tool-bar-mode -1)
(setq-default cursor-type 'bar) 
(custom-set-variables '(initial-frame-alist '((fullscreen . maximized))))
(defalias 'yes-or-no-p 'y-or-n-p)

;; color theme
(load-theme 'zenburn t)

;; map keys in term
(add-hook 'term-setup-hook
					'(lambda()
						 (define-key function-key-map "\e[1;2D" [S-left])
						 (define-key function-key-map "\e[1;2C" [S-right])
						 (define-key function-key-map "\e[1;2A" [S-up])
						 (define-key function-key-map "\e[1;2B" [S-down])))

;; speed bar
(require 'sr-speedbar)
(global-set-key (kbd "C-c s") 'sr-speedbar-toggle)

;; paren
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; show buffer name on window bar 
;; (setq frame-title-format "emacs@%b")

;; powerline
;;(require 'powerline)
;;(powerline-default-theme)
;;(telephone-line-mode 1)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; windmove
(windmove-default-keybindings)
						 
;; whitespace
(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET
;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; use space to indent by default
;; (setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 2 spaces
(setq-default tab-width 2)

;; backup files
(setq backup-directory-alist '(("." . "~/backups")))
(setq backup-by-copying t)

;; auto save 
(setq auto-save-mode nil)

;; crosshairs
(global-set-key (kbd "C-+") 'crosshairs-mode)

;; path from shell
(exec-path-from-shell-initialize)

;; elscreen & elscreen-persist & elscreen-buffer-group
(elscreen-start)
;; (require 'elscreen-buffer-group)
;; (elscreen-persist-mode 1)


;; desktop
(require 'desktop+)

(defcustom desktop-data-elscreen nil nil
  :type 'list
  :group 'desktop)

(defun desktop-prepare-data-elscreen! ()
  (setq desktop-data-elscreen
        (elscreen-persist-get-data)))

(defun desktop-evaluate-data-elscreen! ()
  (when desktop-data-elscreen
    (elscreen-persist-set-data desktop-data-elscreen)))

(add-hook 'desktop-after-read-hook 'desktop-evaluate-data-elscreen!)
(add-hook 'desktop-save-hook 'desktop-prepare-data-elscreen!)
(add-to-list 'desktop-globals-to-save 'desktop-data-elscreen)

;(setq desktop-files-not-to-save "")
(setq desktop-restore-frames nil)


;; window restore
(when (fboundp 'winner-mode)
	(winner-mode 1))

;; bookmarker
(require 'bm)
(setq bm-cycle-all-buffers t)
(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)

;; shell pop
(require 'shell-pop)
(defun shell-pop-eshell ()
	(interactive)
	(let ((shell-pop-shell-type '("eshell" "*eshell*" (lambda () (eshell))))
				(shell-pop-term-shell "eshell"))
		(shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type)
		(call-interactively 'shell-pop)))
(global-set-key (kbd "C-c t") 'shell-pop-eshell)
(setq shell-pop-full-span t)
(setq shell-pop-window-position "bottom")
(setq shell-pop-window-size 30)
