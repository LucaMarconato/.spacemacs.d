(defun sync-with-el (name)
  (message name)
  "Syncing with el"
  (interactive)
  (let ((file name)
        (script "sh sync_with_el.sh"))
    ;; (script "touch ~/Desktop/ehiehiehiehi"))
    (unless file (user-error "Buffer must be visiting a file"))
    (shell-command (format "%s %s" script (shell-quote-argument file)))))


(defun sync-with-el-compilation-finish-function(file) (interactive)
       (sync-with-el file)
       ;; (insert "ehiehiehiehi")
       (remove-hook 'TeX-after-compilation-finished-functions 'sync-with-el-compilation-finish-function nil)
       )

(global-set-key (kbd "H-<backspace>") '(lambda () (interactive)
                                         (setq file buffer-file-name)
                                         (add-hook 'TeX-after-compilation-finished-functions 'sync-with-el-compilation-finish-function) 
                                         (TeX-command-master)))

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))

(add-hook 'LaTeX-mode-hook '(lambda () (interactive) (setq fill-column 10000)))
(setq TeX-insert-braces nil)
