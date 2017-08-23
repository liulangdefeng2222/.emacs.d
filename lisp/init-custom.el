;;




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-engine (quote xetex))
 '(TeX-source-correlate-method (quote synctex))
 '(TeX-source-correlate-mode t)
 '(TeX-source-correlate-start-server t)
 '(TeX-view-program-list
   (quote
    (("SumatraPDF"
      ("\"C:/Program Files/SumatraPDF/SumatraPDF.exe\" -reuse-instance"
       (mode-io-correlate " -forward-search %b %n ")
       " %o")))))
 '(TeX-view-program-selection
   (quote
    (((output-dvi style-pstricks)
      "dvips and start")
     (output-dvi "SumatraPDF")
     (output-pdf "SumatraPDF")
     (output-html "start"))))
 '(ac-auto-show-menu 0.05)
 '(ac-auto-start 1)
 '(ac-comphist-threshold 1.0)
 '(ac-flycheck-poll-completion-end-interval 0.1)
 '(ac-modes
   (quote
    (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode nim-mode c-mode cc-mode c++-mode objc-mode swift-mode go-mode java-mode malabar-mode clojure-mode clojurescript-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js-jsx-mode js2-mode js2-jsx-mode coffee-mode php-mode css-mode scss-mode less-css-mode elixir-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode apples-mode latex-mode org-mode nil)))
 '(cfs--current-profile "profile1" t)
 '(cfs--profiles-steps (quote (("profile1" . 4))) t)
 '(company-dabbrev-time-limit 0.08)
 '(company-idle-delay 0.08)
 '(company-minimum-prefix-length 1)
 '(dashboard-page-separator
   "
________________________________________________________________________________
")
 '(default-frame-alist (quote ((vertical-scroll-bars) (Lucida\ Console\  . 12))))
 '(fringe-mode (quote (1 . 1)) nil (fringe))
 '(ido-enable-flex-matching t)
 '(neo-theme (quote classic) t)
 '(org-agenda-files (list org-directory))
 '(org-directory "~/org")
 '(org-log-done (quote note))
 '(org-log-reschedule (quote note))
 '(org-pomodoro-long-break-length 40)
 '(org-publish-timestamp-directory "~\\org\\.org-timestamps\\")
 '(org-support-shift-select (quote always))
 '(package-selected-packages
   (quote
    (ace-window idle-require ivy-dired-history company no-littering ox-latex-chinese slime workgroups2 org-bullets dashboard unicode-fonts wgrep langtool counsel-dash magit-popup org with-editor bind-key keyfreq chinese-fonts-setup all-the-icons neotree cdlatex latex-preview-pane stripe-buffer dired+ artbollocks-mode ido-ubiquitous dired-icon diredful auto-complete matlab-mode magit use-package swiper-helm abyss-theme popwin auto-yasnippet yasnippet org-pomodoro flycheck ag iedit smartparens powerline window-numbering molokai-theme package-build shut-up epl git commander f dash s auctex cl-lib)))
 '(popwin:popup-window-position (quote right))
 '(popwin:popup-window-width 80)
 '(which-key-idle-delay 0.2)
 '(window-min-height 4)
 '(window-min-width 10))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:inherit nil :background "gray42"))))
 '(iedit-occurrence ((t (:inherit region))))
 '(region ((t (:inherit highlight :background "indian red")))))


(provide 'init-custom)
