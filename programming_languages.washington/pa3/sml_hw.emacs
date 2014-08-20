(defun rerun-sml-assignment ()
  (interactive)
  (run-sml "sml" "exam.sml"))

(global-set-key (kbd "C-p") 'rerun-sml-assignment)
