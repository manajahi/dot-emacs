;;; my_functions.el --- 
;; 
;; Filename: my_functions.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Fri Feb  1 10:34:52 2013 (+0100)
;; Version: 
;; Last-Updated: Fri Feb 12 14:52:39 2016 (+0100)
;;           By: Mohamed Amine Najahi
;;     Update #: 112
;; URL: http://perso.univ-perp.fr/mohamedamine.najahi
;; Keywords: 
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; 
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:

;;;; -------------------  Some functions -------------------------------
;; function to print the date
(defun date ()
  (interactive)
  (insert (shell-command-to-string "date"))
  (backward-char 1)
  (insert "\\\\")
  )

;; function to print ifndefs for conditional compilation
(defun header_cond ()
  "Inserts conditional compilation directives necessary for C and C++ programming"
  (interactive)
  (save-excursion
    (let* ((name (upcase-initials (buffer-name)))
           (case-fold-search nil)
           (name (substring (replace-regexp-in-string "\\([A-Z]\\)" "_\\1" name) 1 nil))
           (name (replace-regexp-in-string "\\." "" name))
           (name (upcase name))
           (upper (concat "#ifndef "
                          "__"
                          name
                          "__\n"
                          "#define "
                          "__"
                          name
                          "__\n"))
           (lower (concat "\n#endif //"
                          "__"
                          name
                          "__")))
      ;; (goto-char (return-to))                                                                                                                                      
      (insert upper)
      (goto-char (point-max))
      (insert lower)
      )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function to wrap text verbatim for an output stream in c++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun aux (stream str)
  (insert (concat stream " << \"" str "\" << endl;"))
  (insert "\n")
  )

(defun verbatim (start end stream)
  (interactive "r\nsStream's name: ")
  (setq str (buffer-substring start end))
  (let ((lin (split-string str "\n")))
    (let (value)
      (dolist (elt lin value)
	(aux stream elt))   
      )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Kill to the beginning of the line
(defun kill-start-of-line ()
  "kill from point to start of line"
  (interactive)
  (kill-line 0)
  )

;; Kill and close other window
(defun close-and-kill-next-pane ()
  "If there are multiple windows, then close the other pane and kill the buffer in it also."
  (interactive)
  (other-window 1)
  (kill-this-buffer)
  (if (not (one-window-p))
      (delete-window)))

(defun close-and-kill-this-pane ()
  "If there are multiple windows, then close the other pane and kill the buffer in it also."
  (interactive)
  (kill-this-buffer)
  (other-window 1)
  (if (not (one-window-p))
      (delete-window)))

;; To better handle gpg-agent either from terminal or from X
(defadvice epg--start (around advice-epg-disable-agent disable)
  "Don't allow epg--start to use gpg-agent in plain text terminals."
  (if (display-graphic-p)
      ad-do-it
    (let ((agent (getenv "GPG_AGENT_INFO")))
      (setenv "GPG_AGENT_INFO" nil) ; give us a usable text password prompt
      ad-do-it
      (setenv "GPG_AGENT_INFO" agent))))

(ad-enable-advice 'epg--start 'around 'advice-epg-disable-agent)
(ad-activate 'epg--start)

;; Checks for strings [n] and increments n
(defun my_inc ()
  (interactive)
  (query-replace-regexp-eval "\\[\\([[:digit:]]+\\)\\]"
			     (quote (concat "[" (number-to-string (+ 1 (string-to-number (match-string 1)))) "]")) nil
			     (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))
  )

;; Increments an integer at point (can take an optional
;; argument which is the number to add)
(defun my_increment_number_decimal  (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun mohaminaj-isearch-yank-symbol ()
    "Yank the symbol at point into the isearch minibuffer."
    (interactive)
    (isearch-yank-string
     (save-excursion
       (when (and (not isearch-forward)
		  isearch-other-end)
	 (goto-char isearch-other-end))
            (thing-at-point 'symbol))))

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "english") "francais" "english")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

;; To quickly jump to my init file
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") 'find-user-init-file)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; my_functions.el ends here

