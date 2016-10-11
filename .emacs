;;shift direction to change between buffers
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(global-hl-line-mode 1)
 
;; To customize the background color
(set-face-background 'hl-line "#030")  ;; Emacs 22 Only

;;allows buffers to be changed correctly
(defun my-list-buffers (&optional arg)
"Display a list of existing buffers.
The list is displayed in a buffer named \"*Buffer List*\".
See `buffer-menu' for a description of the Buffer Menu.
By default, all buffers are listed except those whose names start
with a space (which are for internal use).  With prefix argument
ARG, show only buffers that are visiting files."
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))

;;press f5 for new terminal
(define-key ctl-x-map "\C-b" 'my-list-buffers)
(global-set-key (kbd "<f5>") (lambda () (interactive) (shell) (rename-uniquely)))
