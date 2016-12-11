;; START SERVER
;; -----------------------------------------

(server-start)

;; INSTALL PACKAGES
;; -----------------------------------------

(require 'package)

(add-to-list 'load-path "~/.emacs.d/evil")
(add-to-list 'load-path "~/.emacs.d/undo-tree")
(add-to-list 'load-path "~/.emacs.d/evil-org-mode")
(add-to-list 'load-path "~/.emacs.d/evil-leader")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)


;; LOAD PLUGINS
;; ----------------------------------------------------

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy ;; python IDE
    flycheck ;; real-time syntax highlighting
    material-theme ;; Google-based theme
    py-autopep8)) ;; Pep8 enforcer

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)


;; evil org requirement
(require 'evil-leader)
(global-evil-leader-mode)


;; BASIC CUSTOMIZATION
;; ----------------------------------------------------

;; (setq inhibit-startup-message t) ;; hide the startup message
;; (load-theme 'material-light t)
(require 'color-theme-sanityinc-tomorrow)
(global-linum-mode t)


;; ORG MODE
;; ----------------------------------------------------

(require 'org)
(require 'evil-org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; ELPY SETTINGS
;; ----------------------------------------------------

(elpy-enable)
(elpy-use-ipython)


;; GENERAL SETTINGS
;; ----------------------------------------------------

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; AUTOPEP8 SETTINGS
;; ----------------------------------------------------

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)


;; Evil SETTINGS
;; ----------------------------------------------------

(require 'evil)
(require 'undo-tree)
(require 'evil-surround)
(global-evil-surround-mode 1)
(evil-leader/set-leader ",")
(evil-mode 1)

(setq evil-auto-indent 4)
(setq evil-shift-width 4)


;; POWERLINE SETTINGS
;; ----------------------------------------------------

(require 'powerline)
;; (powerline-default-theme)


;; POWERLINE SETTINGS
;; ----------------------------------------------------

;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-day)))
 '(custom-safe-themes
   (quote
    ("e97dbbb2b1c42b8588e16523824bc0cb3a21b91eefd6502879cf5baa1fa32e10" "2305decca2d6ea63a408edd4701edf5f4f5e19312114c9d1e1d5ffe3112cde58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" default)))
 '(hl-sexp-background-color "#121212")
 '(org-agenda-files (quote ("~/test1.org" "~/notes.org"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
