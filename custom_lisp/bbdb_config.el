;;; bbdb.el --- 
;; 
;; Filename: bbdb.el
;; Description: 
;; Author: amine najahi amine.najahi@univ-perp.fr
;; Maintainer: amine najahi amine.najahi@univ-perp.fr
;; Created: Wed May 28 16:00:44 2014 (+0200)
;; Version: 
;; Last-Updated: Sat Dec 26 03:57:25 2015 (+0100)
;;           By: Mohamed Amine Najahi
;;     Update #: 18
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ----------  Changes gnus init file location inside .emacs.d  --------- ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq gnus-init-file "~/.emacs.d/.gnus")
(setq gnus-startup-file "~/.emacs.d/.newrc")



;; load bbdb
(setq bbdb-file "~/.emacs.d/my_bbdb")
(require 'bbdb)

;; initialization
(bbdb-initialize 'gnus 'message)

(setq 
 bbdb-offer-save 1                        ;; 1 means save-without-asking

 
;; bbdb-use-pop-up t                        ;; allow popups for addresses
 bbdb-electric-p t                        ;; be disposable with SPC
 bbdb-popup-target-lines  1               ;; very small
 
 bbdb-dwim-net-address-allow-redundancy t ;; always use full name
 bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs

 bbdb-always-add-address t                ;; add new addresses to existing...
 ;; ...contacts automatically
 bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx

 bbdb-completion-type nil                 ;; complete on anything

 bbdb-complete-name-allow-cycling t       ;; cycle through matches
 ;; this only works partially

 bbbd-message-caching-enabled t           ;; be fast
 bbdb-use-alternate-names t               ;; use AKA


 bbdb-elided-display t                    ;; single-line addresses

 ;; auto-create addresses from mail
 bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook   
 bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
 ;; NOTE: there can be only one entry per header (such as To, From)
 ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html

 '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter"))
)

(setq bbdb-complete-mail-allow-cycling t)
(add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
(add-hook 'rmail-mode-hook 'bbdb-insinuate-rmail)
;(setq bbdb/mail-auto-create-p t)

;;(bbdb-insinuate-message)


;; (bbdb-mua-auto-update-init 'gnus 'message)

;; size of the bbdb popup
;;(setq bbdb-pop-up-window-size 10)

;; What do we do when invoking bbdb interactively
;; (setq bbdb-mua-update-interactive-p '(query . create))

;; Make sure we look at every address in a message and not only the
;; first one
;;(setq bbdb-message-all-addresses t)

;; use ; on a message to invoke bbdb interactively
;; (add-hook
;;  'gnus-summary-mode-hook
;;  (lambda ()
;;    (define-key gnus-summary-mode-map (kbd ";") 'bbdb-mua-edit-field)
;;    ))

;; ;; This is for non interactive bbdb invocation, but it was a bit
;; ;; too much
;; (setq bbdb-update-records-p 'query)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; bbdb.el ends here
