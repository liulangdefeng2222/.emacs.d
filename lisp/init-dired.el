;;(add-hook 'dired-mode-hook 'turn-on-stripe-buffer-mode)
;;(add-hook 'dired-mode-hook 'stripe-listify-buffer)

;; search file name only when focus is over file
(setq dired-isearch-filenames 'dwim)
; Listing directory failed but access-file worked
(when (eq system-type 'darwin)
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

(defun diredext-exec-git-command-in-shell (command &optional arg file-list)
  "Run a shell command `git COMMAND`' on the marked files.
if no files marked, always operate on current line in dired-mode
"
  (interactive
   (let ((files (dired-get-marked-files t current-prefix-arg)))
     (list
      ;; Want to give feedback whether this file or marked files are used:
      (dired-read-shell-command "git command on %s: " current-prefix-arg files)
      current-prefix-arg
      files)))
  (unless (string-match "[*?][ \t]*\\'" command)
    (setq command (concat command " *")))
  (setq command (concat "git " command))
  (dired-do-shell-command command arg file-list)
  (message command))

(defvar binary-file-name-regexp "\\.\\(avi\\|pdf\\|mp[34g]\\|mkv\\|exe\\|3gp\\|rmvb\\|rm\\)$"
  "Is binary file name?")

;; avoid accidently edit huge media file in dired
(defadvice dired-find-file (around dired-find-file-hack activate)
  (if (string-match-p binary-file-name-regexp (dired-get-file-for-visit))
      (if (yes-or-no-p "Edit binary file?")
          ad-do-it)
    ad-do-it))

(defadvice dired-guess-default (after dired-guess-default-after-hack activate)
  (if (string-match-p "^mplayer -quiet" ad-return-value)
      (let* ((dir (file-name-as-directory (concat default-directory
                                                  "Subs")))
             basename)
        (cond
         ((file-exists-p (concat dir "English.sub"))
          (setq ad-return-value (concat ad-return-value
                                        " -vobsub Subs/English")))
         ((file-exists-p (concat dir "Chinese.sub"))
          (setq ad-return-value (concat ad-return-value
                                        " -vobsub Subs/Chinese")))
         ((file-exists-p (concat dir (setq basename (file-name-base (car (dired-get-marked-files 'no-dir)))) ".sub"))
          (setq ad-return-value (concat ad-return-value
                                        " -vobsub Subs/" basename)))
         ((file-exists-p (concat dir "English.srt"))
          (setq ad-return-value (concat ad-return-value
                                        " -sub Subs/English.srt")))
         ((file-exists-p (concat dir "Chinese.srt"))
          (setq ad-return-value (concat ad-return-value
                                        " -sub Subs/Chinesesrt")))
         ((file-exists-p (concat dir (setq basename (file-name-base (car (dired-get-marked-files 'no-dir)))) ".sub"))
          (setq ad-return-value (concat ad-return-value
                                        " -sub Subs/" basename ".srt"))))))
  ad-return-value)

;; @see http://blog.twonegatives.com/post/19292622546/dired-dwim-target-is-j00-j00-magic
;; op open two new dired buffers side-by-side and give your new-found automagic power a whirl.
;; Now combine that with a nice window configuration stored in a register and you抳e got a pretty slick work flow.
(setq dired-dwim-target t)

(eval-after-load 'dired
  '(progn
     ;; from 24.4, dired+ can show/hide dired details by press "("
     (define-key dired-mode-map "/" 'dired-isearch-filenames)
     (define-key dired-mode-map "\\" 'diredext-exec-git-command-in-shell)

     (require 'dired+)
     (setq dired-recursive-deletes 'always)
     (dolist (file `(((if *unix* "zathura" "open") "pdf" "dvi" "pdf.gz" "ps" "eps")
                     ("7z x" "rar" "zip" "7z") ; "e" to extract, "x" to extract with full path
                     ((if (not *is-a-mac*) (my-guess-mplayer-path) "open")  "ogm" "avi" "mpg" "rmvb" "rm" "flv" "wmv" "mkv" "mp4" "m4v" "webm" "part")
                     ((concat (my-guess-mplayer-path) " -playlist") "list" "pls")
                     ((if *unix* "feh" "open") "gif" "jpeg" "jpg" "tif" "png" )
                     ("djview" "djvu")
                     ("firefox" "xml" "xhtml" "html" "htm" "mht" "epub")))
       (add-to-list 'dired-guess-shell-alist-user
                    (list (concat "\\." (regexp-opt (cdr file) t) "$")
                          (car file))))))

;; {{ Write backup files to own directory
;; @see https://www.gnu.org/software/emacs/manual/html_node/tramp/Auto_002dsave-and-Backup.html
(setq backup-enable-predicate
      (lambda (name)
        (and (normal-backup-enable-predicate name)
             (not (string-match-p binary-file-name-regexp name)))))

(if (not (file-exists-p (expand-file-name "~/.backups")))
  (make-directory (expand-file-name "~/.backups")))
(setq backup-by-coping t ; don't clobber symlinksm
      backup-directory-alist '(("." . "~/.backups"))
      delete-old-versions t
      version-control t  ;use versioned backups
      kept-new-versions 6
      kept-old-versions 2)

;; Donot make backups of files, not safe
;; @see https://github.com/joedicastro/dotfiles/tree/master/emacs
(setq vc-make-backup-files nil)
;; }}

;; {{ tramp setup
(add-to-list 'backup-directory-alist
             (cons tramp-file-name-regexp nil))
(setq tramp-chunksize 8192)

;; @see https://github.com/syl20bnr/spacemacs/issues/1921
;; If you tramp is hanging, you can uncomment below line.
;; (setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
;; }}
(defun my-dired-imenu-prev-index-position (&optional arg)
  "Go to the header line of previous directory."
  (interactive "p")
  (unless (= (line-number-at-pos) 1)
    (call-interactively 'dired-prev-subdir)
    t))

(defun my-dired-extract-index-name ()
  "Extract name of the current item for imenu."
  (save-excursion
    (back-to-indentation)
    (buffer-substring-no-properties
     (point)
     (1- (re-search-forward ":$")))))

(defun my-dired-imenu-create-index ()
  "Create `imenu' index for dired."
  (let* ((alist (imenu-default-create-index-function))
         (uniquified (f-uniquify-alist (-map 'car alist))))
    (--remove
     (= 0 (length (car it)))
     (--map (cons (cdr (assoc (car it) uniquified)) (cdr it))
            alist))))

(defun my-dired-imenu-init ()
  "Initialize `imenu' variables in current buffer."
  (setq-local imenu-prev-index-position-function
              'my-dired-imenu-prev-index-position)
  (setq-local imenu-extract-index-name-function
              'my-dired-extract-index-name)
  (setq-local imenu-create-index-function
              'my-dired-imenu-create-index))

(add-hook 'dired-mode-hook 'my-dired-imenu-init)

(provide 'init-dired)
