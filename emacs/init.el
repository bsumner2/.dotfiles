(setq inhibit-startup-message t
      visible-bell t)
(setq custom-theme-directory "~/.config/emacs/themes")
(menu-bar-mode 1)  ; turn off after comfortable w/emacs
(tool-bar-mode 1)  ; turn off when comfortable w/emacs
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(load-theme 'deeper-blue t)
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq default-tab-width 2)
(setq backup-directory-alist '((".*" . "~/.trash")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("72d880c2fd3fbf02abd467608fd2bd33635e7a5b8d0fc3eea2194fcc7e69fa72" default))
 '(js-basic-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
