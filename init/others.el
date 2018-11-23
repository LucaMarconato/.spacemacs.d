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
;; (setq mac-command-modifier 'super)
(add-hook 'undo-tree-mode-hook (lambda () (setq undo-tree-visualizer-diff nil)))
;; (global-set-key (kbd "M-3") '(lambda () (interactive) (insert "#")))

(setq helm-buffer-max-length 40)
;; (setq dired-use-ls-dired t)
