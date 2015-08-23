(provide 'setup-cedet)

;; semantic

(require 'semantic)

(global-semanticdb-minor-mode 1)
(setq semanticdb-default-save-directory "~/.emacs.d/")
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)

(semantic-mode 1)

;; ede

(require 'ede)
(global-ede-mode)

;; my own project
(ede-cpp-root-project "lisa-caffe-public"
                      :file "h:/nan/lisa-caffe-public/Makefile"
                      :include-path '("/include") ;; related to the project root directory
                      ;; :system-include-path '("/usr/include/boost")
					  )
