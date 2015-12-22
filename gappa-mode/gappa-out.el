(require 'gappa-fonts)

(setq gappa-out-font-lock-keywords
  `(
    ;; (,gappa-warning-regexp . font-lock-comment-face)
    (,gappa-warning-regexp . font-lock-keyword-face)
    (,gappa-results-regexp . font-lock-keyword-face)
    (,gappa-key-regexp . font-lock-keyword-face)
))

;; define the mode
(define-derived-mode gappa-out-mode fundamental-mode
  "gappa out"
  "Major mode for editing gappa scripts…"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((gappa-out-font-lock-keywords)))

  ;; ;; clear memory
  ;; (setq gappa-keywords-regexp nil)
  ;; (setq gappa-types-regexp nil)
  ;; (setq gappa-constants-regexp nil)
  ;; (setq gappa-events-regexp nil)
  ;; (setq gappa-functions-regexp nil)
)

;; TODO: set a keybinding for the following function
(defun call-gappa-on-current ()
  (interactive)
  (let ((command (concat (executable-find "gappa") " " (buffer-file-name)))
	(result-buffer "*gappa-results*"))
    (progn (shell-command command result-buffer)
	   (switch-to-buffer-other-window  result-buffer)
	   (gappa-out-mode))
    )
  )

;; define the gappa-mode
(provide 'gappa-out)

