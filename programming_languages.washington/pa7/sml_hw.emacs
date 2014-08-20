(defun rerun-sml-assignment ()
  (interactive)
  (run-sml "sml" "hw7testsprovided.sml"))

(global-set-key (kbd "C-p") 'rerun-sml-assignment)
