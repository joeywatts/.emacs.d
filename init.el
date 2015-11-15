(setq user-full-name "Joey Watts"
      user-mail-address "joey.watts.96@gmail.com")
;;------------------------------------------------------------------
;; Package.el
;;-------------------------------------------------------------------
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;; Install (and enable) use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
;;------------------------------------------------------------------
;; Initial Configuration
;;------------------------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)  ;; only type 'y' or 'n' instead of 'yes' or 'no'
(setq inhibit-splash-screen t)  ;; no splash screen
(setq initial-scratch-message nil)  ;; no message on startup
(menu-bar-mode -1)  ;; no menu bar
(setq fill-column 80)  ;; M-q
(when (functionp 'tool-bar-mode)
  (tool-bar-mode -1))  ;; no toolbar
(if window-system
    (progn
      (scroll-bar-mode -1)  ;; disable scroll bars
      (set-frame-font "Inconsolata 14"))) ;; set font
(setq mac-allow-anti-aliasing t)  ;; nice fonts in OS X
(setq-default truncate-lines 1)  ;; no word wrap
(setq-default line-spacing 4) ;; add line spacing
(setq-default cursor-type 'bar) ;; set cursor to bar
(setq mac-option-modifier 'super) ;; set option to super
(setq mac-command-modifier 'meta) ;; set command to meta

;; Keybindings for resizing windows.
(global-set-key (kbd "C-s-<down>") 'enlarge-window)
(global-set-key (kbd "C-s-<up>") 'shrink-window)
(global-set-key (kbd "C-s-<left>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-s-<right>") 'shrink-window-horizontally)

;; Bookmark Shortcuts
(global-set-key (kbd "s-`") `bookmark-jump)

;; Add /usr/local/bin to exec-path
(setq exec-path (append exec-path '("/usr/local/bin")))

;; Add LaTeX to exec-path
(setq exec-path (append exec-path '("/usr/texbin")))

;; Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

;; when cursor is on edge, move to the other side, as in a toroidal space
(setq windmove-wrap-around t)

;; Fix tabs
(setq-default indent-tabs-mode t
			  tab-width 4)

;; JS mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))

;; Backup directory
(setq backup-by-copying t      ; don't clobber symlinks
	  backup-directory-alist '(("." . "~/.saves"))    ; don't litter my fs tree
	  delete-old-versions t
	  kept-new-versions 6
	  kept-old-versions 2
	  version-control t)       ; use versioned backups

;; Tramp default method to ssh.
(setq tramp-default-method "ssh")

;;------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-interval 0.3)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
	("cd2a93d7b63aff07b3565c1c95e461cb880f0b00d8dd6cdd10fa8ece01ffcfdf" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "4f2ede02b3324c2f788f4e0bad77f7ebc1874eff7971d2a2c9b9724a50fb3f65" "1177fe4645eb8db34ee151ce45518e47cc4595c3e72c55dc07df03ab353ad132" "11636897679ca534f0dec6f5e3cb12f28bf217a527755f6b9e744bd240ed47e1" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "afc220610bee26945b7c750b0cca03775a8b73c27fdca81a586a0a62d45bbce2" default)))
 '(frame-background-mode (quote dark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;------------------------------------------------------------------
;; Packages
;;------------------------------------------------------------------
;; Color theme
(use-package gruvbox-theme
  :ensure
  :config
  (load-theme 'gruvbox t))

;; Bookmark+
(use-package bookmark+
  :ensure)

;; Turn on projectile
(use-package projectile
  :ensure
  :diminish ""
  :config
  (projectile-global-mode)
  :init)

;; Helm
(use-package helm
  :ensure
  :config
  (require 'helm-config)
  (helm-mode 1))

;; Helm CMD-T
(use-package helm-cmd-t
  :ensure
  :bind
  ("M-t" . helm-cmd-t))

;; Helm Projectile
(use-package helm-projectile
  :ensure
  :config
  (helm-projectile-on)
  :init)

;; Magit
(use-package magit
  :ensure
  :bind
  ("C-x g" . magit-status)
  ("C-c C-a" . magit-commit-amend))

;; Git Time Machine
(use-package git-timemachine
  :ensure)

;; Undo tree
(use-package undo-tree
  :ensure
  :config
  (global-undo-tree-mode 1)
  :bind
  ("C-z" . undo-tree-undo)
  ("C-S-z" . undo-tree-redo))

;; Ensime (Scala auto-complete)
(use-package ensime
  :ensure
  :config
  ;; Add sbt, scalac to PATH
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))

;; Enable line numbers globally.
(use-package linum
  :config
  (progn
    (global-linum-mode t)
    (column-number-mode)))

;; Smart Mode Line
(use-package smart-mode-line
  :ensure
  :config
  (setq sml/no-config-load-theme t)
  (setq sml/theme 'dark)
  (add-hook 'after-init-hook 'sml/setup))

;; Gradle files => Groovy syntax highlighting
(use-package groovy-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.gradle\\'" . groovy-mode)))

;; PHP mode
(use-package php-mode
  :ensure
  :config
  (add-hook 'php-mode-hook 'my-php-mode-hook)
  (defun my-php-mode-hook ()
	(setq indent-tabs-mode t)
	(let ((my-tab-width 4))
	  (setq auto-indent-backward-delete-char-behavior nil)
	  (setq tab-width my-tab-width)
	  (setq c-basic-indent my-tab-width)
	  (set (make-local-variable 'tab-stop-list)
		   (number-sequence my-tab-width 200 my-tab-width)))))

;; Geben PHP Debugger
;;(use-package geben
;;  :ensure)

;; Git gutter
(use-package git-gutter-fringe+
  :ensure
  :config
  (global-git-gutter+-mode)
  (eval-after-load 'git-gutter+
    '(progn
       ;; Jump between hunks
       (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
       (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
                  ;;; Act on hunks
       (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
       (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
       ;; Stage hunk at point.
       ;; If region is active, stage all hunk lines within the region.
       (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
       (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
       (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
       (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
       (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer))))

;; Dired+
(use-package dired+
  :ensure)

;; Popwin
(use-package popwin
  :ensure
  :config
  (popwin-mode 1)
  (push "*Kill Ring*" popwin:special-display-config))

;;------------------------------------------------------------------
;; Functions
;;------------------------------------------------------------------

;; Open next/previous line commands
(defun open-next-line (arg)
  "Move to the next line and then opens a line. See also `newline-and-indent'."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (next-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))
(defun open-previous-line (arg)
  "Open a new line before the current one. See also `newline-and-indent'."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))
(global-set-key [S-return] 'open-next-line)
(global-set-key [C-S-return] 'open-previous-line)

;; Refresh major mode. (sometimes php syntax highlighting screws up)
(defun refresh-major-mode ()
  "Sets the current buffer's major mode to fundamental mode, then
resets your previous major mode."
  (interactive)
  (let ((mode (buffer-local-value 'major-mode (current-buffer))))
	(funcall 'fundamental-mode)
	(funcall mode)))

;; Reload current file.
(defun reload-current-file ()
  "Reverts the current buffer, asking for confirmation only if it is modified"
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))

;;------------------------------------------------------------------
