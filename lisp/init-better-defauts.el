;;对emacs的相关设置，使用起来更加舒服
;;========================================================================


;;========================================================================
;;第一个是显示光标所在的括号；第二个是括号匹配功能,
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;;快捷键F3,打开最近打开的文件
(require 'recentf)
(recentf-mode t)
(setq recentf-max-menu-items  50
      recentf-max-saved-items 500)

(global-set-key (kbd "<f3>") 'recentf-open-files)


;;使用快捷键F2直接打开配置文件init.el
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)

;;当双击一个词，然后输入某个词，此时直接替换（符合我们的习惯）而不是添加在选中区域后面
(delete-selection-mode 1)

;;定义一个新的快捷键能够进行搜索，便于查找当前目录下的文件
;;(global-set-key (kbd "C-c p f" 'counsel-git))

;;代码自动缩进快捷键C-M-\
(defun indent-buffer()
  (interactive)
  (indent-region (point-min
) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))
(global-set-key (kbd "C-M-\\") 'indent-region-or-buffer)


;;自动补全功能,快捷键M-/
(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))
(global-set-key (kbd "M-/") 'hippie-expand)

;;将每次对话框询问的yes/no 改为y/name
(fset 'yes-or-no-p 'y-or-n-p)

;;再删除或者拷贝文件时，都是删除或者拷贝文件目录中所有的子文件
(setq dired-recursive-copies  'always)
(setq dired-recursive-deletes 'always)

;;防止文件复制拷贝过程中生成很多不必要蛋疼重复的buffer
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

;;此时多又有一个新的快捷键C-x C-j，用来直接打开当前目录的文件夹
(require 'dired-x)

;;有点问题，用于当两个文件目录打开时，复制粘贴会直接映射到另一个文件夹，windows下貌似还是有问题
;;(setq 'dired-dwim-target 1)

;;在使用快捷键M-s o搜索时，直接搜索光标所在的单词
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
	    (buffer-substring-no-properties
	     (region-beginning)
	     (region-end))
	  (let ((sym (thing-at-point 'symbol)))
	    (when (stringp sym)
	      (regexp-quote sym))))
	regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)


;;这个快捷键功能是方便直接全部编译 即M-x eval-buffer
(global-set-key (kbd "C-x e") 'eval-buffer)  

;;这个快捷键是find library M-x find-library
(global-set-key (kbd "C-x C-l") 'find-library)

;;这个快捷键是直接打开文件夹
(global-set-key (kbd "C-x C-c") 'counsel-find-file-extern)

;;这个快捷键是绑定M-x ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;;=========================================================================
;;ctrl-滚动鼠标中键，实现字体缩放
;; For Windows
;; 参考http://zhuoqiang.me/torture-emacs.html
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)


;;=========================================================================
;;自动备份相关设置
(setq
 backup-by-copying   t      ;;自动备份
 delete-old-versions t      ;;自动删除旧的备份
 version-control     t      ;;多次备份
 backup-by-coping    t      ;;复制所有文件，但不重命名
 auto-save-timeout   120    ;;自动保存时间，单位秒
 kept-new-versions   30     ;;保存最近的20个备份文件
 kept-old-versions   5      ;;保留最早的四个备份文件
 
 ;; 把生成的备份文件放到统一的一个目录，而不在文件当前目录生成~#的文件
 ;; 如果你编辑某个文件时，后悔了想恢复成以前的版本 就可以到这个目录下去找
 ;; 到备份文件
 backup-directory-alist `((".*" . "~/.emacs.d/cache/backup_files/")) ;
 auto-save-file-name-transforms `((".*" "~/.emacs.d/cache/backup_files/" t))
 auto-save-list-file-prefix   "~/.emacs.d/cache/backup_files/saves-")


;;=========================================================================
;;记住上次打开文件时光标的位置
(setq-default save-place t)
(require 'saveplace)
(save-place-mode 1)                     ;;emacs-25 才有


;;=========================================================================
;;fill-colum当某行的长度大于75时，再次输入文字就自动换行
(setq-default defaull-fill-column 70)

;;=========================================================================
;;启动窗口大小
(setq initial-frame-alist
          '((top . 1) (left . 1) (width . 160) (height . 53)))

;;=========================================================================
;;显示图片
(setq-default auto-image-file-mode t)
;;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;;=========================================================================
;;文件按分类排序
(defun xah-dired-sort ()
  "Sort dired dir listing in different ways.
Prompt for a choice.
URL `http://ergoemacs.org/emacs/dired_sort.html'
Version 2015-07-30"
  (interactive)
  (let (-sort-by -arg)
    (setq -sort-by (ido-completing-read "Sort by:" '( "date" "size" "name" "dir")))
    (cond
     ((equal -sort-by "name") (setq -arg "-Al --si --time-style long-iso "))
     ((equal -sort-by "date") (setq -arg "-Al --si --time-style long-iso -t"))
     ((equal -sort-by "size") (setq -arg "-Al --si --time-style long-iso -S"))
     ((equal -sort-by "dir") (setq -arg "-Al --si --time-style long-iso --group-directories-first"))
     (t (error "logic error 09535" )))
    (dired-sort-other -arg )))
(require 'dired )
(define-key dired-mode-map (kbd "s") 'xah-dired-sort)

;;===========================================================================
;;图片显示
;(require 'image)
;(setq dynamic-library-alist
;                '((xpm "libxpm.dll" "xpm4.dll" "libXpm-nox4.dll")
;                  (png "libpng12d.dll" "libpng12.dll" "libpng.dll"
;                       "libpng13d.dll" "libpng13.dll" "libpng14-14.dll")
;                  (jpeg "jpeg62.dll" "libjpeg.dll" "jpeg-62.dll"
;                        "jpeg.dll")
;                  (tiff "libtiff3.dll" "libtiff.dll")
;                  (gif "giflib4.dll" "libungif4.dll" "libungif.dll")
;                  (svg "librsvg-2-2.dll")
;                  (gdk-pixbuf "libgdk_pixbuf-2.0-0.dll")
;                  (glib "libglib-2.0-0.dll")
;                  (gobject "libgobject-2.0-0.dll")))
;(image-type-available-p 'jpg)
;(image-type-available-p 'jpeg)
;(image-type-available-p 'png)
;(cdr (assq 'png dynamic-library-alist))

;;===========================================================================
;;采用标准的复制粘贴剪切
(cua-mode 1)

;;===========================================================================
;;设置垃圾回收，在windows 下emacs25版本会频繁触发垃圾回收
;;(when (eq system-type 'windows-nt)
;;(setq gc-cons-threshold (* 512 1024 1024))
;;(setq gc-cons-percentage 0.5)
;;(run-with-idle-timer 5 t #'garbage-collect)
;; 显示垃圾回收信息，这个可以作为调试用
;; (setq garbage-collection-messages t)
;;)
;;===========================================================================
;;自动换行
(setq truncate-lines nil)
(provide 'init-better-defauts)
