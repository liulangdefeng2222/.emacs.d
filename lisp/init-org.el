;;对org的相关设置

;;org语法高亮
(require 'org)

(add-hook 'org-mode-hook 'turn-on-stripe-table-mode)
(add-hook 'org-mode-hook 'company-ispell)
;;(add-hook 'org-mode-hook 'company-en-words-enable)

(setq org-publish-project-alist
      '(("note-org"
         :base-directory "C:/emacs/org/org"
         :publishing-directory "C:/emacs/org/publish"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
    href=\"./style/emacs.css\"
    type=\"text/css\"/>")
        ("note-static"
         :base-directory "C:/emacs/org/org"
         :publishing-directory "C:/emacs/org/publish"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "1990lixiaohua@gmail.com"
         )))
;;(add-to-list 'dashboard-items '(agenda) t)
;;快捷键 org日程安排
(add-to-list 'auto-mode-alist '("\\.org\\.dat\\.txt\\'" . org-mode))
(with-eval-after-load 'org
  (setq org-agenda-files '("C:/emacs/org"))
  (setq org-src-fontify-natively t)

  
;;快速建立一个org文件E
  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "c:/emacs/org/gtd.org" "工作安排")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1))))

(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c r") 'org-capture)
(global-set-key (kbd "C-c p") 'org-publish)
;; org-pomodoro番茄时间管理器，但是要依赖alart插件
(require 'org-pomodoro)


;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

;;定义agenda file,只要有agenda的file添加到这里就好
;;(setq org-agenda-files (list "~/org/what-to-do-everyday.org"
;;                                       ))
;;

;;org导出pdf
(require 'ox-latex-chinese)
(oxlc/toggle-ox-latex-chinese t)
;;禁用自动设置latex字体功能
;;(setq oxlc/org-latex-fonts nil)
;; (setq org-latex-create-formula-image-program 'dvipng)    ;；速度快但是默认不支持中文
;;(setq org-latex-create-formula-image-program 'imagemagick)  ;; 速度慢但是支持中文
;;(setq org-format-latex-options
;;      (plist-put org-format-latex-options :scale 2.0))      ;；调整latex预览图片的大小
;;(setq org-format-latex-options
;;      (plist-put org-format-latex-options :html-scale 2.5)) ;；调整HTML文件中latex图片的大小
;;(setq oxlc/org-latex-commands '("latexmk -xelatex -gg -pdf %b.tex"))
(provide 'init-org)
