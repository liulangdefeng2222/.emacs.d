
(use-package dashboard :config
  (setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        ;;(projects . 5)
                        (agenda . 5)))
  (setq dashboard-startup-banner "~/nudt.png")
  (setq dashboard-banner-logo-title "\nDon't forget.\nAlways, somewhere. Someone is fighting for you.\nAs long as you remember her.\nYou are not alone.\nTakeoff is optional, landing is compulsory")
  (dashboard-setup-startup-hook))

(provide 'init-diy-dashboard)

