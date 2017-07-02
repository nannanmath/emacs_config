
																				; (setq url-proxy-services
;   '(("no_proxy" . "^\\(localhost\\|10.*\\)")
;      ("http" . "proxy-prc.intel.com:911")
;      ("https" . "proxy-prc.intel.com:911")))


(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq my-packages
			'(zenburn-theme
				exec-path-from-shell
				modern-cpp-font-lock
				elscreen
				elscreen-persist
				desktop+
				bm
				helm
				highlight-indent-guides
				yafolding
				crosshairs
				cff
				flycheck
				sphinx-doc
				projectile
				helm-projectile
				ag
				helm-ag
				company
				company-c-headers
				company-math
				company-shell
				stickyfunc-enhance
				ggtags
				yasnippet
				cmake-mode
				realgud
				sr-speedbar
				ein
				magit
				elpy
				markdown-mode
				auctex
				cdlatex
				company-auctex
				magic-latex-buffer
				shell-pop))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))



;; setup custom el file
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'setup-common)
(require 'setup-helm)
; (require 'setup-window)
; (require 'setup-projectile)
(require 'setup-prog-edit)
; (require 'setup-compilation)
; (require 'setup-debug)
(require 'ein)
(require 'setup-markdown)
(require 'setup-latex)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (shell-pop magic-latex-buffer company-auctex cdlatex auctex markdown-mode elpy magit ein sr-speedbar realgud cmake-mode yasnippet ggtags stickyfunc-enhance company-shell company-math company-c-headers company helm-ag ag helm-projectile projectile sphinx-doc flycheck cff crosshairs yafolding highlight-indent-guides helm bm desktop+ elscreen-persist elscreen modern-cpp-font-lock exec-path-from-shell zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
