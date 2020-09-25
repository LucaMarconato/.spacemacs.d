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

(global-set-key (kbd "s-<backspace>") '(lambda () (interactive)
                                         (setq file buffer-file-name)
                                         (add-hook 'TeX-after-compilation-finished-functions 'sync-with-el-compilation-finish-function) 
                                         (TeX-command-master)))
(global-set-key (kbd "H-<backspace>") '(lambda () (interactive)
                                         (setq file buffer-file-name)
                                         (add-hook 'TeX-after-compilation-finished-functions 'sync-with-el-compilation-finish-function) 
                                         (TeX-command-master)))

(setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))

(add-hook 'LaTeX-mode-hook '(lambda () (interactive) (setq fill-column 10000)))
(setq TeX-insert-braces nil)


;; (let ((is-mac (string-equal system-type "darwin")))
  ;; (when is-mac
;;     ;; make fonts look better with anti-aliasing
;;     (setq mac-allow-anti-aliasing t)
;;     ;; delete files by moving them to the trash
;;     (setq delete-by-moving-to-trash t)
;;     (setq trash-directory "~/.Trash")

;;     ;; Don't make new frames when opening a new file with Emacs
;;     (setq ns-pop-up-frames nil)

;;     ;; non-lion fullscreen
;;     (setq ns-use-native-fullscreen nil)

;;     ;; Set modifier keys
;;     (setq mac-option-modifier 'meta) ;; Bind meta to ALT
;;     (setq mac-command-modifier 'super) ;; Bind apple/command to super if you want
;;     (setq mac-function-modifier 'hyper) ;; Bind function key to hyper if you want 
;;     (setq mac-right-option-modifier 'none) ;; unbind right key for accented input

;;     ;; Make forward delete work 
;;     (global-set-key (kbd "<H-backspace>") 'delete-forward-char)

;;     ;; Keybindings
;;     (global-set-key (kbd "s-=") 'scale-up-font)
;;     (global-set-key (kbd "s--") 'scale-down-font)
;;     (global-set-key (kbd "s-0") 'reset-font-size)
;;     (global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
;;     (global-set-key (kbd "s-v") 'yank)
;;     (global-set-key (kbd "s-c") 'evil-yank)
;;     (global-set-key (kbd "s-a") 'mark-whole-buffer)
;;     (global-set-key (kbd "s-x") 'kill-region)
;;     (global-set-key (kbd "s-w") 'delete-window)
;;     (global-set-key (kbd "s-W") 'delete-frame)
;;     (global-set-key (kbd "s-n") 'make-frame)
;;     (global-set-key (kbd "s-z") 'undo-tree-undo)
;;     (global-set-key (kbd "s-s")
;;                     (lambda ()
;;                       (interactive)
;;                       (call-interactively (key-binding "\C-x\C-s"))))
;;     (global-set-key (kbd "s-Z") 'undo-tree-redo)
;;     (global-set-key (kbd "C-s-f") 'toggle-frame-fullscreen)
;;     ;; Emacs sometimes registers C-s-f as this weird keycode
;;     (global-set-key (kbd "<C-s-268632070>") 'toggle-frame-fullscreen)
;;     ))
