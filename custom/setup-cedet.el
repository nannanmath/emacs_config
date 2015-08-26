(provide 'setup-cedet)

;; semantic

(require 'semantic)

(global-semanticdb-minor-mode 1)
(setq semanticdb-default-save-directory "~/.emacs.d/")
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)
(add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb)))

(semantic-mode 1)

;; speedbar

(require 'sr-speedbar)
(setq 
    speedbar-show-unknown-files t
    speedbar-use-images nil
    speedbar-width-x 30
    speedbar-width-console 30
    speedbar-max-width 30
    sr-speedbar-right-side nil
    sr-speedbar-delete-windows t
)
(add-hook 'emacs-startup-hook (lambda ()
    (sr-speedbar-open)
    (with-current-buffer sr-speedbar-buffer-name
    (setq window-size-fixed 'width))
))
(add-hook 'speedbar-mode-hook (lambda () 
    (linum-mode -1)
))
(add-hook 'speedbar-load-hook (lambda () 
    (require 'semantic/sb)
))

;; ede

(require 'ede)
(global-ede-mode)

;; my own project
(ede-cpp-root-project "lisa-caffe-public"
                      :file "h:/nan/lisa-caffe-public/Makefile"
                      :include-path '("/include") ;; related to the project root directory
                      :system-include-path '("/usr/include/boost")
					  )

