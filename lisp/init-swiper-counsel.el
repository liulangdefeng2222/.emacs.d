
;;==========================================================================
;;加载swiper，依赖于ivy，非常强大的插件，输入一些参数会自动联想后面的
;;进行输入搜索时，列出了相应的选项，可以C-n C-p/C-n进上下切换
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/ivy" load-path))
(require 'swiper)
(require 'counsel)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;;(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-x")     'counsel-M-x)
(global-set-key (kbd "C-h v")  'counsel-describe-variable)
(global-set-key (kbd "C-h f")  'counsel-describe-function)


(provide 'init-swiper-counsel)
;;==========================================================================
