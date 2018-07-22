(setq gc-cons-threshold 100000000)

;; no menu bar
(menu-bar-mode -1)

;; Disable tool bar
(tool-bar-mode -1)

;; disable scroll bars
(scroll-bar-mode -1)

;; No splash screen
(setq inhibit-splash-screen t)

;; no message on startup
(setq initial-scratch-message nil)

;; set font
(add-to-list 'default-frame-alist '(font . "Inconsolata-16"))
(set-face-attribute 'default nil :font "Inconsolata-16")

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(package-refresh-contents)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package doom-themes
  :ensure t
  :init (setq org-fontify-whole-heading-line t
              org-fontify-done-headline t
              org-fontify-quote-and-verse-blocks t)
  :config (progn
            (load-theme 'doom-tomorrow-night t)
            ; (add-hook 'find-file-hook 'doom-buffer-mode)
            ))

; C-u C-x =
(add-to-list 'default-frame-alist '(background-color . "#050505"))
(set-background-color "#050505")

(use-package rainbow-delimiters
  :ensure t
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package evil
  :ensure t
  ; :init (setq evil-search-module (quote evil-search))
  ;; :init (setq evil-want-C-u-scroll t)
  :config (progn
            (evil-mode 1)
            (defalias #'forward-evil-word #'forward-evil-symbol)))

(use-package sentence-navigation
  :ensure t
  ;; autoloads will be created for all commands and text objects
  ;; when installed with package.el
  :defer t)

(define-key evil-motion-state-map ")" 'sentence-nav-evil-forward)
(define-key evil-motion-state-map "(" 'sentence-nav-evil-backward)

;; (use-package evil-snipe
;;   :ensure t
;;   :init (setq evil-snipe-scope 'whole-buffer)
;;   :config (progn
;;             (evil-snipe-mode 1)
;;             (add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)))

(use-package neotree
  :ensure t)
(setq neo-smart-open t)

; https://www.emacswiki.org/emacs/NeoTree#toc12
(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-quick-look)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

(use-package evil-magit
  :ensure t)

(use-package swiper
  :ensure t)

(use-package smex
  :ensure t)

(use-package haskell-mode
  :mode (("\\.hs" . haskell-mode)
         ("\\.yaml" . haskell-mode)
         )
  :ensure t)

(use-package intero
  :config (add-hook 'haskell-mode-hook 'intero-mode)
  :ensure t
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(alchemist-test-status-modeline nil)
 '(haskell-stylish-on-save t)
 '(org-agenda-files (quote ("~/todo.org")))
 '(package-selected-packages
   (quote
    (python-mode elpy hydra intero haskell-mode dracula-theme sentence-navigation fill-column-indicator neotree idris idris-mode smex yasnippet which-key use-package rainbow-delimiters pandoc-mode markdown-mode ivy-hydra evil-snipe evil-magit doom-themes darkroom counsel company-jedi alchemist))))

(use-package elpy
  :ensure t
)
(elpy-enable)


(use-package idris-mode
  :mode (("\\.idr$" . idris-mode)
         ("\\.lidr$" . idris-mode))
  :defer t
  ;; :config
  ;; (defun my/idris-mode-defaults ()
  ;;   (flycheck-mode -1))
  ;; (add-hook 'idris-mode-hook 'my/idris-mode-defaults)
)
(setq idris-stay-in-current-window-on-compiler-error t)


(use-package ivy
  :ensure t
  :init (setq ivy-use-virtual-buffers t
                ivy-height 10
                ivy-count-format "(%d/%d) ")
  :bind (("C-c C-r" . ivy-resume)
         :map ivy-minibuffer-map ("RET" . ivy-alt-done))
  :config (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind ("M-x" . counsel-M-x))

(use-package hydra
  :ensure t)

(use-package ivy-hydra
  :ensure t)

(use-package company
  :ensure t
  :init (global-company-mode)
  :config (setq company-idle-delay 2
                company-minimum-prefix-length 2))
; (with-eval-after-load 'company
;   (define-key company-active-map (kbd "<return>") nil)
;   (define-key company-active-map (kbd "RET") nil)
;   (define-key company-active-map (kbd "C-SPC") #'company-complete-selection))

(global-set-key (kbd "C-SPC") 'company-complete)
(define-key company-active-map (kbd "C-SPC") 'company-complete-common-or-cycle)

(use-package company-jedi
  :ensure t
  :config (add-to-list 'company-backends 'company-jedi))

(use-package org
  :ensure t
  :init (setq org-agenda-window-setup 'current-window))

(use-package linum
  :init (setq linum-format "%3d ")
  :config (add-hook 'prog-mode-hook 'linum-mode t))

(use-package yasnippet
  :ensure t
  :config (progn
	    (yas-reload-all)
	    (add-hook 'prog-mode-hook #'yas-minor-mode)))

(use-package magit
  :ensure t
  :bind (("C-c m" . magit-status))
  :init (add-hook 'after-save-hook 'magit-after-save-refresh-status))

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc -c ~/.emacs.d/github-pandoc.css --from markdown_github -t html5 --mathjax --highlight-style pygments --standalone"))

(use-package pandoc-mode
  :ensure t
  :config (add-hook 'markdown-mode-hook 'pandoc-mode))

(use-package project
  :bind ("C-x f" . project-find-file))

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package darkroom
  :ensure t)

; (add-hook 'prog-mode-hook 'whitespace-mode)

;; Enable S-{left, right, up, down} to switch window focus
(windmove-default-keybindings)
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "emacs-backups")))))

;; Write temp files to own directory
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name
                 (concat user-emacs-directory "auto-save")) t)))


;; Use X clipboard
(setq x-select-enable-clipboard t
      x-select-enable-primary t)

;; Disable blinking cursor
(blink-cursor-mode -1)

;; delete trailing whitespace in all modes
(add-hook 'before-save-hook #'delete-trailing-whitespace)

(setq-default indent-tabs-mode nil)

;; set encoding
(prefer-coding-system 'utf-8)

;; and tell emacs to play nice with encoding
(define-coding-system-alias 'UTF-8 'utf-8)
(define-coding-system-alias 'utf8 'utf-8)

;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position t)

;; scroll one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
(setq scroll-margin 3)

;; prefer vertical splits if there is enough space
(setq split-height-threshold nil)
(setq split-width-threshold 160)



; C-u C-x =
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face :foreground "gray39"))))
 '(region ((t (:background "dark slate gray")))))

(set-default 'truncate-lines t)

;;; C-g as general purpose escape key sequence.
(defun my-esc (prompt)
   ;; "Functionality for escaping generally.  Includes exiting Evil insert state and C-g binding. "
  (cond
   ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
   ;; Key Lookup will use it.
   ((or (evil-insert-state-p)
        ;; (evil-normal-state-p)
        (evil-replace-state-p)
        (evil-visual-state-p)) [escape])
   ;; This is the best way I could infer for now to have C-c work during evil-read-key.
   ;; Note: As long as I return [escape] in normal-state, I don't need this.
   ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
   (t (kbd "C-g"))))
(define-key key-translation-map (kbd "C-g") 'my-esc)
;; Works around the fact that Evil uses read-event directly when in operator state, which
;; doesn't use the key-translation-map.
(define-key evil-operator-state-map (kbd "C-g") 'keyboard-quit)
;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;; documentation of it.
(set-quit-char "C-g")


(defun init-file ()
  ;; "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))

(setq vc-follow-symlinks nil)

(define-key evil-insert-state-map (kbd "C-x C-l") 'hippie-expand)
; (define-key evil-ex-search-keymap (kbd "<escape>") 'minibuffer-keyboard-quit)

; Propagate done TODO items
; From https://orgmode.org/manual/Breaking-down-tasks.html#Breaking-down-tasks
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
