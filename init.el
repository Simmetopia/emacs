(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)
(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 
(add-to-list 'default-frame-alist
                       '(font . "Hack-14"))
(setq-default line-spacing 5)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(use-package exec-path-from-shell :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(global-linum-mode t)
(use-package company :ensure t)
(use-package typescript-mode :ensure t)
(use-package lsp-mode
  :ensure t
  :commands lsp
  :init (lsp)
  :config
  (require 'lsp-clients)
)
(use-package flycheck :ensure t)

(use-package web-mode :ensure t)
(use-package tide :ensure t)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-ignore-duplicate t)
  ;; (add-hook 'lsp-ui-doc-frame-hook #'my/hide-frame-line-numbers)
  )

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config
  (push 'company-lsp company-backends)
  (setq company-lsp-async t
        company-lsp-cache-candidates 'auto
        company-lsp-enable-recompletion t))
(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'"
         "\\.mjs\\'")
  :hook ((js2-mode typescript-mode-hook) . lsp)
  :init
  (setq-default js2-ignored-warnings '("msg.extra.trailing.comma"
                                       "msg.missing.semi"
                                       "msg.no.side.effects")))

(use-package evil :ensure t)
(evil-mode 1)
(use-package org
  :ensure t)
(org-indent-mode 1)
(use-package helm :ensure t)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(use-package gruvbox-theme 
  :ensure t
  :config
  (load-theme 'gruvbox-dark-soft t)
  (let ((line (face-attribute 'mode-line :underline)))
    (set-face-attribute 'mode-line          nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :overline   line)
    (set-face-attribute 'mode-line-inactive nil :underline  line)
    (set-face-attribute 'mode-line          nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :box        nil)
    (set-face-attribute 'mode-line-inactive nil :background "#f9f2d9")))
(use-package minions
  :ensure t
  :init (minions-mode)
  :config
  (setq minions-mode-line-lighter "#"))
(use-package moody
  :ensure t
  :config
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))
(use-package magit :ensure t)
(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))
(use-package counsel :ensure t)
(use-package prettier-js :ensure t)
;; load keybinds
(load "~/.emacs.d/keybinds.el")
(add-hook 'org-mode-hook 'org-indent-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/documentation/it-minds/organizor.org" "~/documentation/organizor.org" "~/documentation/ergobasen/notes.org")))
 '(package-selected-packages
   (quote
    (json-mode helm company use-package projectile magit gruvbox-theme evil counsel))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
