;;========================================================================
;;加载对company-mode的设置
;;(require 'init-company)
;;============================================================================
;;想全局打开company-mode这个插件相当于自动联想功能，输入一些参数会自动联想后面的
;;(global-company-mode)
;;===========================================================================


;;(autoload 'company-mode "company" nil t)
;;(setq company-idle-delay nil)

;;(add-hook 'c-mode-hook '(lambda () (company-mode)))
;;(add-hook 'c++-mode-hook '(lambda () (company-mode)))
;;(global-set-key [(control tab)] 'company-mode)
(add-hook 'after-init-hook 'global-company-mode)


(if (fboundp 'evil-declare-change-repeat)
    (mapc #'evil-declare-change-repeat
          '(company-complete-common
            company-select-next
            company-select-previous
            company-complete-selection
            company-complete-number
)))

(with-eval-after-load 'company
  '(progn
     ;; @see https://github.com/company-mode/company-mode/issues/348
     (unless (featurep 'company-statistics)
       (require 'company-statistics))
     (company-statistics-mode)

     (add-to-list 'company-backends 'company-cmake)
     (add-to-list 'company-backends 'company-c-headers)
     ;; can't work with TRAMP
     (setq company-backends (delete 'company-ropemacs company-backends))
     ;; (setq company-backends (delete 'company-capf company-backends))

     ;; I don't like the downcase word in company-dabbrev!
     (setq company-dabbrev-downcase nil
           ;; make previous/next selection in the popup cycles
           company-selection-wrap-around t
           ;; Some languages use camel case naming convention,
           ;; so company should be case sensitive.
           company-dabbrev-ignore-case nil
           ;; press M-number to choose candidate
           company-show-numbers t
           ;;company-idle-delay 0.2
           company-clang-insert-arguments nil
           company-require-match nil
           company-etags-ignore-case t)
     ;; @see https://github.com/redguardtoo/emacs.d/commit/2ff305c1ddd7faff6dc9fa0869e39f1e9ed1182d
     (defadvice company-in-string-or-comment (around company-in-string-or-comment-hack activate)
       ;; you can use (ad-get-arg 0) and (ad-set-arg 0) to tweak the arguments
       (if (memq major-mode '(php-mode html-mode web-mode nxml-mode))
           (setq ad-return-value nil)
         ad-do-it))

     ;; press SPACE will accept the highlighted candidate and insert a space
     ;; `M-x describe-variable company-auto-complete-chars` for details
     ;; That's BAD idea.
     (setq company-auto-complete nil)

     ;; NOT to load company-mode for certain major modes.
     ;; Ironic that I suggested this feature but I totally forgot it
     ;; until two years later.
     ;; https://github.com/company-mode/company-mode/issues/29
     (setq company-global-modes
           '(not
             eshell-mode comint-mode erc-mode gud-mode rcirc-mode
             minibuffer-inactive-mode)))
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))


;; {{ setup company-ispell
;;(defun toggle-company-ispell ()
;;  (interactive)
;;  (cond
;;   ((memq 'company-ispell company-backends)
;;    (setq company-backends (delete 'company-ispell company-backends))
;;    (message "company-ispell disabled"))
;;   (t
;;    (add-to-list 'company-backends 'company-ispell)
;;    (message "company-ispell enabled!"))))

;;(defun company-ispell-setup ()
  ;; @see https://github.com/company-mode/company-mode/issues/50
;;  (when (boundp 'company-backends)
;;    (make-local-variable 'company-backends)
;;    (add-to-list 'company-backends 'company-ispell)
    ;; https://github.com/redguardtoo/emacs.d/issues/473
;;    (if (and (boundp 'ispell-alternate-dictionary)
;;             ispell-alternate-dictionary)
;;        (setq company-ispell-dictionary ispell-alternate-dictionary))))

;; message-mode use company-bbdb.
;; So we should NOT turn on company-ispell
;;
;;(add-hook 'org-mode-hook 'company-ispell-setup)
;; }}
;;(eval-after-load 'company-etags
;;  '(progn
     ;; insert major-mode not inherited from prog-mode
     ;; to make company-etags work
;;     (add-to-list 'company-etags-modes 'web-mode)
;;     (add-to-list 'company-etags-modes 'lua-mode)))

;;(global-set-key (kbd "C-c C-p") 'company-mode)
;;引入单词
;;(load "~/.emacs.d/lisp/company-words.el")
;;(company-en-words-enable t)
(provide 'init-company)
