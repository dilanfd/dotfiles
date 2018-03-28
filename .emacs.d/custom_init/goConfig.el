;;=========== Go - lang configuration ==============
(setenv "GOPATH" "/Users/Dilan/Go")
(add-to-list 'exec-path "/Users/Dilan/Go/bin")

;; copied from http://yousefourabi.com/blog/2014/05/emacs-for-go/
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
;; remove unused imports.
(add-hook 'go-mode-hook '(lambda ()
						   (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
;; go to imports.
(add-hook 'go-mode-hook '(lambda ()
						   (local-set-key (kbd "C-c C-g") 'go-goto-imports)))

;; format using C-c C-f and format at save.
(add-hook 'go-mode-hook '(lambda ()
						   (local-set-key (kbd "C-c C-f") 'gofmt)))
(add-hook 'before-save-hook 'gofmt-before-save)

;; go def
(add-hook 'go-mode-hook '(lambda ()
						   (local-set-key (kbd "C-c C-k") 'godoc)))
;; go fly make
;; (add-to-list 'load-path "$GOPATH/src/github.com/dougm/goflymake")
;; (require 'go-flymake)

;; company for go code.
(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
						  (set (make-local-variable 'company-backends) '(company-go))
						  (company-mode)))




;; (add-hook 'before-save-hook 'gofmt-before-save)
;; (defun my-go-mode-hook ()
;;   (add-hook 'before-save-hook 'gofmt-before-save)
;;   ;;  Godef jump key binding
;;   (local-set-key (kbd "M-.") 'godef-jump)
;;   (local-set-key (kbd "M-*") 'pop-tag-mark)
;;   )
;; (add-hook 'go-mode-hook 'my-go-mode-hook)
;;=============== Go lang config end ================
