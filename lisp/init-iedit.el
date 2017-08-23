
;;==========================================================================
;;iedit有点类似于查找替换，按快捷键开启这个模式，然后光标所在的单词会被全文标记，
;;修改一次，全文都会被修改
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/iedit" load-path))
(autoload 'iedit-mode "iedit")
(global-set-key (kbd "M-s e") 'iedit-mode) ;;;其实可以不用了，直接C-;开始和结束

(provide 'init-iedit)
;;=========================================================================
