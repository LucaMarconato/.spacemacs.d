(add-hook 'octave-mode-hook
          (lambda ()
            (setq comment-start "% ")))

(defun insert-matlab-path ()
  (interactive)
  (insert "/Applications/MATLAB_R2017a.app/bin/matlab -nosplash -nodesktop"))


