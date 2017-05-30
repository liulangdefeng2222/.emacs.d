
;;=========================================================================
;;加载window-numbering该插件用于不同emacs窗口之间相互切换，直接输入M-数字就好了，
;;在窗口下方会显示对应窗口的数字
(require 'window-numbering)
(setq window-numbering-assign-func
      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
(window-numbering-mode 1)

(provide 'init-window-numbering)
;;==========================================================================
