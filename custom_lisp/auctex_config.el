;;; auctex_config.el --- 
;; 
;; Filename: auctex_config.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:42:38 2013 (+0200)
;; Version: 
;; Last-Updated: Sun Oct 19 22:38:59 2014 (+0200)
;;           By: amine najahi
;;     Update #: 20
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

;;Make pdf the default output for auctex
(require 'tex)
(setq TeX-PDF-mode t)
(TeX-global-PDF-mode t)

;;Enable parse on load.
(setq TeX-parse-self t)
(setq TeX-auto-save t)

;;automatically ask for the master file
(setq-default TeX-master nil)

;; make these behave as verbatim (for highlighting)
(setq LaTeX-verbatim-environments-local '("Verbatim" "lstlisting"))

;; print a todo block with AN as the author
(defun print_todo ()
  (interactive)
  (insert "\\todo[AN]{} ")
  (backward-char 2)
  )

;; print a todo in tex
(define-key TeX-mode-map (kbd "C-c t") 'print_todo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; auctex_config.el ends here
