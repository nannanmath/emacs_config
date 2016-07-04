(provide 'setup-latex)

;;;;;;;;;;;;;;;;;;;;;;
;;      auctex      ;;
;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'LaTeX-mode-hook (lambda()
														 (setq TeX-auto-save t)
														 (setq TeX-parse-self t)
														 (setq TeX-master nil)
														 (turn-off-auto-fill)
														 (linum-mode 1)
														 (LaTeX-math-mode 1)
														 (outline-minor-mode 1)
														 (setq TeX-view-program-list '(("Evince" "evince %o")))
														 (setq TeX-view-program-selection '((output-pdf "Evince")))
														 (setq TeX-global-PDF-mode t)
														 (setq TeX-engine 'xetex)
														 (add-to-list 'TeX-command-list
																					'("XeLaTex" "%'xelatex%(mode) --shell-escape%' %t"
																						TeX-run-TeX nil t))
														 (setq TeX-command-defaullt "XeLaTeX")
														 (latex-preview-pane-enable)))


;;;;;;;;;;;;;;;;;;;;;;
;; cdlatex & reftex ;;
;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)


;;;;;;;;;;;;;;;;;;;;;;;;
;; magic-latex-buffer ;;
;;;;;;;;;;;;;;;;;;;;;;;;
(require 'magic-latex-buffer)
(add-hook 'latex-mode-hook 'magic-latex-buffer)
