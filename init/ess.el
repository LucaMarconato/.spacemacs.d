(setq ess-smart-S-assign-key "§")
(global-set-key (kbd "C-=") (lambda () (interactive) (if (equal (char-before) (string-to-char " ")) (insert "<- ") (insert " <- "))))
(setq comint-prompt-read-only nil)
(setq ess-indent-level 4)
(setq ess-indent-offset 4)

(add-hook 'inferior-ess-mode-hook (lambda () (define-key inferior-ess-mode-map (kbd "C-k") 'kill-line)))

;; ;---------ESSH--------
;; (require 'essh)
;; (defun essh-sh-hook ()
;;   (define-key shell-mode-map "\C-c\C-r" 'pipe-region-to-shell)
;;   (define-key shell-mode-map "\C-c\C-b" 'pipe-buffer-to-shell)
;;   (define-key shell-mode-map "\C-c\C-j" 'pipe-line-to-shell)
;;   (define-key shell-mode-map "\C-c\C-n" 'pipe-line-to-shell-and-step)
;;   (define-key shell-mode-map "\C-c\C-f" 'pipe-function-to-shell)
;;   (define-key shell-mode-map "\C-c\C-d" 'shell-cd-current-directory))
;; (add-hook 'sh-mode-hook 'essh-sh-hook)
;; (add-hook 'matlab-mode-hook 'essh-sh-hook) ;maybe not working
;; (defun activate-essh ()
;;   (use-local-map shell-mode-map)
;;   (set-process-query-on-exit-flag ad-return-value nil)
;;   )
;; (global-set-key (kbd "<f4>") 'activate-essh)
