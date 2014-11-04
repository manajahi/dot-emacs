;;; .gnus --- 
;; 
;; Filename: .gnus
;; Description: 
;; Author: amine najahi amine.najahi@univ-perp.fr
;; Maintainer: amine najahi amine.najahi@univ-perp.fr
;; Created: Thu May 15 19:29:20 2014 (+0200)
;; Version: 
;; Last-Updated: Fri Jul 25 11:10:42 2014 (+0200)
;;           By: amine najahi
;;     Update #: 50
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

(setq auth-sources '("~/.emacs.d/.authinfo.gpg"))

(setq gnus-select-method
	'(nnimap "univ"
		(nnimap-address "imap.univ-perp.fr")
		(nnimap-server-port 993)
		(nnimap-stream ssl))
             )

;; (add-to-list 'gnus-secondary-select-methods
;;       '(nnimap "gmail"
;;       	       (nnimap-address "imap.gmail.com")
;;       	       (nnimap-server-port 993)
;;       	       (nnimap-stream ssl)))

(add-to-list 'gnus-secondary-select-methods
	     '(nntp "news.gmane.org"))

(add-to-list 'gnus-secondary-select-methods
	     '(nntp "news.gwene.org"))

;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials '(("smtp.gmail.com" 587
;; 				   "mohaminaj@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587
;;       gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; automatically toggle gnus-topics for the group view
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)
(setq gnus-permanently-visible-groups ".*")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; .gnus ends here
