
;;(require 'dashboard)
;; Set the title
;;(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Set the banner
;;(setq dashboard-startup-banner "1.PNG")
(use-package dashboard :config
  (setq dashboard-items '((recents  . 20)
                        (bookmarks . 5)
                        ;;(projects . 5)
                        (agenda . 5)))
  (setq dashboard-startup-banner "~/nudt.png")
  (setq dashboard-banner-logo-title "\nDon't forget.\nAlways, somewhere. Someone is fighting for you.\nAs long as you remember her.\nYou are not alone.")
  (dashboard-setup-startup-hook))

;(setq dynamic-library-alist
 ;               '((xpm "libxpm.dll" "xpm4.dll" "libXpm-nox4.dll")
  ;                (png "libpng16.dll" "libpng16-16.dll"  "zlib1.dll")
   ;               (jpeg "jpeg62.dll" "libjpeg.dll" "jpeg-62.dll"
    ;                    "jpeg.dll")
     ;             (tiff "libtiff3.dll" "libtiff.dll")
       ;           (gif "giflib4.dll" "libungif4.dll" "libungif.dll")
      ;            (svg "librsvg-2-2.dll")
        ;          (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
         ;         (glib "libglib-2.0-0.dll")
          ;        (gobject "libgobject-2.0-0.dll")))
(image-type-available-p 'png)
;;(image-type-available-p 'jpg)
;(image-type-available-p 'jpeg)
;(image-type-available-p 'png)
(cdr (assq 'jpeg dynamic-library-alist))
(provide 'init-diy-dashboard)

;;(use-package dashboard
;;    :ensure t
;;    :diminish dashboard-mode
;;    :config
;;    (setq dashboard-banner-logo-title "your custom text")
;;   (setq dashboard-startup-banner "~/.emacs.d/cache/nudt.png")
;;    (setq dashboard-items '((recents  . 20)
;;                            (bookmarks . 10)
;;			    (agenda . 5)))
;;    (dashboard-setup-startup-hook))

;;; widgets.el ends here
;;system
     
