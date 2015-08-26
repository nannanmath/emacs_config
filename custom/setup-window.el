(provide 'setup-window)

;; ehsell
(defun open-eshell-other-buffer ()
  "Open eshell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))
  
(global-set-key [(f8)] 'open-eshell-other-buffer)

;; open file from speedbar
(defun split-next-window ()
  (split-window-horizontally)
  )

(defun my-sr-speedbar-open-hook ()
  (add-hook 'speedbar-before-visiting-file-hook 'split-next-window t)
  (add-hook 'speedbar-before-visiting-tag-hook 'split-next-window t)
  )

(advice-add 'sr-speedbar-open :after 'my-sr-speedbar-open-hook)

