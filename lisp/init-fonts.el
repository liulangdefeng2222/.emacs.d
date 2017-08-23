;; ============================================================
;; Setting English Font和中文字体
;;(set-face-attribute
;; 'default nil :font "Courier New 10")
;;(dolist (charset '(kana han symbol cjk-misc bopomofo))
;;  (set-fontset-font (frame-parameter nil 'font)
;;            charset
;;            (font-spec :family "Microsoft Yahei" :size 14)))	  

;;这段代码是用插件Chinese-fonts-set生成的
(set-face-attribute
 'default nil
 :font (font-spec :name "-outline-Courier New-bold-italic-normal-mono-*-*-*-*-c-*-iso10646-1"
                  :weight 'normal
                  :slant 'normal
                  :size 14))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font
   (frame-parameter nil 'font)
   charset
   (font-spec :name "-outline-Microsoft YaHei-normal-normal-normal-sans-*-*-*-*-p-*-iso10646-1"
              :weight 'normal
              :slant 'normal
              :size 10.0)))


;;字体系统utf-8
(setq language-environment "UTF-8")

(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(setq-default pathname-coding-system 'utf-8)
;;(setq-default pathname-coding-system 'euc-cn) 
(setq file-name-coding-system 'utf-8) 
;;(setq file-name-coding-system 'euc-cn)


  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'gb18030)
;;  (set-selection-coding-system 'gb18030)
  (setq locale-coding-system 'gb18030)
  
  
  (prefer-coding-system 'utf-8)
;;  (prefer-coding-system 'gb18030) 
(provide 'init-fonts)
