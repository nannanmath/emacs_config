(provide 'setup-common)

;; startup setting
(setq inhibit-startup-message t)
(global-linum-mode t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(custom-set-variables '(initial-frame-alist '((fullscreen . maximized))))
(defalias 'yes-or-no-p 'y-or-n-p)

;; color theme
(load-theme 'zenburn t)

;; paren
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; show buffer name on window bar 
(setq frame-title-format "emacs@%b")

;; powerline
;; (require 'telephone-line)
;; (telephone-line-mode 1)

;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; windmove
(windmove-default-keybindings)

;; whitespace
(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET
;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; use space to indent by default
;; (setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; mark
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "M-SPC") 'set-mark-command)

;; backup files
(setq backup-directory-alist '(("." . "~/backups")))
(setq backup-by-copying t)

;; auto save 
(setq auto-save-mode nil)
