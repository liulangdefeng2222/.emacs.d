;;该文档是用于初始化emacs的界面以及对字体的修改
;;加载字体
(require 'init-fonts)
;;关闭状态栏
(tool-bar-mode -1)

;;关闭滚动栏
(scroll-bar-mode -1)

;;关闭回车换行缩进变化
;;(electric-indent-mode -1)

;;显示行号
(global-linum-mode 1)
;;显示当前行，高亮
(global-hl-line-mode t)
;;关闭启动画面
(setq inhibit-splash-screen t)
;;改变光标样式
(setq-default cursor-type 'bar) 
;;关闭声音
(setq ring-bell-function 'ignore)
(provide 'init-ui)
