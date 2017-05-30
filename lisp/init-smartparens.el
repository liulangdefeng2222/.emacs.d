
;;==========================================================================
;;该功能用于括号自动匹配,也可以通过命令调用M-x smartparens-mode
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/smartparens" load-path)X)
;;(add-to-list 'load-path "c:/emacs/.emacs.d/lisp/smartparens")		
(require 'smartparens-config)
(smartparens-global-mode t)


(provide 'init-smartparens)
;;==========================================================================
