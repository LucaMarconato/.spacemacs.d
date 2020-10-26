
(setq org-ref-default-bibliography '("~/Papers/references.bib")
      org-ref-pdf-directory "~/Papers/"
      org-ref-bibliography-notes "~/Papers/notes.org")



(setq org-ref-open-pdf-function
      (lambda (fpath)
        (start-process "zathura" "*helm-bibtex-zathura*" "/Users/macbook/Desktop/Build/Products/Debug/openEl.app" fpath)))
