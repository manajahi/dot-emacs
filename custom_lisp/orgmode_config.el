;;; orgmode_config.el --- 
;; 
;; Filename: orgmode_config.el
;; Description: 
;; Author: amine najahi amine.najahi@univ-perp.fr
;; Maintainer: amine najahi amine.najahi@univ-perp.fr
;; Created: Tue Feb  4 11:37:59 2014 (+0100)
;; Version: 
;; Last-Updated: Wed Feb 17 23:15:21 2016 (+0100)
;;           By: Mohamed Amine Najahi
;;     Update #: 30
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
;;;; ----------------------  Org-mode  -------------------------------
(use-package org
  :init
  :config
  (require 'org-journal)
  (require 'org-install)
  (require 'org-agenda)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)

  (setq org-directory "~/Dropbox/org")
  (setq org-mobile-directory "~/Dropbox/Applications/MobileOrg")
  (setq org-mobile-inbox-for-pull "~/Dropbox/org/univ.org")

  (setq org-agenda-files (list "~/Dropbox/org/admin.org"
			       "~/Dropbox/org/misc.org"
			       "~/Dropbox/org/univ.org"))

  ;; (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE" "CANCELED")))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
  ;; number of days shown in the agenda
  (setq org-agenda-span 30)

  ;; number of days to warn abount deadlines
  (setq ord-deadline-warning-days 4)

  ;; to jump to links destinations with a simple return
  (setq org-return-follows-link 1)
(defvar org-journal-file "~/Documents/journal/journal.org"  
  "Path to OrgMode journal file.")  

(defvar org-journal-date-format "%d-%m-%Y"  
  "Date format string for journal headings.")

(setq org-journal-file-format "%d-%m-%Y")

;; (defun org-journal-entry ()  
;;   "Create a new diary entry for today or append to an existing one."  
;;   (interactive)  
;;   (switch-to-buffer (find-file org-journal-file))  
;;   (widen)  
;;   (let ((today (format-time-string org-journal-date-format)))  
;;     (beginning-of-buffer)  
;;     (unless (org-goto-local-search-forward-headings today nil t)  
;;       ((lambda ()   
;; 	 (org-insert-heading)  
;; 	 (insert today)  
;; 	 (insert "\n\n  \n"))))  
;;     (beginning-of-buffer)  
;;     (org-show-entry)  
;;     (org-narrow-to-subtree)  
;;     (end-of-buffer)  
;;     (backward-char 2)  
;;     (unless (= (current-column) 2)  
;;       (insert "\n\n  "))))

  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; orgmode_config.el ends here
