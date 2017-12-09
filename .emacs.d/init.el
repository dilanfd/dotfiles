;; init.el --- Emacs configuration of Dilan Fernando
(setq user-full-name "Dilan Fernando")
(setq user-mail-address "dilan.fd@gmail.com")

;; Show date and time on status bar
 (display-time-mode 1)

;; Set up the customize file to its own separate file,
;; instead of saving customize settings in init.el.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
;; end of setting for saving to custom.el file

;; INSTALL PACKAGES
;; --------------------------------------
(require 'package)
(add-to-list 'package-archives
                    '("melpa" . "https://melpa.org/packages/") t)
;;(add-to-list 'package-archives
;;                     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(add-to-list 'package-archives
                    '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(defalias 'pi 'package-install)         ;copied from rommel maritnez
(defalias 'pl 'package-list-packages)   ;copied from rommel maritinez

;; ======================= initialization end =============================

;; =========================== emacsclient set up ==================
;; (server-start)
;; Start the server first, but only if emacs is not currently running.
(require 'server)
(unless (server-running-p) (server-start))
;; =========================== emacsclient set up end =============


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; ======== better comments using comment-dwim-2 ========
(global-set-key (kbd "M-;") 'comment-dwim-2)
;; ======== better comments end ================

;; tab = 4 spaces. TAB
(setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))
;; tab = 4 spaces end. TAB


;; configuration for markdown files.
(use-package markdown-mode
    :ensure t
    :config
    (progn
      (push '("\\.text\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.markdown\\'" . markdown-mode) auto-mode-alist)
      (push '("\\.md\\'" . markdown-mode) auto-mode-alist)))
;; copied from rommel martinez.

;; use smart parenthesis. a popular package. I need
(require 'smartparens-config)
;; we use :add to keep any global handlers. If you want to replace
;; them, simply specify the "bare list" as an argument:
;; '(my-open-block-c-mode)

;; This makes inserting { behave in the c-language way. Very important
;; after disabling auto-pair mode.
(sp-local-pair 'c-mode "{" nil :post-handlers '(:add my-open-block-c-mode))
(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))


(sp-local-pair 'c++-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent. "
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))
;; smartparens config end.


;; ivy-swyper-counsel config ====================
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x) 
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "<f1> f") 'counsel-describe-function)
;;(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;;(global-set-key (kbd "C-c g") 'counsel-git)
;;(global-set-key (kbd "C-c j") 'counsel-git-grep)
;;(global-set-key (kbd "C-c k") 'counsel-ag)
;;(global-set-key (kbd "C-x l") 'counsel-locate)
;;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;;(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
;;================ ivy-swyper-counsel config end =================

;; show nice mode icons for git branch etc.
;; (mode-icons-mode)

(use-package ensime
       :ensure t
       :pin melpa)
;;(require 'ess-rutils)
;; ======================= auto-complete and yasnippet ===========================
;; first yasnippet so that it works well with auto-complete.
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-triggers-in-field t)          ;snippet inside snippet trigger
;;===========yas expand using C-TAB ===========
;; there will be no conflicts with indent-according-to-mode
;; and jedi and other auto completion stuff. Nice workaround.
;; (define-key yas-minor-mode-map (kbd "<tab>") nil)
;; (define-key yas-minor-mode-map (kbd "TAB") nil)
;; (define-key yas-minor-mode-map (kbd "<C-tab>") 'yas-expand)
;; ========== yasnippts end =================

;;============ Auto Complte settings =============
(require 'auto-complete)                ;require auto complete
(setq ac-dwim t)                        ;do what I mean
(ac-config-default)                     ;use default configs
(setq ac-sources '(ac-source-yasnippet  ;tells ac source to use yasnippets.
ac-source-abbrev
ac-source-words-in-same-mode-buffers))  ;self explanatory.
;; auto complete only starts on 'TAB' press
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")

;; auto-complete settings
;; auto-complete is required by
;; jedi so can't uninstall.
;; (require 'auto-complete-config)
;; (ac-config-default)
;;; set the trigger key so thta together with yasnippet on tab key
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
;; (ac-set-trigger-key "TAB")
;; (ac-set-trigger-key "<tab>")
;; (setq-default ac-sources (push 'ac-source-yasnippet ac-sources))

;; enable global auto-complete mode.
;; (global-auto-complete-mode t)

;; C auto-complete configuration.
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)

;; make highlighted selction more readable.
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")


;;========== yasnippet and autocomplete end =============

;; NO BACKUP FILES. ANNOYING!!! Use GIT FFS
(setq make-backup-files nil) ; stop creating ~ files


;; enable and use autocomplete globally..
;; new company mode. hopefully works well with yasnippet.
(add-hook 'after-init-hook 'global-company-mode)
;;(require 'auto-complete)
;;(ac-config-default)

;; ============ open smart line above =============
(defun smart-open-line-above ()
 "Insert an empty line above the current line.
  Position the cursor at it's beginning, according to the current mode."
    (interactive)
    (move-beginning-of-line nil)
    (newline-and-indent)
    (forward-line -1)
    (indent-according-to-mode))

(global-set-key (kbd "M-o") 'smart-open-line-above)
;;(global-set-key (kbd "M-O") 'smart-open-line-above)
;; ============== open smart line above end ============

;;(define-key ac-mode-map (kbd "TAB") 'auto-complete)
;;(setq tab-always-indent ‘auto-complete)

;;disable ensime start up notification
(setq ensime-startup-snapshot-notification 'nil)

;; use helm
(require 'helm-config)

;; use ENSIME for scala
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; Setting up Expand Region. Selecting word, paragraph, function
;; etc quicker.
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(when (not package-archive-contents)
(package-refresh-contents))
;; set default font and size.

(set-frame-font "Monaco-16" nil t)

(defvar myPackages
   '(better-defaults
     ein
     elpy
     magit
     flycheck
     solarized-theme
     material-theme
     py-autopep8))
(mapc #'(lambda (package)
     (unless (package-installed-p package)
     (package-install package)))
      myPackages)
;;making sure shell and eshell do the same thing.
;; exports path from the shell to emacs shell etc.
(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))
;;magit (git) configuration.
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; automatically close open parentheis of any kind.
;; (require 'autopair) ;; no longer required becuase smartparens installed.
;; (autopair-global-mode 1)

;; interactive do mode.
(require 'ido)
(ido-mode t)

;;powerline mode.
;;(require 'powerline)
;;(powerline-default-theme)
;; the famous spaceline status bar for emacs
;;(require 'spaceline-config)
;;(spaceline-spacemacs-theme)
;; Start emacs infront of terminal.
(x-focus-frame nil)


;; python-jedi mode. Helps with python autocompletion etc.
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)                     
(setq jedi:complete-on-dot t)                 ; optional

;; make sure all backup files live in only one place.
;;(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;;enabling which key mode. (Gives a drop down of available keys after C-x
;; if you don't remember the key combination.
(which-key-mode t)

;; enabling exec-path-from-shell. (fixes an issue about exporting path for flycheck)
(when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize))

;; Invoking yasnippet.
(require 'yasnippet)
(yas-global-mode 1)

;; word-wrapping
;; (setq-default word-wrap t)
;; (global-visual-line-mode t) ; makes emacs slow.



;;loading latex preview pane automatically with a .tex document
;;(latex-preview-pane-enable)
;; make emacs start up maximized.
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; tab always indents.
;;(setq tab-always-indent ‘complete)

;; BASIC CUSTOMIZATION
;; --------------------------------------
;; as for just y/n instead of yes/no.
(fset 'yes-or-no-p 'y-or-n-p)

;;split the windows vertically
;;(setq split-width-threshold nil) ;; didn't really work the way I intended. So disabled for now.
;; learned how to mange with keyboard shortcuts.


;; ------------ back up files customization.
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
backupP-by-copying t    ; Don't delink hardlinks
version-control t      ; Use version numbers on backups
delete-old-versions t  ; Automatically delete excess backups
kept-new-versions 20   ; how many of the newest versions to keep
kept-old-versions 5    ; and how many of the old
)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
;; ------------ back up files customization end





(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'sanityinc-tomorrow-eighties t) ;load tomorrow night theme
(global-linum-mode t) ;; enable line numbers globally
(setq column-number-mode t) ;; enable column numbers


;; this line of code restores the menu bar and tool bar back.
(defun restore-menu-bar()
    (interactive)
    (if (fboundp 'scroll-bar-mode) (scroll-bar-mode 1))
    (if (fboundp 'tool-bar-mode) (tool-bar-mode 1))
    (if (fboundp 'menu-bar-mode) (menu-bar-mode 1)))

(restore-menu-bar)
;; highlights the currently being edited line. better visibility.
(global-hl-line-mode 1) ;; don't like how it obscures the cursor. disabled for now.
(set-face-background 'hl-line "#3e4446") ; background face of the current line
(set-face-foreground 'highlight nil)     ;keep synatax highlighting in the current line



;; Turn on the vertical-ido mode.
(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

;; enabling evil mode and using 'jj' to escape to normal mode.
;;(require 'evil)
;;(evil-mode 1)
(require 'key-chord)
(key-chord-mode 1)
;;(key-chord-define evil-insert-state-map  "jj" 'evil-normal-state)

;; configuring ace window mode. You can invoke ace-window my doing 'M-p'
(global-set-key (kbd "M-p") 'ace-window)

;; PYTHON CONFIGURATION
;; --------------------------------------
;; automatic 80 character column indicator for python
(require 'fill-column-indicator)

;; using ipython notebook from inside emacs.
(require 'ein)

;; enables elpy
(elpy-enable)
;; when we run our python code (note just ipython) with C-c C-c we
;; will be presented with the ipython REPL rather than standard
;; use ipython as the python shell interpreter.
(elpy-use-ipython)
;; following line fixes the issue of not being able to compile .py file using ipython.
;; it used to spit out some garbage without this line. Apparently ipython5 doesn't support
;; emacs inferior shell or whatever
(setq python-shell-interpreter "ipython"
          python-shell-interpreter-args "--simple-prompt -i")

;;(load custom-file)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
(add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; gotta see matching parenthesis.
(show-paren-mode t)
;; make sure all backup files live in one directory.


;; remaps command to meta (still has alt/option as meta until get used to it) 
(setq mac-command-modifier 'meta)
(setq mac-left-option-modifier 'super)    ;left option key is super
(setq mac-right-option-modifier 'control) ;right option key is ctrl
(setq mac-function-modifier 'hyper)     ;make Fn key do hyper

;; ===  Steve Yegge effective emacs stuff. Trying ===
;; Following two lines are not bound to anything by default
;; no harm in keeping them.
(global-set-key "\C-x\C-m" 'execute-extended-command) ; C-x C-m invokes M-x
(global-set-key "\C-c\C-m" 'execute-extended-command) ; C-c C-m invokes M-x

;; C-w does backward kill word. It is already bound to kill-region
;; by default. So we need the last two lines to re-bound that.
(global-set-key "\C-w" 'backward-kill-word)
;; C - Backspace(DEL) backward kills line.
(global-set-key (kbd "C-<backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)))
(global-set-key "\C-x\C-k" 'kill-region) ; C-x C-k kills region
(global-set-key "\C-c\C-k" 'kill-region) ; C-c C-k kills region.
;; ==== Steve Yegge's key bindings end =============


;; turn on auto fill (lines wrapping at 80 chars
;; for better visibility when inside the latex mode.
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)

;; make sure emacs has copy paste etc work as you would expect. Make emacs respond to
;; system clipboard and so we can all get along with the Mac OS X in general..
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; Always highlight parenthesis. You can actually go insane without this.
(show-paren-mode t)

;; Custom themes load path.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; loading the auctex configuration.
(load-file "~/.emacs.d/custom_init/aucTeXConfig.el")

;;loading the ess (R package) configuration
(load-file "~/.emacs.d/custom_init/essConfig.el")

;; loading the matlab configuration.
(load-file "~/.emacs.d/custom_init/matlabConfig.el")


;; loading the key-bindings init file
(load-file "~/.emacs.d/custom_init/keyBindings.el")

;; init.el ends here. the rest of the stuff gets added automatically..
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-source-correlate-mode t)
 '(custom-safe-themes
   (quote
    ("38e64ea9b3a5e512ae9547063ee491c20bd717fe59d9c12219a0b1050b439cdd" "28130127bbf3072c1bbc7652fca7245f186bb417b3b385a5e4da57b895ffe9d8" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "32e3693cd7610599c59997fee36a68e7dd34f21db312a13ff8c7e738675b6dfc" "93fdf264bc14b42d0d1d25dacf932f09850e812395400d76d9c67ba18541ce9b" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "4e753673a37c71b07e3026be75dc6af3efbac5ce335f3707b7d6a110ecb636a3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(eshell-output-filter-functions
   (quote
    (eshell-handle-control-codes eshell-handle-ansi-color eshell-watch-for-password-prompt)))
 '(package-selected-packages
   (quote
    (comment-dwim-2 neotree projectile auctex-latexmk cyberpunk-theme monokai-theme spacemacs-theme company-shell company-dict company-anaconda company-auctex company markdown-mode ensime transpose-frame color-theme-sanityinc-solarized color-theme-sanityinc-tomorrow moe-theme latex-preview-pane zerodark-theme spaceline zenburn-theme auctex matlab-mode color-theme-solarized evil-visual-mark-mode powerline exec-path-from-shell rope-read-mode jedi py-autopep8 material-theme autopair flycheck magit elpy ein better-defaults)))
 '(send-mail-function (quote mailclient-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
