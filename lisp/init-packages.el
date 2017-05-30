;;这个功能是加载从melpa下载的库，现在我将其分解为一个个.el文件

;;=========================================================================
;;popwin
;;在查询函数意思时，它会新建一个窗口，显示相关函数定义，要退出的话可以按q或者C-g
;;这就不会想原来那样覆盖你现在的窗口
;;(require 'popwin)
;;(popwin-mode t)


;;=========================================================================
;;加载molokai主题
;;(require 'molokai-theme)


;;=========================================================================
;;一个主题，下方mini-buffer那个效果就是这个显示的
;;(require 'powerline)
;;(powerline-default-theme)

;;=========================================================================
;;加载window-numbering该插件用于不同emacs窗口之间相互切换，直接输入M-数字就好了，
;;在窗口下方会显示对应窗口的数字
;;(require 'window-numbering)
;;(setq window-numbering-assign-func
;;      (lambda () (when (equal (buffer-name) "*Calculator*") 9)))
;;(window-numbering-mode 1)


;;==========================================================================
;;smex


;;==========================================================================

;;==========================================================================
;;加载swiper，依赖于ivy，非常强大的插件，输入一些参数会自动联想后面的
;;进行输入搜索时，列出了相应的选项，可以C-n C-p/C-n进上下切换
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/ivy" load-path))
;;(require 'swiper)
;;(require 'counsel)
;;(ivy-mode 1)
;;(setq ivy-use-virtual-buffers t)
;;(setq enable-recursive-minibuffers t)
;;(global-set-key "\C-s" 'swiper)
;;(global-set-key (kbd "C-c C-r") 'ivy-resume)
;;(global-set-key (kbd "C-x C-f") 'counsel-find-file)
;;(global-set-key (kbd "M-x")     'counsel-M-x)
;;(global-set-key (kbd "C-h v")  'counsel-describe-variable)
;;(global-set-key (kbd "C-h f")  'counsel-describe-function)



;;==========================================================================
;;该功能用于括号自动匹配,也可以通过命令调用M-x smartparens-mode
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/smartparens" load-path)X)
;;(add-to-list 'load-path "c:/emacs/.emacs.d/lisp/smartparens")		
;;(require 'smartparens-config)
;;(smartparens-global-mode t)


;;==========================================================================
;;expand-region用于选中光标所在区域，C-=
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/expand-region" load-path))
;;(require 'expand-region)
;;(global-set-key (kbd "C-=") 'er/expand-region)


;;==========================================================================
;;iedit有点类似于查找替换，按快捷键开启这个模式，然后光标所在的单词会被全文标记，
;;修改一次，全文都会被修改
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/iedit" load-path))
;;(require 'iedit)
;;(global-set-key (kbd "M-s e") 'iedit-mode) ;;;其实可以不用了，直接C-;开始和结束


;;=========================================================================
;;ag命令行文件搜索
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/helm" load-path))
;;(require 'ag)
;;(require 'helm-ag)
;;(require 'helm)
;;(global-set-key (kbd "C-c p s") 'helm-do-ag)

;;语法检查插件
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/flycheck" load-path))
;;(require 'flycheck)
;;(add-hook 'prog-mode-hook 'flycheck-mode)


;;yasnnippets 批处理
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/yasnippet" load-path))
;;(require 'yasnippet)
;;(require 'auto-yasnippet)
;;(global-set-key (kbd "H-w") #'aya-create)
;;(global-set-key (kbd "H-y") #'aya-expand)

;;=========================================================================
;;这是一个更安全的require，如果某个package没有，他不会报错，只是提示没有这个package
;;可以将多个package放在一起
;;(require 'use-package)



;;=========================================================================
;; matlab-mode
;;(require 'matlab)

;;=========================================================================
;; wichi-key配置,这个插件就是快捷键自动联想
;;(require 'which-key)
;;(which-key-mode)


;;auto-company
;;(global-auto-complete-mode 1)
;;(autoload 'auto-complete-mode "auto-complete" nil t)
;;(ac-config-default)
;;(with-eval-after-load 'auto-complete
;;  (define-key ac-completing-map (kbd "M-n") nil)
;;  (define-key ac-completing-map (kbd "M-p") nil)
;;  (define-key ac-completing-map (kbd "C-n") #'ac-next)
;;  (define-key ac-completing-map (kbd "C-p") #'ac-previous))
;;(global-set-key (kbd "C-c C-a") 'auto-complete-mode)

;;====================================================================
;; diredful和dired-icon让在文件搜索的时候变得更美观,相关设置在diredfu-conf.el文件
;;(require 'diredful)
;;(diredful-mode 1)

;;(add-hook 'dired-mode-hook 'dired-icon-mode)

;;====================================================================
;;让生活变得更美好ido 
;;(ido-mode 1)
;;(ido-everywhere 1)
;;(require 'ido-ubiquitous)
;;(ido-ubiquitous-mode 1)

;;(provide 'init-packages)
 
