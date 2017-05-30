;;启动窗口设置

;;(require 'dashboard)

;;(require 'f)
;;(require 's)
;;(require 'bookmark)
;;(require 'recentf)
;;(dashboard-setup-startup-hook)


(require 'f)
(require 's)
(require 'bookmark)
(require 'recentf)
(require 'all-the-icons)
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard faces
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defface prolusion--dashboard-git-face     '((t (:height 1.0 :foreground "green"   :bold nil))) "")
(defface prolusion--dashboard-hash-face    '((t (:height 1.0 :foreground "peru"    :bold nil))) "")
(defface prolusion--dashboard-info-face    '((t (:height 1.0 :foreground "#bc6ec5" :bold t)))   "")
(defface prolusion--dashboard-banner-face  '((t (:height 1.5 :foreground "#4f97d7" :bold t)))   "")
(defface prolusion--dashboard-section-face '((t (:height 1.1 :foreground "#4f97d7" :bold t)))   "")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard functions
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun prolusion//dashboard-subseq (seq start end)
  (let ((len (length seq)))
    (cl-subseq seq start (and (number-or-marker-p end) (min len end)))))

(defvar prolusion-dashboard-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map [tab] 'widget-forward)
    (define-key map [backtab] 'widget-backward)
    (define-key map (kbd "RET") 'widget-button-press)
    (define-key map [down-mouse-1] 'widget-button-click)
    (define-key map (kbd "g") #'prolusion/dashboard-insert-startupify-lists)
    map))

(define-derived-mode prolusion-dashboard-mode special-mode "Dashboard"
  ""
  :group 'prolusion-dashboard
  :syntax-table nil
  :abbrev-table nil
  (whitespace-mode -1)
  (linum-mode -1)
  (setq inhibit-startup-screen t)
  (setq buffer-read-only t)
  (setq truncate-lines t))

(defgroup prolusion-dashboard nil
  ""
  :group 'prolusion-dashboard)

(defcustom prolusion--dashboard-page-separator "\n\n"
  ""
  :type 'string
  :group 'prolusion/dashboard)

(defconst prolusion--dashboard-banner-margin 35 "")

(defvar prolusion--dashboard-item-generators '((recents    . prolusion//dashboard-insert-recents)
                                               (bookmarks  . prolusion//dashboard-insert-bookmarks)
                                               (workspaces . prolusion//dashboard-insert-workspaces)
                                               (info       . prolusion//dashboard-insert-info)))

(defvar prolusion--dashboard-items '((recents    . 20)
                                    (bookmarks  . 10)
                                    (workspaces . 10)
                                    (info       . 10)) "")

(defvar prolusion--dashboard-items-default-length 20 "")

(defvar prolusion--dashboard-buffer-last-width nil "")

(defconst prolusion--dashboard-buffer-name "*dashboard*" "")

(defun prolusion//dashboard-insert-banner ()
  ""
  (goto-char (point-max))
  (insert
   (with-temp-buffer
     (setq banner (propertize "?" 'face 'prolusion--dashboard-banner-face))
     (insert banner)
     (let ((banner-width 0))
       (while (not (eobp))
         (let ((line-length (- (line-end-position) (line-beginning-position))))
           (if (< banner-width line-length)
               (setq banner-width line-length)))
         (forward-line 1))
       (goto-char 0)
       (let ((margin (max 0 (floor (/ (- dashboard-banner-length banner-width) 2)))))
         (while (not (eobp))
           (insert (make-string margin ?\ ))
           (forward-line 1))))
     (buffer-string))))

(defun prolusion//dashboard-insert-badge ()
  ""
  (let* ((spec (create-image (expand-file-name "~/.emacs.d/nudt.png" )))
         (size (image-size spec))
         (width (car size))
         (left-margin (max 0 (floor (- dashboard-banner-length width) 2))))
    (goto-char (point-max))
    (insert "\n")
    (insert (make-string left-margin ?\ ))
    (insert-image spec)
    (insert "\n")))

(defun prolusion//dashboard-insert-file-list (list-display-name list)
  ""
  (setq list-display-name-faced (propertize list-display-name 'face 'prolusion--dashboard-section-face))
  (insert list-display-name-faced)
  (when (car list)
    (mapc (lambda (el)
            (insert "\n    ")
            (widget-create 'push-button
                           :action `(lambda (&rest ignore) (find-file-existing ,el))
                           :mouse-face 'highlight
                           :follow-link "\C-m"
                           :button-prefix ""
                           :button-suffix ""
                           :format "%[%t%]"
                           (abbreviate-file-name el)))
          list)))

(defun prolusion//dashboard-insert-project-list (list-display-name list)
  ""
  (setq list-display-name-faced (propertize list-display-name 'face 'prolusion--dashboard-section-face))
  (insert list-display-name-faced)
  (when (car list)
    (mapc (lambda (el)
            (insert "\n    ")
            (widget-create 'push-button
                           :action `(lambda (&rest ignore)
                                      (projectile-switch-project-by-name ,el))
                           :mouse-face 'highlight
                           :follow-link "\C-m"
                           :button-prefix ""
                           :button-suffix ""
                           :format "%[%t%]"
                           (abbreviate-file-name el)))
          list)))

(defun prolusion//dashboard-insert-bookmark-list (list-display-name list)
  ""
  (setq list-display-name-faced (propertize list-display-name 'face 'prolusion--dashboard-section-face))
  (insert list-display-name-faced)
  (when (car list)
    (mapc (lambda (el)
            (insert "\n    ")
            (widget-create 'push-button
                           :action `(lambda (&rest ignore) (bookmark-jump ,el))
                           :mouse-face 'highlight
                           :follow-link "\C-m"
                           :button-prefix ""
                           :button-suffix ""
                           :format "%[%t%]"
                           (format "%s - %s" el (abbreviate-file-name (bookmark-get-filename el)))))
          list)))

(defun prolusion//dashboard-insert-workspace-list (list-display-name list)
  ""
  (setq list-display-name-faced (propertize list-display-name 'face 'prolusion--dashboard-section-face))
  (insert list-display-name-faced)
  (when (car list)
    (mapc (lambda (el)
            (insert "\n    ")
            (widget-create 'push-button
                           :action `(lambda (&rest ignore) (persp-load-state-from-file ,el))
                           :mouse-face 'highlight
                           :follow-link "\C-m"
                           :button-prefix ""
                           :button-suffix ""
                           :format "%[%t%]"
                           (abbreviate-file-name el)))
          list)))

(defun prolusion//dashboard-insert-info-list (list-display-name list)
  ""
  (setq list-display-name-faced (propertize list-display-name 'face 'prolusion--dashboard-section-face))
  (insert list-display-name-faced)
  (when (car list)
    (mapc (lambda (el)
            (insert "\n    ")
            (widget-create 'push-button
                           :action `(lambda (&rest ignore) (find-file-existing ,el))
                           :mouse-face 'highlight
                           :follow-link "\C-m"
                           :button-prefix ""
                           :button-suffix ""
                           :format "%[%t%]"
                           (abbreviate-file-name el)))
          list)))

(defun prolusion//dashboard-insert-page-break ()
  ""
  (prolusion//dashboard-append prolusion--dashboard-page-separator))

(defun prolusion//dashboard-append (msg &optional messagebuf)
  ""
  (with-current-buffer (get-buffer-create prolusion--dashboard-buffer-name)
    (goto-char (point-max))
    (let ((buffer-read-only nil))
      (insert msg))))

(defmacro prolusion//dashboard-insert--shortcut (shortcut-char search-label &optional no-next-line)
  ""
  `(define-key prolusion-dashboard-mode-map ,shortcut-char
     (lambda ()
       (interactive)
       (unless (search-forward ,search-label (point-max) t)
         (search-backward ,search-label (point-min) t))
       ,@(unless no-next-line
           '((forward-line 1)))
       (back-to-indentation))))

(defun prolusion//dashboard-goto-link-line ()
  ""
  (interactive)
  (with-current-buffer prolusion--dashboard-buffer-name
    (goto-char (point-min))
    (re-search-forward "Homepage")
    (beginning-of-line)
    (widget-forward 1)))

(defun prolusion//dashboard-insert-recents (list-size)
  ""
  (recentf-mode)
  (when (prolusion//dashboard-insert-file-list
         "Recent Files:"
         (prolusion//dashboard-subseq recentf-list 0 list-size))
    (prolusion//dashboard-insert--shortcut "r" "Recent Files:")))

(defun prolusion//dashboard-insert-bookmarks (list-size)
  ""
  (when (prolusion//dashboard-insert-bookmark-list
         "Bookmarks:"
         (prolusion//dashboard-subseq (bookmark-all-names) 0 list-size))
    (prolusion//dashboard-insert--shortcut "m" "Bookmarks:")))


(defun prolusion//dashboard-insert-workspaces (list-size)
  ""
  (if (bound-and-true-p persp-mode)
      (progn
        (when (prolusion//dashboard-insert-workspace-list
               "Workspaces:"
               (prolusion//dashboard-subseq (f-glob (expand-file-name "*workspace*" prolusion-save-dir)) 0 list-size))
          (prolusion//dashboard-insert--shortcut "w" "Workspaces:")))))

(defun prolusion//dashboard-insert-info (list-size)
  ""
  (when (prolusion//dashboard-insert-info-list
         "Info:"
         (prolusion//dashboard-subseq (f-glob (expand-file-name "*" prolusion-info-dir)) 0 list-size))
    (prolusion//dashboard-insert--shortcut "i" "Info:")))

(defun prolusion/dashboard-resize-on-hook ()
  ""
  (let ((space-win (get-buffer-window prolusion--dashboard-buffer-name))
        (frame-win (frame-selected-window)))
    (when (and space-win
               (not (window-minibuffer-p frame-win)))
      (with-selected-window space-win
        (prolusion/dashboard-insert-startupify-lists)))))

(defun prolusion/dashboard-insert-startupify-lists ()
  ""
  (interactive)
  (let ((buffer-exists (buffer-live-p (get-buffer prolusion--dashboard-buffer-name)))
        (save-line nil))
    (when (or (not (eq prolusion--dashboard-buffer-last-width (window-width)))
              (not buffer-exists))
      (setq dashboard-banner-length (window-width)
            prolusion--dashboard-buffer-last-width dashboard-banner-length)
      (with-current-buffer (get-buffer-create prolusion--dashboard-buffer-name)
        (let ((buffer-read-only nil)
              (list-separator "\n\n"))
          (erase-buffer)
          ;;(cd "~/.emacs.d")
          ;;(setq version-faced (propertize "Prolusion version: " 'face 'prolusion--dashboard-info-face))
          ;;(insert version-faced)
          ;;(insert (format "%s %d.%d.%d - %s (%s) - %s (%s)\n" (all-the-icons-faicon "tag" :v-adjust 0) prolusion-version-major prolusion-version-minor prolusion-version-patch (all-the-icons-octicon "git-branch" :v-adjust 0) (s-trim (s-chop-prefix "* " (propertize (car (s-lines (shell-command-to-string "git branch"))) 'face 'prolusion--dashboard-git-face))) (all-the-icons-octicon "git-commit" :v-adjust 0) (propertize (s-chomp (shell-command-to-string "git rev-parse HEAD")) 'face 'prolusion--dashboard-hash-face)))
          (setq version-faced (propertize "    Emacs version: " 'face 'prolusion--dashboard-info-face))
          (insert version-faced)
          (insert (format "%s\n" (car (s-lines (emacs-version)))))
          (setq version-faced (propertize "        Init time: " 'face 'prolusion--dashboard-info-face))
          (insert version-faced)
          (insert (format "%s\n" (emacs-init-time)))
          (prolusion//dashboard-insert-page-break)
          (mapc (lambda (els)
                  (let* ((el (or (car-safe els) els))
                         (list-size
                          (or (cdr-safe els)
                              prolusion--dashboard-items-default-length))
                         (item-generator
                          (cdr-safe (assoc el prolusion--dashboard-item-generators))))
                    (funcall item-generator list-size)
                    (prolusion//dashboard-insert-page-break)))
                prolusion--dashboard-items)
          (prolusion-dashboard-mode)
          (goto-char (point-min)))))))

;;;###autoload

(defun prolusion/dashboard-setup-startup-hook ()
  ""
  (if (< (length command-line-args) 2)
      (progn
        (add-hook 'after-init-hook
                  (lambda () (prolusion/dashboard-insert-startupify-lists)))
        (add-hook 'window-setup-hook
                  (lambda ()
                    (add-hook 'window-configuration-change-hook 'prolusion/dashboard-resize-on-hook)
                    (prolusion/dashboard-resize-on-hook)))
        (add-hook 'emacs-startup-hook
                  '(lambda ()
                     (switch-to-buffer prolusion--dashboard-buffer-name)
                     (redisplay)
                     (goto-char (point-min)))))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard forward declarations
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(declare-function bookmark-all-names "ext:bookmark.el")
(declare-function bookmark-get-filename "ext:bookmark.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dashboard setup
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (display-graphic-p)
  (prolusion/dashboard-setup-startup-hook))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'init-prolusion-dashboard1)
