(require 'ace-window)

(global-set-key (kbd "M-p") 'ace-window)

(defun z/swap-windowsn ()
  ""
  (interactive)
  (ace-swap-window)
  (aw-flip-window)
)

(define-key ctl-x-map (kbd "w") 'z/swap-windows)
(provide 'init-ace-window)

