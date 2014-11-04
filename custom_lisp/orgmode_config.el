;;; orgmode_config.el --- 
;; 
;; Filename: orgmode_config.el
;; Description: 
;; Author: amine najahi amine.najahi@univ-perp.fr
;; Maintainer: amine najahi amine.najahi@univ-perp.fr
;; Created: Tue Feb  4 11:37:59 2014 (+0100)
;; Version: 
;; Last-Updated: Wed Oct 15 19:48:54 2014 (+0200)
;;           By: amine najahi
;;     Update #: 26
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

;; (setq org-agenda-skip-scheduled-if-done t)
;; (setq org-agenda-skip-deadline-if-done t)
;; (setq org-agenda-skip-timestamp-if-done t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; orgmode_config.el ends here
