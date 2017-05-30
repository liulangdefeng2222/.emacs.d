
;;=========================================================================
;;ag命令行文件搜索
;;(setq load-path (cons "c:/emacs/.emacs.d/lisp/helm" load-path))
(require 'ag)
(require 'helm-ag)
(require 'helm)
(global-set-key (kbd "C-c p s") 'helm-do-ag)

(provide 'init-ag-helm-ag)
;;=========================================================================
