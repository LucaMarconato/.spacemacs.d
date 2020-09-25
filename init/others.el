;; configuration of layers

;; Bind clang-format-region to C-M-tab in all modes:
(global-set-key [C-M-tab] 'clang-format-region)
;; Bind clang-format-buffer to tab on the c++-mode only:
(add-hook 'c++-mode-hook 'clang-format-bindings)
(defun clang-format-bindings ()
  (define-key c++-mode-map [tab] 'clang-format-buffer))

;; other configurations
(subword-mode +1)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "M-n") 'back-to-indentation)

(when (fboundp 'winner-mode) (winner-mode 1))
(global-set-key (kbd "C-c h") 'winner-undo)
(global-set-key (kbd "C-c l") 'winner-redo)

;; (debug-watch 'window-combination-resize)
(setq window-combination-resize nil)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq mac-command-modifier 'super)
(add-hook 'undo-tree-mode-hook (lambda () (setq undo-tree-visualizer-diff nil)))
;; (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

(setq helm-buffer-max-length 40)
;; (setq dired-use-ls-dired t)
;; ugly, but I need to make this working now
;; (add-to-list 'load-path "/Users/macbook/.emacs.d/elpa/develop/org-trello-20180331.631/")
;; (require 'org-trello)
;; this was in custom-set-variables '(org-trello-current-prefix-keybinding "C-c o" nil (org-trello)))
;; (setq org-trello-current-prefix-keybinding "C-c t")
(spacemacs/toggle-auto-fill-mode-off)

;; (require 'multi-web-mode)
;; (setq mweb-default-major-mode 'html-mode)
;; (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                   (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                   (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;; (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;; (multi-web-global-mode 1)
(setq ispell-program-name "/usr/local/bin/aspell")
(custom-set-variables
 '(vlf-application 'dont-ask))

(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
           (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
         (current-buffer)))

(setq browse-url-browser-function 'browse-url-chrome)
(setq browse-url-chrome-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")

; to see the live preview of a markdown file in the browser use:
; M-x httpd-start
; M-x impatient-mode
; go to localhost:8080/imp
; M-x imp-set-user-filter RET markdown-html RET
