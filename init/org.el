;; set maximum indentation for description lists
(setq org-list-description-max-indent 5)

;; prevent demoting heading also shifting text inside sections
;; (setq org-adapt-indentation nil)

(with-eval-after-load 'org
  ;; (setq-default
  ;;  org-pretty-entities nil
  ;;               org-hide-leading-stars nil
  ;;               org-pretty-entities-include-supersubscripts nil
  ;;               )

  (defun my-org-settings ()
    (spacemacs/toggle-auto-fill-mode-on)
    ;; (setq fill-column 240)
    (setq org-adapt-indentation t)
    ;; (spacemacs/toggle-spelling-checking-on)
    (org-indent-mode))

  (add-hook 'org-mode-hook #'my-org-settings))

(defun org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
             (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
             (beg (if globalp
                    (point-min)
                    (point)))
             (end (if globalp
                    (point-max)
                    (if (eq state 'children)
                      (save-excursion
                        (outline-next-heading)
                        (point))
                      (org-end-of-subtree t)))))
        (goto-char beg)
        (while (re-search-forward org-drawer-regexp end t)
          (save-excursion
            (beginning-of-line 1)
            (when (looking-at org-drawer-regexp)
              (let* ((start (1- (match-beginning 0)))
                     (limit
                       (save-excursion
                         (outline-next-heading)
                           (point)))
                     (msg (format
                            (concat
                              "org-cycle-hide-drawers:  "
                              "`:END:`"
                              " line missing at position %s")
                            (1+ start))))
                (if (re-search-forward "^[ \t]*:END:" limit t)
                  (outline-flag-region start (point-at-eol) t)
                  (user-error msg))))))))))

;; Some initial languages we want org-babel to support
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   (R . t)
   (ditaa . t)
   (perl . t)
   (gnuplot t)
   ))

; emoji in org mode, as discussed here https://github.com/iqbalansari/emacs-emojify/issues/35 
(with-eval-after-load 'emojify
  (remove-hook 'emojify-inhibit-functions #'emojify-in-org-tags-p))

;; (define-key org-mode-map (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-switchb)
(defcustom org-export-html-protect-char-alist
  '(("&" . "&amp;")
    ("<" . "&lt;")
    (">" . "&gt;")
    (":turtle:" . "&#x1f422;")
    (":dash:" . "&#x1f4a8;")
    (":-)" . "&#x1f60a;")
    (":-(" . "&#x1f61e;"))
  "Alist of characters to be converted by `org-html-protect'."
  :group 'org-export-html
  :version "24.1"
  :type '(repeat (cons (string :tag "Character")
                       (string :tag "HTML equivalent"))))

(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "URGENT" "FUTURE" "MAYBE" "LATER" "DONE")))

(setq org-agenda-skip-function-global 
      '(org-agenda-skip-entry-if 'todo '("MAYBE" "LATER" "FUTURE")))
;; (setq org-agenda-skip-function-global nil)

 (setq org-todo-keyword-faces
       '(("MAYBE" :foreground "black") ;:box (:line-width 2 :style released-button))
         ("LATER" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
         ;; ("TODO" :background "red1" :foreground "black" :weight bold) ;:box (:line-width 2 :style released-button))
         ("IN-PROGRESS" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
         ("URGENT" :background "red" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
         ("FUTURE" :foreground "brown" :weight bold)))

;; ("DONE" :background "forest green" :weight bold)))

(setq org-agenda-custom-commands
      '(("x" agenda)
        ("y" agenda*)
        ("w" todo "FUTURE")))
(setq org-columns-default-format
      "%25ITEM %TODO %3PRIORITY %TIMESTAMP")

; supporting emails in org via org-protocol
(defun open-mail-in-apple-mail (message)
  (shell-command
   (format "open -a \"Mail.app\" \"message:%s\"" message)))

; add support for message:// links
(org-add-link-type "message" 'open-mail-in-apple-mail)
