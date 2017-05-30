
;;=====================================================================
;;auto-complete
;;(global-auto-complete-mode 1)
(autoload 'auto-complete-mode "auto-complete" nil t)
;;(ac-config-default)
(with-eval-after-load 'auto-complete
  (define-key ac-completing-map (kbd "M-n") nil)
  (define-key ac-completing-map (kbd "M-p") nil)
  (define-key ac-completing-map (kbd "C-n") #'ac-next)
  (define-key ac-completing-map (kbd "C-p") #'ac-previous))
(global-set-key (kbd "C-c C-a") 'auto-complete-mode)

(provide 'init-auto-complete)
;;======================================================================
