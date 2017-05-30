;;启动窗口设置

(require 'dashboard)
(dashboard-setup-startup-hook)
;;(add-to-list 'dashboard-items '(agenda) t)


;; Or if you use use-package
(use-package dashboard
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner

(setq dashboard-startup-banner 'official)
(setq dashboard-items '((recents  . 20)
                        (bookmarks . 5)                   
			(agenda . 5)))
(setq version-faced (propertize "    Emacs version: " 'face 'prolusion--dashboard-info-face))
          (insert version-faced)
(insert (format "%s\n" (car (s-lines (emacs-version)))))
;;(provide 'init-dashboard)
(provide 'init-prolusion-dashboard)
