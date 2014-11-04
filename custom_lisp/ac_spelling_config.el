;;; ac_spelling_config.el --- 
;; 
;; Filename: ac_spelling_config.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:47:10 2013 (+0200)
;; Version: 
;; Last-Updated: Thu Sep 25 13:59:05 2014 (+0200)
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


;;;; -------------------  Autocomplete  ------------------------------
(require 'auto-complete)
(global-auto-complete-mode t)
(setq ac-auto-start t)
(ac-flyspell-workaround)

;;;; -------------------  flyspell --------------------------------------
(add-hook 'text-mode-hook 'turn-on-flyspell)

;;;; ------Auto dictionary to automatically detect the language -------
;; (load "auto-dictionary.el")
;; (require 'auto-dictionary)
;; (add-hook 'flyspell-mode-hook (lambda () (auto-dictionary-mode 1)))

;;;; ------  To switch between the english and french language  -------
(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "english") "french" "english")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))
(global-set-key (kbd "<f8>")   'fd-switch-dictionary)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ac_spelling_config.el ends here
