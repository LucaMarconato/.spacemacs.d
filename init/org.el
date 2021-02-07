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
      '((sequence "WAITING" "TODO" "IN-PROGRESS" "TODAY" "NOW" "URGENT" "FUTURE" "NEVER" "MAYBE" "LATER" "DONE")))

(defun my-org-show-only-active-todos ()
  (setq org-agenda-skip-function-global 
        '(org-agenda-skip-entry-if 'todo '("MAYBE" "LATER" "NEVER" "FUTURE"))))
(defun my-org-show-all-todos ()
  (setq org-agenda-skip-function-global nil))

(my-org-show-only-active-todos)

;; (my-org-show-all-todos)

(setq org-todo-keyword-faces
      '(("MAYBE" :foreground "#444444") ;:box (:line-width 2 :style released-button))
        ("NEVER" :foreground "black") ;:box (:line-width 2 :style released-button))
        ("LATER" :foreground "#666666" :weight bold) ;:box (:line-width 2 :style released-button))
        ;; ("TODO" :background "red1" :foreground "black" :weight bold) ;:box (:line-width 2 :style released-button))
        ;; ("IN-PROGRESS" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("TODAY" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("NOW" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("WAITING" :foreground "#98FB98" :weight bold) ;:box (:line-width 2 :style released-button))
        ("URGENT" :background "red" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("FUTURE" :foreground "brown" :weight bold)))

;; ("DONE" :background "forest green" :weight bold)))

(setq org-agenda-custom-commands
      '(("x" agenda)
        ("y" agenda*)
        ("w" todo "FUTURE")

        ))
(setq org-columns-default-format
      "%25ITEM %TODO %3PRIORITY %TIMESTAMP")

; supporting emails in org via org-protocol
(defun open-mail-in-apple-mail (message)
  (shell-command
   (format "open -a \"Mail.app\" \"message:%s\"" message)))

; add support for message:// links
(org-add-link-type "message" 'open-mail-in-apple-mail)

(defun open-pdf-in-el (message)
  (shell-command
   (format "/Users/macbook/miniconda3/envs/zotero/bin/python \"/Users/macbook/programming/python/zotero/org_related.py\" --open-pdf-by-citation \"cit:%s\"" message)))
(org-add-link-type "cit" 'open-pdf-in-el)

(setq fill-column 240)
;; (auto-fill-mode -1)
;; (add-hook 'org-mode-hook #'turn-off-auto-fill)
(remove-hook 'org-mode-hook #'auto-fill-mode)
(remove-hook 'org-mode-hook #'turn-on-auto-fill)

(setq org-todo-sort-order '("URGENT" "NOW" "TODAY" "IN-PROGRESS" "TODO" "WAITING" "FUTURE" "MAYBE" "LATER" "NEVER" "DONE"))

(setq org-agenda-sorting-strategy 
      '((agenda priority-down category-down habit-down time-up )
        (todo todo-state-down priority-down category-down)
        (tags category-down priority-down)
        (search category-keep)))

(defun my:user-todo-sort (a b)
  "Sort todo based on which I want to see first"
  (when-let ((state-a (get-text-property 14 'todo-state a))
             (state-b (get-text-property 14 'todo-state b))
             (cmp (--map (cl-position-if (lambda (x)
                                           (equal x it))
                                         org-todo-sort-order)
                         (list state-a state-b))))
    (cond ((apply '> cmp) 1)
          ((apply '< cmp) -1)
          (t nil))))
(setq org-agenda-cmp-user-defined 'my:user-todo-sort)

