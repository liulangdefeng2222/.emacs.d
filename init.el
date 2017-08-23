; Added by Package.el.  This must come before configurations of
;; istalled packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(server-start)
;; time the loading of the .emacs
;; keep this on top of your .emacs
(defvar *emacs-load-start* (current-time))
(defun anarcat/time-to-ms (time)
  (+ (* (+ (* (car time) (expt 2 16)) (car (cdr time))) 1000000) (car (cdr (cdr time)))))
(defun anarcat/display-timing ()
  (message ".emacs loaded in %fms" (/ (- (anarcat/time-to-ms (current-time)) (anarcat/time-to-ms *emacs-load-start*)) 1000000.0)))
(add-hook 'after-init-hook 'anarcat/display-timing t)


(require 'package) ;; You might already have this line
(package-initialize)
(setq package-archives '(("melpa"     ."https://melpa.org/packages/")
			 ("gnu"      . "http://elpa.gnu.org/packages/")
			 ("gnu-cn"    ."http://elpa.emacs-china.org/gnu/")
		         ("melpa-cn"  ."http://elpa.emacs-china.org/melpa/")))
;;==============================================================================
;;把HOME录lisp/添加到搜索路径中去
;;(add-to-list 'load-path "~/.emacs.d/lisp")
;;文件管理公工具cask及其使用包pallet
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/cask" load-path))
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/pallet" load-path))

(defvar lxh-dir             (file-name-directory load-file-name))
(defvar lxh-lisp-dir        (expand-file-name "lisp"   lxh-dir))
(defvar lxh-lisp-cask-dir   (expand-file-name "cask"   lxh-lisp-dir))
(defvar lxh-lisp-pallet-dir (expand-file-name "pallet" lxh-lisp-dir))
(add-to-list 'load-path lxh-lisp-dir)
(add-to-list 'load-path lxh-lisp-cask-dir)
(add-to-list 'load-path lxh-lisp-pallet-dir)

;;==============================================================================
(let ((file-name-handler-alist nil))
  (require 'cask )
  (cask-initialize)
  (require 'pallet)
  (pallet-mode t)

  ;;(require 'cygwin)
  ;;(require 'setup-cygwin)
  ;;缩写词汇总
  ;;(require 'init-abbrev)

  
;; ============================================================  
  ;;加载字体
  ;;一定要先加载字体，否则有些时候就会出错
  (require 'init-fonts)
  ;;自动加载文件
  (require 'init-autoload)
  ;;加载init-ag-helm-ag
  (require 'idle-require)
  (require 'init-ag-helm-ag)  
  ;;加载artbollocks-mode
  (require 'init-artbollocks-mode)
  ;;对emacs的相关设置，使用起来更加舒服
  (require 'init-better-defauts)
  ;;对company的设置
  (require 'init-company)
  ;;init-dired
  (require 'init-dired)  
  ;;加载expend-region
  (require 'init-expend-region)
  ;;加载init-flycheck
  (require 'init-flycheck)
  ;;加载iedit
  (require 'init-iedit)
  ;;keyfreq
;;  (require 'init-keyfreq)
  ;;LaTeX配置
  (require 'init-latex) 
  ;;init-nerotree
  (require 'init-neotree)
  ;;对org的相关设置
  (require 'init-org)
  ;;org-bullets mode
  (require 'init-org-bullets)
  ;;加载popwin
  (require 'init-popwin)
  ;;加载powerline
  (require 'init-powerline)
  ;;加载smartparens
  (require 'init-smartparens)
  ;;加载swiper和counsel
  (require 'init-swiper-counsel)
  ;;init-sumatra-forward
  (require 'init-sumatra-forward) 
  ;;加载window-numbering
  (require 'init-window-numbering)
  ;;切换窗口
  (require 'init-ace-window)
  ;;加载init-which-key
  (require 'init-which-key)  
  ;;加载对emacs界面的操作
  (require 'init-ui)
  ;;语法检查插件langtool
  ;;(require 'init-langtool)
  ;;编码和字体设置
  (require 'init-unicode-fonts)
  ;;  (require 'init-workgroups2)
  (require 'init-slime)
  ;;打开最近的文件
  (require 'init-ivy-dired-history)
  ;;没有垃圾
  (use-package no-littering
    :ensure t
    :config
    (require 'recentf)
    (add-to-list 'recentf-exclude no-littering-var-directory)
    (add-to-list 'recentf-exclude no-littering-var-directory))
  ;;插入时间的package不好用
  ;;(require 'insert-time)
  ;;加载molokai主题,molokai必须放在window-numbering后面，
  ;;否则会出现左下角窗口编号看不见的情况,放在最后还有一个好处
  ;;就是能够知道init.el文件是否配置正确
  (require 'init-molokai)
  ;;将订制文件存放到专门的文件，但是必须放在init.el文件，否则没效果
  ;;切要放在所有加载文件最后，要不然没效果
  (setq-default custom-file "~/.emacs.d/lisp/init-custom.el")
  (require 'init-custom)
  (load-file custom-file)
  )


(server-start)


;;启动画面
;;(require 'init-diy-dashboard)

