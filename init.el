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
    company-anaconda 
    company-c-headers 
    ein 
    helm 
    magit 
    python-mode 
    markdown-mode))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))



;; setup custom el file
(add-to-list 'load-path "~/.emacs.d/custom")
(require 'setup-common)
(require 'setup-helm)
; require 'setup-ggtags)
; (require 'setup-window)
; (require 'setup-cedet)
(require 'setup-company)
; (require 'setup-projectile)
(require 'setup-prog-edit)
; (require 'setup-compilation)
; (require 'setup-debug)
(require 'ein)
(require 'setup-markdown)









