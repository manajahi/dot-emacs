;;; autoload_modes.el --- 
;; 
;; Filename: autoload_modes.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:26:26 2013 (+0200)
;; Version: 
;; Last-Updated: Tue Dec 29 11:47:17 2015 (+0100)
;;           By: Mohamed Amine Najahi
;;     Update #: 83
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

;;;; --------------------------- to have the journal ---------------------
(require 'org-journal)

;;;; -------------------  multiple cursors stuff  ------------------

;;;; -----------   outline-minor-mode (to hide function definitions) -----
(add-hook 'c-mode-hook   'outline-minor-mode)
(add-hook 'c++-mode-hook 'outline-minor-mode)

;;;; -------------------   autoload eldoc mode for lisp  -----------------
(add-hook 'emacs-lisp-mode-hook       'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook             'turn-on-eldoc-mode)

;;;; ----------  hl line highlighting for buffer mode  ---------
(add-hook 'buffer-menu-mode-hook  'hl-line-mode)
(add-hook 'gnus-summary-mode-hook 'hl-line-mode)
(add-hook 'package-menu-mode-hook 'hl-line-mode)

;; To replace some symbols by prettier ones
(global-prettify-symbols-mode 1)
(defconst lisp--prettify-symbols-alist
  '(("lambda"  . ?λ)))
;
; Configurations for the Emacs Lisp session
(add-hook 'emacs-lisp-mode-hook
  (lambda ()
    (paredit-mode 1)
    (rainbow-delimiters-mode 1)
    ))

;; Configurations for the Common Lisp session
(add-hook 'lisp-mode-hook
  (lambda ()
    (slime-mode t)
    (paredit-mode 1)
    (rainbow-delimiters-mode 1)
    ))


(add-hook 'lisp-interaction-mode-hook
	  (lambda () 
	    (paredit-mode 1)
	    (rainbow-delimiters-mode 1)
	    )) 

(add-hook 'ielm-mode-hook
	  (lambda () 
	    (paredit-mode 1)
	    (rainbow-delimiters-mode 1)
	    ))

;; function to prepare a pair of parenthesis after an evaluation in ielm
(defadvice ielm-eval-input (after ielm-paredit activate)
  "Begin each IELM prompt with a ParEdit parenthesis pair."
  (paredit-open-round))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; autoload_modes.el ends here
