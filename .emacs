;;shift direction to change between buffers
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(global-hl-line-mode 1)
 
;; To customize the background color
(set-face-background 'hl-line "#010")

;;allows opening new shells with unique names using f5
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


;;read-only shells
(setq comint-prompt-read-only t)

(defun my-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))

(add-hook 'comint-preoutput-filter-functions 'my-comint-preoutput-turn-buffer-read-only)


;;highlight frame of current buffer
(set-face-attribute  'mode-line
		     nil
		     :foreground "gray80"
		     :background "gray25"
		     :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
		     nil
		     :foreground "gray30"
		     :background "black"
		     :box '(:line-width 1 :style released-button))
