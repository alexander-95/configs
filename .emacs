;; shift direction to change between buffers
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(global-set-key "\M-[1;2A" 'windmove-up)
(global-set-key "\M-[1;2B" 'windmove-down)
(global-set-key "\M-[1;2C" 'windmove-right)
(global-set-key "\M-[1;2D" 'windmove-left)

;; highlight current line, disable for term buffers
(global-hl-line-mode 1)
(add-hook 'eshell-mode-hook (lambda ()
			      (setq-local global-hl-line-mode
					  nil)))
(add-hook 'term-mode-hook (lambda ()
			    (setq-local global-hl-line-mode
					nil)))

;; To customize the background color
(set-face-background 'hl-line "#000")
(set-face-foreground 'hl-line "#FFF")

;; allows opening new shells with unique names using f5
(defun my-list-buffers (&optional arg)
"Display a list of existing buffers.
The list is displayed in a buffer named \"*Buffer List*\".
See `buffer-menu' for a description of the Buffer Menu.
By default, all buffers are listed except those whose names start
with a space (which are for internal use).  With prefix argument
ARG, show only buffers that are visiting files."
  (interactive "P")
  (switch-to-buffer (list-buffers-noselect arg)))

;; open shell buffers in current window. This was default behaviour until emacs25
(add-to-list 'display-buffer-alist
             '("^\\*shell\\*$" . (display-buffer-same-window)))
(add-to-list 'display-buffer-alist
             '("^\\*term\\*$" . (display-buffer-same-window)))
(add-to-list 'display-buffer-alist
             '("^\\*ansi-term\\*$" . (display-buffer-same-window)))


;; press f5 for new terminal
(define-key ctl-x-map "\C-b" 'my-list-buffers)
(global-set-key (kbd "<f5>") (lambda () (interactive) (shell) (rename-uniquely)))
(global-set-key (kbd "<f6>") (lambda () (interactive) (term "/bin/bash") (rename-uniquely)))
(global-set-key (kbd "<f7>") (lambda () (interactive) (ansi-term "/bin/bash") (rename-uniquely)))

;; read-only shells
(setq comint-prompt-read-only t)

(defun my-comint-preoutput-turn-buffer-read-only (text)
  (propertize text 'read-only t))

(add-hook 'comint-preoutput-filter-functions 'my-comint-preoutput-turn-buffer-read-only)

;; highlight frame of current buffer
(set-face-attribute  'mode-line
		     nil
		     :foreground "yellow"
		     :background "gray25"
		     :box '(:line-width 1 :style released-button))
(set-face-attribute  'mode-line-inactive
		     nil
		     :foreground "white"
		     :background "black"
		     :box '(:line-width 1 :style released-button))

;; scroll 1 line at a time instead of default half a page
(setq scroll-step 1
      scroll-conservatively 10000)

;; tabs to spaces
(setq-default indent-tabs-mode nil)

;; proper indentation for c-style languages
(setq c-default-style "bsd")
(setq c-basic-offset 4)

;; gid
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp")) (autoload 'gid "idutils" nil t)

;; change highlight colors
(set-face-attribute 'region nil :background "#0FF")
(set-face-attribute 'region nil :foreground "#000")
(set-face-attribute 'isearch nil :background "#0FF")
(set-face-attribute 'isearch nil :foreground "#000")
(set-face-attribute 'lazy-highlight nil :background "#F0F")
(set-face-attribute 'lazy-highlight nil :foreground "#000")
