;;; header_config.el --- 
;; 
;; Filename: header_config.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:32:50 2013 (+0200)
;; Version: 
;; Last-Updated: Wed Jul 16 21:17:30 2014 (+0200)
;;           By: amine najahi
;;     Update #: 3
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

;;Next lines are needed to print my mail address and webpage in header
(defun user-mail-address()
  (interactive)
  (message "amine.najahi@univ-perp.fr")
  )
(defun user-web-url()
  (interactive)
  (message "http://perso.univ-perp.fr/mohamedamine.najahi")
  )

(add-hook 'write-file-hooks 'auto-update-file-header)
(add-hook 'emacs-lisp-mode-hook 'auto-make-header)
(add-hook 'c-mode-common-hook   'auto-make-header)
(add-hook 'LaTeX-mode-hook   'auto-make-header)
(add-hook 'python-mode-hook   'auto-make-header)
(global-set-key (kbd "C-x C-h") 'make-header)
(global-set-key (kbd "C-x C-u") 'update-file-header)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; header_config.el ends here
