(defun rerun-sml-assignment ()
  (interactive)
  (run-sml "sml" "hw3tests.sml"))

(global-set-key (kbd "C-p") 'rerun-sml-assignment)
