;;; gappa-mode.el --- 
;; 
;; Filename: gappa-mode.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Aug 20 12:54:25 2012 (+0200)
;; Version: 0.1.0
;; Last-Updated: Thu Jul  9 18:07:26 2015 (+0200)
;;           By: Mohamed Amine Najahi
;;     Update #: 98
;; URL: http://perso.univ-perp.fr/mohamedamine.najahi
;; Keywords: Gappa emacs mode
;; Compatibility: 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Commentary: 
;; Gappa mode for emacs
;; 
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Change Log:
;; version 0.1.0
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;;; Code:
(require 'gappa-fonts)
(provide 'gappa-out)

(defvar gappa-out-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-c\C-i" 'call-gappa-on-current)
    map)
  "Keymap used in `gappa-mode' buffers.")

;; create the list for font-lock.
;; each class of keyword is given a particular face
(setq gappa-font-lock-keywords
  `(
    (,gappa-comments-regexp . font-lock-comment-face)
    (,gappa-type-regexp . font-lock-type-face)
    (,gappa-constant-regexp . font-lock-constant-face)
    (,gappa-event-regexp . font-lock-builtin-face)
    (,gappa-keywords-regexp . font-lock-keyword-face)
    (,gappa-functions-regexp . font-lock-function-name-face)   
    (,gappa-variable-regexp . font-lock-variable-name-face)
    (,gappa-preprocessor-regexp . font-lock-preprocessor-face)
))

;; define the mode
(define-derived-mode gappa-mode fundamental-mode
  "gappa mode"
  "Major mode for editing gappa scripts…"

  ;; code for syntax highlighting
  (setq font-lock-defaults '((gappa-font-lock-keywords)))

  ;; clear memory
  (setq gappa-keywords-regexp nil)
  (setq gappa-types-regexp nil)
  (setq gappa-constants-regexp nil)
  (setq gappa-events-regexp nil)
  (setq gappa-functions-regexp nil)
)

;; define the gappa-mode
(provide 'gappa-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; gappa-mode.el ends here
