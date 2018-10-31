;; configuration of layers
;; c-c++ layer
(setq-default dotspacemacs-configuration-layers
              '((c-c++ :variables
                       c-c++-default-mode-for-headers 'c++-mode)))

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

(when (fboundp 'winner-mode) (winner-mode 1))
(global-set-key (kbd "C-c h") 'winner-undo)
(global-set-key (kbd "C-c l") 'winner-redo)
