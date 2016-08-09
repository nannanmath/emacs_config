(provide 'setup-prog-edit)

;;;;;;;;;;;;;;;;;;;;;
;;  c++ font lock  ;;
;;;;;;;;;;;;;;;;;;;;;
(add-hook 'c++-mode-hook 'modern-c++-font-lock-mode)


;;;;;;;;;;;;;;;;;;;;;
;;       cff       ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'cff)
;; defines shortcut for find source/header file for the current
;; file
(add-hook 'c++-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))
(add-hook 'c-mode-hook
           '(lambda ()
              (define-key c-mode-base-map (kbd "M-o") 'cff-find-other-file)))


;;;;;;;;;;;;;;;;;;;;;
;;     company     ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(define-key company-mode-map  [(tab)] 'company-complete)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-shell)

(require 'semantic)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(semantic-mode 1)
(require 'stickyfunc-enhance)


;;;;;;;;;;;;;;;;;;;;;
;;       tags      ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'ggtags)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)


;;;;;;;;;;;;;;;;;;;;;
;;    yasnippet    ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;
;;   sr-speedbar   ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'sr-speedbar)
(setq 
    speedbar-show-unknown-files t
    speedbar-width-x 30
    speedbar-width-console 30
    speedbar-max-width 30
    sr-speedbar-right-side nil
    sr-speedbar-delete-windows t
)
;; (add-hook 'emacs-startup-hook (lambda ()
;;    (sr-speedbar-open)
;;    (with-current-buffer sr-speedbar-buffer-name
;;    (setq window-size-fixed 'width))
;; ))
(add-hook 'speedbar-mode-hook (lambda () 
    (linum-mode -1)
))


;;;;;;;;;;;;;;;;;;;;;
;;   compilation   ;;
;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq compile-command "make")
                               (call-interactively 'compile)))


;;;;;;;;;;;;;;;;;;;;;
;;      debug      ;;
;;;;;;;;;;;;;;;;;;;;;
(setq gdb-many-windows t
			gdb-show-main t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight indentation ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-indent-guides)
(setq highlight-indent-guides-method 'character)
(set-face-foreground 'highlight-indent-guides-character-face "red")
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)


;;;;;;;;;;;;;
;; folding ;;
;;;;;;;;;;;;;
(require 'yafolding)
(add-hook 'prog-mode-hook 'yafolding-mode)



;;;;;;;;;;;;;;;;;;;;;
;;      magit      ;;
;;;;;;;;;;;;;;;;;;;;;

