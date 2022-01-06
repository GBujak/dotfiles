;;; Startup
;;; PACKAGE LIST
(setq package-archives 
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))

;;; BOOTSTRAP USE-PACKAGE
(package-initialize)
(setq use-package-always-ensure t)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))



;;; OTHER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(set-frame-font "Ubuntu Mono 14" nil t)

(use-package vertico
  :config
  (vertico-mode))
 
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))



;;; END OTHER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;; EVIL MODE RELATED
;;; UNDO
;; Vim style undo not needed for emacs 28
(use-package undo-fu)

;;; Vim Bindings
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1))

;;; Vim Bindings Everywhere else
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))
