;;; eshell_config.el --- 
;; 
;; Filename: eshell_config.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:44:57 2013 (+0200)
;; Version: 
;; Last-Updated: Wed Jul 16 21:29:44 2014 (+0200)
;;           By: amine najahi
;;     Update #: 4
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

;; aliases file
(setq eshell-aliases-file "~/.emacs.d/eshell/alias")

;; store history without doubles
(setq eshell-hist-ignoredups t)

;; Change the default eshell prompt
(setq eshell-prompt-function
      (lambda ()
	(concat "[" (getenv "USER") "@" (system-name) "] "
		(eshell/pwd) (if (= (user-uid) 0) " # " " $ "))))
;; clear function inside eshell
(defun eshell/clear ()
  "to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

;; automatically open eshell on startup
;(add-hook 'after-init-hook 'eshell)
'(eshell-history-size 100)
'(eshell-save-history-on-exit f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; eshell_config.el ends here
