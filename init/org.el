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
