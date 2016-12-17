
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
				sr-speedbar
				ein
				magit
				anaconda-mode
				company-anaconda
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

