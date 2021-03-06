;;; Commentary:
;;init.el --- Emacs configuration for Dilan Fernando.
;; Last modified : Let's face it. Probably a few seconds ago...  :)
;; I like incessantly fiddling with the config files. ha.

(setq user-full-name "Dilan Fernando")
(setq user-mail-address "dilan.fd@gmail.com")


;; use a single key stroke to fire up init file.
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
;; open init file by "C -c I"
(global-set-key (kbd "C-c I") 'find-user-init-file)

;; Use a single key stroke to reload init file.
(defun reload-init-file ()
  "Reload the `user-init-file'"
  (interactive)
  (load-file user-init-file))
(global-set-key (kbd "C-c R") 'reload-init-file)

;; aggressively indented code. Indented at all times
;; for the enabled modes. does not work well for python
;; unfortunately.

;; if you want to exclude certain modes for example html mode
;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
(add-hook 'ruby-mode-hook #'aggressive-indent-mode)
;; (add-hook 'c-mode-hook #'aggressive-indent-mode)
(add-hook 'latex-mode-hook #'aggressive-indent-mode)


;; Show date and time on status bar
;; (display-time-mode 1)

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
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

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

;; ============= DIRED ===============
(use-package dired+
  :ensure t
  :config
  (require 'dired+)
  (setq-default dired-listing-switches "-alh") ; human readable units
  (add-hook 'dired-mode-hook   (lambda nil (auto-revert-mode 1))))

;; Move files between split panes.
(setq dired-dwim-target t)
;; ============ DIRED end =============



;; Avy configuration from abo-abo
(global-set-key (kbd "C-:") 'avy-goto-char)


;; =========== direfl ============
;; gives colors to dired mode when in sanityinc theme.
(use-package diredfl                    ; Add colours to Dired
  :ensure t
  :config (diredfl-global-mode))
;; ========= diredfl end ==============


;; ======== Atomic - chrome. (edit gmail in emacs.) =========
(use-package atomic-chrome
  :ensure t
  :config
  (atomic-chrome-start-server)
  (setq atomic-chrome-buffer-open-style 'frame)
  (setq atomic-chrome-default-major-mode 'markdown-mode))
;; ========== Atomic - chrome end ==============



;; =============== C configuration ============================
;; tab = 4 spaces. TAB
;; (setq-default tab-width 4)
(setq tab-stop-list (number-sequence 4 200 4))
;; However this doesn't change tab-width in c-mode.
;; The following is required to make c-mode indent tab = 4
;; (setq c-default-style "bsd"
;;       c-basic-offset 4)

(load-file "~/.emacs.d/custom_init/cs50-c-style.el")
(c-add-style "cs50-c-style" cs50-c-style)


(defun dilan-c-mode-hook ()
  (setq c-basic-offset 4
        c-indent-level 4
		indent-tabs-mode nil
        c-default-style "cs50-c-style")
  (c-set-offset 'substatement-open 0))
(add-hook 'c-mode-common-hook 'dilan-c-mode-hook)
(add-hook 'c++-mode-hook #'dilan-c-mode-hook)
(add-hook 'c-mode-hook #'dilan-c-mode-hook)

;; make tab = 4 spaces and absolutely no \t characters.

;; make RET not indent.
;; (add-hook 'c-mode-hook
;;           (lambda ()
;;             (setq-local electric-indent-chars
;;                         (remq ?\n electric-indent-chars))))
;;=================== C config end ==============================





;; ======== configuration for markdown files =============
(use-package markdown-mode
  :ensure t
  :config
  (setq markdown-css-paths `(,(expand-file-name "~/markdown/markdown.css")))
  (add-hook 'markdown-mode-hook 'flyspell-mode)
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  (progn
    (push '("\\.text\\'" . markdown-mode) auto-mode-alist)
    (push '("\\.markdown\\'" . markdown-mode) auto-mode-alist)
    (push '("\\.md\\'" . markdown-mode) auto-mode-alist)))
;;============  markdown config end ====================



;;  ============= HTML CSS Web Mode ==================
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
		'(("django"    . "\\.html\\'")))
  (setq web-mode-ac-sources-alist
		'(("css" . (ac-source-css-property))
		  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

  (setq web-mode-enable-auto-closing t)
  (setq web-mode-enable-auto-quoting t))
;; ============== Web mode end ============



;; use smart-parens mode. Copied from rommel martinez.
(use-package smartparens-config
  :ensure smartparens
  :config
  (progn
    (show-smartparens-global-mode t))
  (setq-default sp-escape-quotes-after-insert nil))

(add-hook 'prog-mode-hook 'turn-on-smartparens-strict-mode)
(add-hook 'markdown-mode-hook 'turn-on-smartparens-strict-mode)

;; we use :add to keep any global handlers. If you want to replace
;; them, simply specify the "bare list" as an argument:



;; This makes inserting { behave in the c-language way. Very important
;; after disabling auto-pair mode. See https://emacs.stackexchange.com/a/3015/13976
(sp-local-pair 'c-mode "{" nil :post-handlers '(:add my-open-block-c-mode))
(defun my-open-block-c-mode (id action context)
  (when (eq action 'insert)
    (newline)
    (newline)
    (indent-according-to-mode)
    (previous-line)
    (indent-according-to-mode)))

;; The same for c++ mode.
(sp-local-pair 'c++-mode "{" nil :post-handlers '((my-create-newline-and-enter-sexp "RET")))
(defun my-create-newline-and-enter-sexp (&rest _ignored)
  "Open a new brace or bracket expression, with relevant newlines and indent."
  (newline)
  (indent-according-to-mode)
  (forward-line -1)
  (indent-according-to-mode))

;; Key bindings
(global-set-key (kbd "C-M-k") 'sp-kill-sexp)

;;============== smartparens config end =================


;;;; ========= Org mode configuration ===============
;; Enable Org mode
(use-package org
  :ensure t
  :config
  ;; Make Org mode work with files ending in .org
  (transient-mark-mode 1)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode)) 
  (setq org-todo-keywords
		'((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE"))) 
  (setq org-src-fontify-natively t
		org-src-tab-acts-natively t
		org-src-preserve-indentation t)
  (add-hook 'org-mode-hook 'flyspell-mode)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
	 (latex . t)))
  (add-hook 'markdown-mode-hook 'auto-fill-mode)
  ;;; from David O'toole org tutorial.
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cc" 'org-capture)
  (setq org-log-done t))
;; The above is the default in recent emacsen


;; Org agenda
(setq org-agenda-files '("~/Dropbox/org/"))



;;; ========== Org bullets. ================
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
;;; =========== org bullets end ============

;;  THEMES BEFORE HELM CONFIG to get yellow background in helm
;; sanity inc steve purcell theme
(load-theme 'sanityinc-tomorrow-eighties t) ;load tomorrow night theme
;; (load-theme 'leuven t)
;; (load-theme 'zenburn t)
;; (load-theme 'misterioso t)
;; (load-theme 'arjen-grey t)

;; THEME config end

;;; ============ HELM CONFIG ===============
(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (progn
	;; rebind tab to run persistent action
	(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
	)
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t)
  (set-face-attribute 'helm-selection nil 
					  :background "yellow"
					  :foreground "black")
  :bind
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files))
;; use helm for flyspell correctons.
(require 'helm-flyspell)
(define-key flyspell-mode-map (kbd "C-.") 'helm-flyspell-correct)
;; (define-key flyspell-mode-map (kbd "<f12>") 'flyspell-auto-correct-previous-word)

;; helm comany
(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-:") 'helm-company)
     (define-key company-active-map (kbd "C-:") 'helm-company)))
;; end helm company

;; Helm bibtex configuration
(setq bibtex-completion-bibliography
      '("~/Numerical_Project_SMS/thesis/references.bib"))
;;; ============ HELM END ==================


;; =============== ivy-swyper-counsel config ====================
(use-package ivy
  :ensure t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume))

(use-package swiper
  :ensure t
  :bind
  ("C-s" . swiper))

(use-package counsel
  :ensure t
  :bind
  ;; (("M-y" . counsel-yank-pop)			;also browses kill ring.
  ;;  :map ivy-minibuffer-map ;; these are set by helm.
  ;;  ("M-y" . ivy-next-line))
  :config
  ;; (global-set-key (kbd "M-x") 'counsel-M-x)
  ;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  ;; Use C-j for immediate termination with the current value, and RET
  ;; for continuing completion for that directory. This is the ido
  ;; behaviour.
  (define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
  (define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done))

;;================ ivy-swyper-counsel config end =================

;; auto revert changed buffers using <f5>
(global-auto-revert-mode 1)
(setq auto-revert-verbose 'nil)
(global-set-key (kbd "<f5>") 'revert-buffer)
;; auto revert end ======================

;; ======= Ensime/Scala config =============
(use-package ensime
  :ensure t
  :pin melpa
  :config
  (setq ensime-startup-snapshot-notification 'nil)
  (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))
;; ========= Ensime end ====================

;; ==== auto-complete and yasnippet ==========
;; first yasnippet so that it works well with auto-complete.
(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (setq yas-triggers-in-field t)) ;snippet inside snippet trigger


;;; ========== multiple cursors ==================
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
		 ("C->" . mc/mark-next-like-this)
		 ("C-<" . mc/unmark-next-like-this)
		 ("C-c C-<" . mc/mark-all-like-this)
		 ("C-S-<mouse-1>" . mc/add-cursor-on-click)))
;; This is globally useful, so it goes under `C-x', and `m'
;; for "multiple-cursors" is easy to remember.
(define-key ctl-x-map "\C-m" #'mc/mark-all-dwim)
;; ======== multiple cursors end ================




;; TRAMP Configuration for AWS
;;(tramp-set-completion-function "ssh"
;; ((tramp-parse-sconfig "~/.ssh/config")))
(setq tramp-default-method "ssh")
;; TRAMP config END



;; make highlighted selction more readable.
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")


;; NO BACKUP FILES. ANNOYING!!! Use GIT FFS
;; (setq make-backup-files nil)
;; ;;disable auto save
;; (setq auto-save-default nil)
;; disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)

;; From Bodizhar Batsov. Pressing TAB one time will indent
;; pressing TAB again will show auto completions
(setq tab-always-indent 'complete)


(require 'cc-mode)

;; IRONY mode for c/c++
;; (require 'company-irony-c-headers)
;; ;; Load with `irony-mode` as a grouped backend
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends '(company-irony-c-headers company-irony)))


;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; enable and use autocomplete globally..
;; ======= Company mode set up ============
(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
  (define-key company-active-map [tab] 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (setq company-require-match 'never)
  (setq 
   company-minimum-prefix-length   2
   company-show-numbers            t
   company-tooltip-limit           20
   company-dabbrev-downcase        nil
   company-selection-wrap-around   t
   company-backends                '((company-irony company-gtags company-files)))
  :bind ("C-;" . company-complete-common-or-cycle))

;; company irony.
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
;; TuhDO says remove the following and....
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends 'company-irony))
;; Add the below code.
;; (require 'company-irony-c-headers)
;; (eval-after-load 'company
;;   '(add-to-list
;;     'company-backends '(company-irony-c-headers company-irony)))

;; C/C++ syntax checking
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)


;; C/C++ tab completion with no delay
(setq company-idle-delay 0)
(setq company-backends (delete 'company-semantic company-backends))
;; (define-key c-mode-map [(tab)] 'company-complete)
;; (define-key c++-mode-map [(tab)] 'company-complete)

;; Company auctex
(require 'company-auctex)
(company-auctex-init)


;; realgud debuggin for python
(use-package realgud
  :ensure t
  :commands (realgud:ipdb)
  :config
  (setq gud-tooltip-mode 1)
  (setq tooltip-mode 1))


;; Company python set up
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)

;; ========= company c headers configuration =======
(require 'company-c-headers)
(add-to-list 'company-backends 'company-c-headers)
(add-to-list 'company-c-headers-path-system "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include/c++/v1")
;; stuff after company refused to work for latex and c
(add-to-list 'company-backends 'company-dabbrev-code) 
(add-to-list 'company-backends 'company-yasnippet)
(add-to-list 'company-backends 'company-files)

(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
(add-hook 'latex-mode-hook 'company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))


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
;; ============= open smart line above end =============


;; Setting up Expand Region. Selecting word, paragraph, function
;; etc quicker.
(use-package expand-region
  :ensure t
  :bind ("C-c v" . er/expand-region))


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

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))



;;making sure shell and eshell do the same thing.
;; exports path from the shell to emacs shell etc.
(use-package exec-path-from-shell
  :ensure t
  :config
  ;;Do not warn me about the location of my env vars
  (setq exec-path-from-shell-check-startup-files nil)
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))


;;magit (git) configuration.
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; git gutter
(use-package git-gutter
  :ensure t
  :init
  (global-git-gutter-mode +1))

;; interactive do mode.
(require 'ido)
(ido-mode t)


;; Start emacs infront of terminal.
(x-focus-frame nil)


;;enabling which key mode. (Gives a drop down of available keys after C-x
;; if you don't remember the key combination.
;; (which-key-mode t)
(use-package which-key
  :ensure t
  :config
  (which-key-mode +1))


;; enabling exec-path-from-shell. (fixes an issue about exporting path for flycheck)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; Invoking yasnippet.
(require 'yasnippet)
(yas-global-mode 1)


;;loading latex preview pane automatically with a .tex document
;;(latex-preview-pane-enable)
;; make emacs start up maximized.
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; BASIC CUSTOMIZATION
;; --------------------------------------
;; as for just y/n instead of yes/no.
(fset 'yes-or-no-p 'y-or-n-p)

;; confirm before killing emacs. helpful when I do stupid things.
(when (window-system)
  (setq confirm-kill-emacs 'yes-or-no-p))


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

;; Web HTML/CSS/JS webmode.
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))


;;;=========== Global Set up. Themes/line numbers etc. =================
;; Startup Options
(setq inhibit-startup-message t) ;; hide the startup message
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; enable line numbers globally
(global-linum-mode t) 
;; enable column numbers
(setq column-number-mode t)
;; this line of code restores the menu bar and tool bar back.
(defun restore-menu-bar()
  (interactive)
  (if (fboundp 'scroll-bar-mode) (scroll-bar-mode 1))
  (if (fboundp 'tool-bar-mode) (tool-bar-mode 1)) ; turn on tool bar
  (if (fboundp 'menu-bar-mode) (menu-bar-mode 1)))

(restore-menu-bar)
;; highlights the currently being edited line. better visibility.
(global-hl-line-mode 1) 
;;keep synatax highlighting in the current line
(set-face-foreground 'highlight nil) 
;;; ================= Global set up end ====================================


;; Turn on the vertical-ido mode. ===========
(require 'ido-vertical-mode)
(ido-mode 1)
(setq ido-use-faces 't)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
;; vertical ide mode etc end =================
;; Use key-chord mode.

;; Key chords package. ================
(use-package key-chord
  :ensure t
  :config
  (key-chord-mode +1)
  :commands key-chord-mode)
;; key chord mode end =================

;; configuring ace window mode. You can invoke ace-window my doing 'M-p'
;; (global-set-key (kbd "M-p") (interactive) (ace-window))
(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-p") 'ace-window))


;; PYTHON CONFIGURATION
;; --------------------------------------
;; automatic 80 character column indicator for python
(require 'fill-column-indicator)
(require 'python-mode)

;; using ipython notebook from inside emacs.
(require 'ein)

;; enables elpy
(elpy-enable)
;; when we run our python code (note just ipython) with C-c C-c we
;; will be presented with the ipython REPL rather than standard python shell
;; use ipython as the python shell interpreter.

;; (elpy-use-python) ;; Commented out for now.

;; following line fixes the issue of not being able to compile .py file using ipython.
;; it used to spit out some garbage without this line. Apparently ipython5 doesn't support
;; emacs inferior shell or whatever

;; Anaconda mode.
;; (add-hook 'python-mode-hook 'anaconda-mode)


;; python virtual environment set up
(setenv "WORKON_HOME" "~/anaconda/envs")

(use-package pyvenv
  :ensure t
  :config
  (pyvenv-mode 1))


(setq python-shell-interpreter "python")
;; (setq python-shell-interpreter-args "-m IPython --simple-prompt -i")


;;(load custom-file)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
(setq py-autopep8-options '("--max-line-length=100"))

;; gotta see matching parenthesis.
;; (show-paren-mode t)
(use-package paren
  :config
  (show-paren-mode +1))

;; make sure all backup files live in one directory.


;; remaps command to meta (still has alt/option as meta until get used to it) 
(setq mac-command-modifier 'meta)
;; The following couple of lines are reduntant
;; (setq mac-left-option-modifier 'super)    ;left option key is super
;; (setq mac-right-option-modifier 'control) ;right option key is ctrl
(setq mac-function-modifier 'hyper)     ;make Fn key do hyper
(setq ns-option-modifier      'meta
      ns-right-option-modifer 'control)


;; =====================  Steve Yegge =====================================
;; Following two lines are not bound to anything by default
;; no harm in keeping them.
;; (global-set-key "\C-x\C-m" 'execute-extended-command) ; C-x C-m invokes M-x
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
;; =================== Steve Yegge END =====================================



;; make sure emacs has copy paste etc work as you would expect. Make
;; emacs respond to system clipboard and so we can all get along with
;; the Mac OS X in general..
(delete-selection-mode t)
(transient-mark-mode t)
(setq select-enable-clipboard t)

;; Always highlight parenthesis. You can actually go insane without this.
;; (show-paren-mode t)

;; Custom themes load path.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; loading the auctex configuration.
(load-file "~/.emacs.d/custom_init/aucTeXConfig.el")

;;loading the ess (R package) configuration
(load-file "~/.emacs.d/custom_init/essConfig.el")

;; loading the matlab configuration.
(load-file "~/.emacs.d/custom_init/matlabConfig.el")

;; loading iBuffer configuration file.
(load-file "~/.emacs.d/custom_init/iBufferConfig.el")

;; loading the key-bindings init file
(load-file "~/.emacs.d/custom_init/keyBindings.el")

;; loading the go lang init file
(load-file "~/.emacs.d/custom_init/goConfig.el")

;; loading sql config file
(load-file "~/.emacs.d/custom_init/sqlConfig.el")
;; =========== init.el ends here ====================
