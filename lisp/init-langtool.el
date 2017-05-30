;;语法检查插件langtool
(require 'langtool)
(setq langtool-language-tool-jar "~/.emacs.d/.cask/LanguageTool/languagetool-commandline.jar")

;;(setq langtool-default-language "en-US")
;;(setq langtool-mother-tongue "en")

(global-set-key "\C-x4w" 'langtool-check)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4l" 'langtool-switch-default-language)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
(global-set-key "\C-x4c" 'langtool-correct-buffer)

(provide 'init-langtool)
