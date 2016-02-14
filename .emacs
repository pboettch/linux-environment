(when (>= emacs-major-version 24)
  	(require 'package)
  	(add-to-list
   		'package-archives
   		'("melpa" . "http://melpa.org/packages/")
   		t)
  	(package-initialize)
)

(setq-default c-default-style "linux"
      indent-tabs-mode t
      tab-width 4
      c-basic-offset 4
)

(smart-tabs-insinuate 'c 'c++ 'java 'javascript 'cperl 'python 'ruby 'nxml)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
