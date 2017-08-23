;;对org的相关设置

(with-eval-after-load 'org (lambda ()
  ;;(setq truncate-lines nil)
  (setq org-agenda-files '("C:/emacs/org"))
  (setq org-src-fontify-natively t)
  'turn-on-stripe-table-mode
  'auto-mode-alist '("\\.org\\.dat\\.txt\\'" . org-mode)
;;快速建立一个org文件E
;;  (setq org-capture-templates
;;      '(("t" "Todo" entry (file+headline "c:/emacs/org/gtd.org" "工作安排")
;;	 "* TODO [#B] %?\n  %i\n"
;;	 :empty-lines 1)))
  ;;定义agenda file,只要有agenda的file添加到这里就好
  (setq org-agenda-files (list "~/org/what-to-do-everyday.org"))
  (setq org-todo-keywords
  '((sequence "TODO" "NEXT" "WAITING" "|" "DONE" "DELEGATED")))
  (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("@laptop" . ?l)))))
;; 自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c r") 'org-capture)
(global-set-key (kbd "C-c p") 'org-publish)

;;org导出pdf
;;org导出pdf
(require 'ox-latex-chinese)
(oxlc/toggle-ox-latex-chinese t)

(provide 'init-org)
