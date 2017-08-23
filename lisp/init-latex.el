;; latex配置
;; After running Emacs and loading a TeX file (C-x C-f file_name.tex),
;; AUCTeX should load itself automatically.
;; If it doesn’t happen, you can invoke it with M-x tex-mode

;;(defun 'flycheck-)
;;(require 'auctex)
;; latex配置
;; After running Emacs and loading a TeX file (C-x C-f file_name.tex),
;; AUCTeX should load itself automatically.
;; If it doesn’t happen, you can invoke it with M-x tex-mode

;;(defun 'flycheck-)
;;(require 'auctex)

(mapc (lambda (mode)
      (add-hook 'LaTeX-mode-hook mode))
      (list
            'auto-fill-mode
            'auto-complete-mode
            ;;'autopair-mode
	    ;;'company-ispell
	   ;; 'flyspell-mode	    
            'LaTeX-math-mode
            'linum-mode
	   #'LaTeX-preview-setup	    
	    'turn-on-reftex
	    'turn-on-cdlatex
            'TeX-fold-mode
            'outline-minor-mode
	  ;;'latex-preview-pane-mode
	    ))


(add-hook 'LaTeX-mode-hook
          (lambda ()
            (setq reftex-plug-into-AUCTeX t
		  savinge-engine 'xetex       ; use xelatex default	    	        
	          TeX-auto-untabify t     ; remove all tabs before TeX
                  TeX-auto-save t
		  TeX-parse-self t
                  TeX-show-compilation nil
		  TeX-source-correlate-mode t	     ) ; display compilation windows
            (TeX-global-PDF-mode t)       ; PDF mode enable, not plain
            (setq TeX-save-query nil)
            (imenu-add-menubar-index)
	    (setq abbrev-mode t)))
            ;;(setq local-abbrev-table TeX-mode-abbrev-table)))
            ;;(define-key LaTeX-mode-map (kbd "TAB") 'TeX-complete-symbol)


;; configuration for TeX-fold-mode
;; add entries you want to be fold, or comment that needn't to be fold.
(setq TeX-fold-env-spec-list
      (quote (("[figure]" ("figure"))
              ("[table]" ("table"))
              ("[itemize]" ("itemize"))
              ("[description]" ("description"))
              ("[tabular]" ("tabular"))
              ("[frame]" ("frame"))
              ("[array]" ("array"))
              ("[code]" ("lstlisting"))
              ("[eqnarray]" ("eqnarray"))
              )))

;; make the toc displayed on the left
(setq reftex-toc-split-windows-horizontally t)
;; adjust the fraction
(setq reftex-toc-split-windows-fraction 0.3)
;;(require 'sumatra-forward)
(add-hook 'LaTeX-mode-hook (lambda () (local-set-key "\C-c\C-p" 'sumatra-jump-to-line)))
(add-hook 'tex-mode-hook (lambda () (local-set-key "\C-c\C-p" 'sumatra-jump-to-line)))



(provide 'init-latex)
