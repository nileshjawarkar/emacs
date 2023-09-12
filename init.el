;; Do not show the startup screen
(setq inhibit-startup-message t)

;; Disable tool bar, menu bar, scroll bar.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(toggle-scroll-bar -1)

;; Some other settings
(blink-cursor-mode -1)
(global-hl-line-mode +1)
(line-number-mode +1)
(global-display-line-numbers-mode +1)
(column-number-mode t)
(size-indication-mode t)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(use-package auto-compile
    :straight t
    :config (auto-compile-on-load-mode))
(setq load-prefer-newer t)

(set-face-attribute 'default nil :font "SauceCodePro Nerd Font" :height 120)
;;(set-face-attribute 'default nil :font "Mononoki Nerd Font" :height 130)
(add-to-list 'default-frame-alist '(font . "SauceCodePro Nerd Font"))
(add-to-list 'default-frame-alist '(height . 35))
(add-to-list 'default-frame-alist '(width . 135))
(setq-default line-spacing 0.12)

(use-package nerd-icons
    :straight t)

(use-package doom-themes
    :straight t
    :ensure t
    :config
    (load-theme 'doom-one t)
    (doom-themes-visual-bell-config))

(use-package doom-modeline
    :straight t
    :ensure t
    :init (doom-modeline-mode 1))

(use-package evil
    :straight t
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    (setq evil-vsplit-window-right t)
    (setq evil-split-window-below t)
    (evil-mode))
(use-package evil-collection
    :straight t
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (add-to-list 'evil-collection-mode-list 'help)
    (evil-collection-init))

(use-package org
    :straight t
    :ensure t)

(add-hook 'org-mode-hook 'org-indent-mode)
;; Org mode source blocks have some really weird and annoying default indentation behavior, disable it.
(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(use-package org-bullets
  :straight t)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-hide-leading-stars t)

(use-package toc-org
    :straight t
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(require 'org-tempo)

(use-package general
  :straight t
  :config
  (general-evil-setup)

  ;; set up space as the global leader key
  (general-create-definer nj/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

    (nj/leader-keys
        "." '(find-file :wk "Find file")
        "TAB TAB" '(comment-line :wk "Comment lines"))

    (nj/leader-keys
        "b" '(:ignore t :wk "buffer")
        "bb" '(switch-to-buffer :wk "Switch buffer")
        "bk" '(kill-this-buffer :wk "Kill this buffer")
        "bn" '(next-buffer :wk "Next buffer")
        "bp" '(previous-buffer :wk "Previous buffer")
        "br" '(revert-buffer :wk "Reload buffer"))

    (nj/leader-keys
        "h" '(:ignore t :wk "Help")
        "h f" '(describe-function :wk "Describe function")
        "h v" '(describe-variable :wk "Describe variable")
        "h r r" '(reload-init-file :wk "Reload emacs config"))

    (nj/leader-keys
        "m" '(:ignore t :wk "Org")
        "m a" '(org-agenda :wk "Org agenda")
        "m l" '(org-agenda-list :wk "List agenda")
        "m n" '(org-agenda-file-to-front :wk "Add agenda from new file")
        "m r" '(org-remove-file :wk "Remove agenda from current file")
        "m s" '(org-schedule :wk "Schedule todo")
        "m i" '(org-toggle-item :wk "Toggle item")
        "m t" '(org-todo :wk "Toggle todo")
        "m x" '(org-ctrl-c-ctrl-c :wk "Toggle checkbox")
        "m e" '(org-export-dispatch :wk "Org export dispatch")
        "m B" '(org-babel-tangle :wk "Org babel tangle")
        "m T" '(org-todo-list :wk "Org todo list"))
)

(defun reload-init-file ()
    (interactive)
    (load-file user-init-file)
    (load-file user-init-file))

(use-package which-key
    :straight t
    :init
    (which-key-mode 1)
    :config
    (setq which-key-side-window-location 'bottom
    which-key-sort-order #'which-key-key-order-alpha
    which-key-sort-uppercase-first nil
    which-key-add-column-padding 1
    which-key-max-display-columns nil
    which-key-min-display-lines 6
    which-key-side-window-slot -10
    which-key-side-window-max-height 0.25
    which-key-idle-delay 0.8
    which-key-max-description-length 25
    which-key-separator " -> " ))
