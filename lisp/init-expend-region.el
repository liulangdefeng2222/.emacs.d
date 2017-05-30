
;;==========================================================================
;;expand-region用于选中光标所在区域，C-=
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/expand-region" load-path))
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)


(provide 'init-expend-region)
;;==========================================================================
