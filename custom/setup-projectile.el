(provide 'setup-projectile)

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
;; (setq projectile-indexing-method 'alien)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)

;; ag
(require 'grep)
(require 'ag)
(require 'helm-ag)

(setq projectile-switch-project-action 'helm-projectile-find-file)
