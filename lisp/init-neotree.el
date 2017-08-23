;;nerotree 插件适用于在窗口左边显示文件
;;    n 下一行 ， p 上一行。
;;    SPC or RET or TAB 若是文件，在其他buffer打开；若是目录，可切换折叠、收起。
;;    g 刷新树。
;;    A 最大/最小化 NeoTree 窗口
;;    H 切换显示隐藏文件。
;;    C-c C-n 创建文件，若以 / 结尾则表示创建文件夹。
;;    C-c C-d 删除文件或目录。
;;    C-c C-r 重命名文件或目录。
;;    C-c C-c 改变根目录。

;;(require 'neotree)
(eval-after-load 'neotree-mode-hook t)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


(provide 'init-neotree)
