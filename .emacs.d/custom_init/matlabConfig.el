(autoload 'matlab-mode "matlab" "Matlab Editing Mode" t)
(add-to-list
   'auto-mode-alist
   '("\\.m$" . matlab-mode))
(setq matlab-indent-function t)
(setq matlab-shell-command "matlab")


(matlab-cedet-setup)
(add-hook 'matlab-mode
           (lambda ()
               (auto-complete-mode 1)
               ))
;;  elisp setup for matlab-mode:
(setq matlab-shell-command "/Applications/MATLAB_R2016b.app/bin/matlab")
(setq matlab-shell-command-switches '(list "-nodesktop"))
