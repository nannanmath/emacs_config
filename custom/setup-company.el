(provide 'setup-company)

(require 'cc-mode)
;; (require 'python-mode)
(require 'company)

(dolist (hook (list
	'emacs-lisp-mode-hook
	'lisp-mode-hook
	'lisp-interaction-mode-hook
	'c-mode-hook
	'c++-mode-hook
	'python-mode-hook
	'sh-mode-hook
	))
(add-hook hook 'company-mode))

(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-backends 'company-semantic)
(setq company-backends (delete 'company-clang company-backends))

(define-key c-mode-map  [(control tab)] 'company-complete)
(define-key c++-mode-map  [(control tab)] 'company-complete)
;; (define-key python-mode-map  [(control tab)] 'company-complete)


