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
    (spacemacs/toggle-auto-fill-mode-off)
    (turn-on-visual-line-mode)
    ;; (setq fill-column 240)
    (setq org-adapt-indentation t)
    ;; (spacemacs/toggle-spelling-checking-on)
    (org-indent-mode)
    ;; (visual-line-fringe-indicators)
    )

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
(add-hook 'org-mode-hook #'emojify-mode)

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

(defun my-org-show-only-active-todos ()
  (setq org-agenda-skip-function-global 
        '(org-agenda-skip-entry-if 'todo '("MAYBE" "LATER" "NEVER" "FUTURE"))))

(defun my-org-show-all-todos ()
  (setq org-agenda-skip-function-global nil))

(my-org-show-only-active-todos)

;; (my-org-show-all-todos)
(global-set-key (kbd "C-c 9") (lambda () (interactive) (my-org-show-only-active-todos)))
(global-set-key (kbd "C-c 0") (lambda () (interactive) (my-org-show-all-todos)))
(setq org-agenda-custom-commands '(("f" "future todos" ((todo "FUTURE")))))

(setq org-todo-keywords
      '((sequence "WAITING" "PLANNED" "TODO-LATER" "RECURRENT" "TRAVEL" "TODO" "IN-PROGRESS" "TODAY" "NOW" "URGENT" "FUTURE" "NEVER" "MAYBE" "LATER" "|" "REFERENCE" "ENOUGH"
                  "DONE")))

(setq org-todo-keyword-faces
      '(("MAYBE" :foreground "#444444") ;:box (:line-width 2 :style released-button))
        ("NEVER" :foreground "black") ;:box (:line-width 2 :style released-button))
        ("LATER" :foreground "#666666" :weight bold) ;:box (:line-width 2 :style released-button))
        ;; ("TODO" :background "red1" :foreground "black" :weight bold) ;:box (:line-width 2 :style released-button))
        ;; ("IN-PROGRESS" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("TODAY" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("NOW" :background "orange" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("RECURRENT" :foreground "yellow" :foreground "#555555") ;:box (:line-width 2 :style released-button))
        ("TODO-LATER" :foreground "lightblue") ;:box (:line-width 2 :style released-button))
        ("PLANNED" :foreground "lightblue" :weight bold)
        ;; ("WAITING" :foreground "lightblue" :weight bold) 
        ("WAITING" :foreground "#98FB98" :weight bold) ;:box (:line-width 2 :style released-button)
        ("URGENT" :background "red" :foreground "#555555" :weight bold) ;:box (:line-width 2 :style released-button))
        ("REFERENCE" :foreground "forest green" :weight bold)
        ("ENOUGH" :foreground "forest green" :weight bold)
        ("FUTURE" :foreground "brown" :weight bold)))

;; ("DONE" :background "forest green" :weight bold)))

(setq org-todo-sort-order '("URGENT" "NOW" "TODAY" "IN-PROGRESS" "TODO" "RECURRENT" "TODO-LATER" "PLANNED" "WAITING" "TRAVEL" "FUTURE" "MAYBE" "LATER" "NEVER" "REFERENCE" "ENOUGH" "DONE"))

(setq org-agenda-custom-commands
      '(("x" agenda)
        ("y" agenda*)
        ("w" todo "FUTURE")

        ))
(setq org-columns-default-format
      "%25ITEM %TODO %3PRIORITY %TIMESTAMP")

(defun replace-in-string (what with in)
  (replace-regexp-in-string (regexp-quote what) with in nil 'literal))

; supporting emails in org via org-protocol
(defun open-mail-in-apple-mail (message)
  (shell-command
   (format "/Users/macbook/miniconda3/bin/python /Users/macbook/.spacemacs.d/init/open_email_url.py \"%s\"" (replace-in-string "\$" "\\$" message))))
   ;; (format "open -a \"Mail.app\" \"message:%s\"" message)))

; add support for message:// links
(org-add-link-type "message" 'open-mail-in-apple-mail)

(defun open-pdf-in-el (message)
  (shell-command
   (format "/Users/macbook/miniconda3/envs/zotero/bin/python \"/Users/macbook/programming/python/zotero/org_related.py\" --open-pdf-by-citation \"cit:%s\"" message)))
(org-add-link-type "cit" 'open-pdf-in-el)

;; (setq fill-column 240)
;; (auto-fill-mode -1)
;; (add-hook 'org-mode-hook #'turn-off-auto-fill)
(remove-hook 'org-mode-hook #'auto-fill-mode)
(remove-hook 'org-mode-hook #'turn-on-auto-fill)

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

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-nondirectory (buffer-file-name))
                  "_imgs/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename)))
                                        ; take screenshot
  (if (eq system-type 'darwin)
      (call-process "screencapture" nil nil nil "-i" filename))
  (if (eq system-type 'gnu/linux)
      (call-process "import" nil nil nil filename))
                                        ; insert into file if correctly taken
  (if (file-exists-p filename)
      (insert (concat "[[file:" filename "][image]]")))
  (org-display-inline-images t t))


(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c i")  'my-org-screenshot)))

;; (add-hook 'org-mode-hook 
;;           (lambda ()
;;             (defface hi-gray '((t (:foreground "#141414"))) :group 'hi-lock-faces)))

(add-hook 'org-mode-hook 
          (lambda ()
            ;; (defface hi-gray '((t (:foreground "#141414"))) :group 'hi-lock-faces)
            (highlight-regexp "x\"[0-9a-z]\\{10\\}\"$" 'hi-gray)))

;; something does not work here
;; (fset 'convert-to-org-zotero-url
;;       (kmacro-lambda-form [?\C-r ?c ?i ?t ?e return ?\C-f ?\C-f ?\C-f ?\C-d ?\C-f ?/ ?/ ?\C-r ?c ?i ?t return ?\C-  ?\C-e ?\C-x ?\C-x ?\[ ?\[ ?\C-e ?\] ?\[ ?e ?l ?\] ?\C-n ?\C-n ?\C-p ?\C-p backspace ?\C-x ?u ?p ?p ?p ?p ?p ?p ?q ?\C-  ?\C-a ?\C-w ?\C-x ?u ?p ?\C-e ?q ?\C-e backspace backspace backspace backspace ?\C-  ?\C-a ?\C-w ?\C-c ?\] return ?\C-x ?\( ?\] ?\[ ?e ?l ?\] ?\] ?\C-r ?c ?i ?t return ?\C-f ?\C-f ?\C-f ?\C-d ?\C-f ?/ ?/ ?\C-r ?c ?i return ?\[ ?\[ ?\C-f ?\C-f ?\C-f] 0 "%d"))

;; it should work but it doesn't

                                        ; to call before the org-gcal config, this is actually called later

;; (setq package-check-signature nil)

(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
                           (?B . (:foreground "orange"))
                           (?C . (:foreground "orange"))
                           ;; (?C . (:foreground "lightgreen"))
                           (?D . (:foreground "#626211"))
                           (?E . (:foreground "#626211"))
                           ))
