(defvar arabeiser-cli-file-path (executable-find "racket")
  "Path to the program used by `run-arabeiser'")

(defvar arabeiser-cli-arguments '()
  "Commandline arguments to pass to `arabeiser-cli'")

(defvar arabeiser-mode-map
  (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
    ;; example definition
    (define-key map "\t" 'completion-at-point)
    map)
  "Basic mode map for `run-arabeiser'")

(defvar arabeiser-prompt-regexp "^\\(?:\\[[^@]+@[^@]+\\]\\)"
    "Prompt for `run-arabeiser'.")

(defun run-arabeiser ()
  "Run an inferior instance of `arabeiser-cli' inside Emacs."
  (interactive)
  (let* ((arabeiser-program arabeiser-cli-file-path)
	 (buffer (comint-check-proc "Arabeiser")))
    ;; pop to the "*Arabeiser*" buffer if the process is dead, the
    ;; buffer is missing or it's got the wrong mode.
    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'arabeiser-mode))
	     (comint-check-proc (current-buffer)))
	 (get-buffer-create (or buffer "*Arabeiser*"))
       (current-buffer)
       (setq bidi-paragraph-direction 'right-to-left)
       ))
    ;; create the comint process if there is no buffer.
   (unless buffer
      (apply 'make-comint-in-buffer "Arabeiser" buffer
	     arabeiser-program arabeiser-cli-arguments)
      (arabeiser-mode))))


(defun arabeiser--initialize ()
  "Helper function to initialize Arabeiser"
  (setq comint-process-echoes t)
  (setq comint-use-prompt-regexp t))

(define-derived-mode arabeiser-mode comint-mode "Arabeiser"
    "Major mode for `run-arabeiser'.

\\<arabeiser-mode-map>"
    nil "Arabeiser"
    ;; this sets up the prompt so it matches things like: [foo@bar]
    (setq comint-prompt-regexp arabeiser-prompt-regexp)
    ;; this makes it read only; a contentious subject as some prefer the
    ;; buffer to be overwritable.
    (setq comint-prompt-read-only t)
    ;; this makes it so commands like M-{ and M-} work.
    (set (make-local-variable 'paragraph-separate) "\\'")
;    (set (make-local-variable 'font-lock-defaults) '(arabeiser-font-lock-keywords t))
    (set (make-local-variable 'paragraph-start) arabeiser-prompt-regexp))

;; this has to be done in a hook. grumble grumble.
(add-hook 'arabeiser-mode-hook 'arabeiser--initialize)


(provide 'arabeiser)
