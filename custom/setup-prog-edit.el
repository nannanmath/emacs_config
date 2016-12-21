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
;; python-anaconda ;;
;;;;;;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook 'anaconda-mode)

;;;;;;;;;;;;;;;;;;;;;
;;   sphinx-doc    ;;
;;;;;;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook (lambda ()
															(require 'sphinx-doc)
															(sphinx-doc-mode t)))

;;;;;;;;;;;;;;;;;;;;;
;;     company     ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key (kbd "<C-tab>") 'company-complete)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-shell)
(add-to-list 'company-backends '(company-anaconda :with company-capf))

;;;;;;;;;;;;;;;;;;;;;
;;     semantic    ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'semantic)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
(require 'semantic/bovine/gcc)
(semantic-mode 1)

(require 'stickyfunc-enhance)

;;;;;;;;;;;;;;;;;;;;;
;;     flycheck    ;;
;;;;;;;;;;;;;;;;;;;;;
(add-hook 'after-init-hook #'global-flycheck-mode)


;;;;;;;;;;;;;;;;;;;;;
;;     doxymacs    ;;
;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/custom/doxymacs")
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
(defun my-doxymacs-font-lock-hook ()
	(if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
			(doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

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
;;   projectile    ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
;; (setq projectile-indexing-method 'alien)

(require 'helm-projectile)
(helm-projectile-on)
;;(setq projectile-completion-system 'helm)

;; ag
;;(require 'wgrep-helm)
(require 'ag)
(require 'helm-ag)

;;;;;;;;;;;;;;;;;;;;;
;;    yasnippet    ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(yas-reload-all)
(add-hook 'python-mode-hook #'yas-minor-mode)
(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)

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

