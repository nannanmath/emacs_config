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
;;      elpy       ;;
;;;;;;;;;;;;;;;;;;;;;
(elpy-enable)

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
(setq company-backends (delete 'company-clang company-backends))
(global-set-key (kbd "<C-tab>") 'company-complete)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-shell)
;;(add-to-list 'company-backends '(company-anaconda :with company-capf))

;;;;;;;;;;;;;;;;;;;;;
;;     semantic    ;;
;;;;;;;;;;;;;;;;;;;;;
(require 'semantic)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-local-symbol-highlight-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)


(require 'semantic/bovine/c)
(require 'semantic/bovine/gcc)
(require 'semantic/decorate/include)
(require 'stickyfunc-enhance)

;;;;;;;;;;;;;;;;;;;;;
;;     flycheck    ;;
;;;;;;;;;;;;;;;;;;;;;
(defun setup-flycheck-gcc-project-include-path ()
  (let* ((project-root (ignore-errors (projectile-project-root)))
         (proj-properties-file (concat project-root ".proj-properties")))
    (make-variable-buffer-local 'flycheck-gcc-include-path)
    (make-variable-buffer-local 'company-c-headers-path-user)
    (make-variable-buffer-local 'semantic-dependency-include-path)
    (if (file-exists-p proj-properties-file)
        (progn
          (setq
           my-include-path
           (with-temp-buffer
             (insert-file-contents proj-properties-file)
             (split-string (buffer-string) "\n" t)))
          (setq flycheck-gcc-include-path my-include-path)
          (setq company-c-headers-path-user my-include-path)
          (mapc
           (lambda (dir)
             (semantic-add-system-include dir 'c++-mode))
           my-include-path)
          )
      (message "project-properties file no exist! You can edit one in your project root dir and named .proj-properties."))))

(add-hook 'c-mode-hook #'flycheck-mode)
(add-hook 'python-mode-hook #'flycheck-mode)

(add-hook 'c++-mode-hook
          (lambda ()
            (semantic-mode 1)
            (flycheck-mode 1)
            (setq flycheck-gcc-language-standard "c++11"
                  flycheck-checker 'c/c++-gcc)
            (setup-flycheck-gcc-project-include-path)))

;;;;;;;;;;;;;;;;;;;;;
;;     flymake     ;;
;;;;;;;;;;;;;;;;;;;;;
;;(add-hook 'c++-mode-hook 'flymake-mode)
;;(add-hook 'c-mode-hook 'flymake-mode)
;;(add-hook 'python-mode-hook 'flymake-mode)

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
;; (setq gdb-many-windows t
;;			gdb-show-main t)

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

