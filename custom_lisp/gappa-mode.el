;;; gappa-mode.el --- 
;; 
;; Filename: gappa-mode.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Aug 20 12:54:25 2012 (+0200)
;; Version: 0.1.0
;; Last-Updated: Mon Aug 20 15:18:23 2012 (+0200)
;;           By: Amine Najahi
;;     Update #: 88
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


;; classes of keywords
(defvar gappa-keywords
  '("dn")
  "gappa keywords.")

(defvar gappa-events
  '("in")
  "gappa events.")


;; generate the regex string for each class of keywords
(defvar gappa-keywords-regexp (regexp-opt gappa-keywords 'words))
(defvar gappa-type-regexp (concat "fixed<[-]?[0-9]+,[a-z]+>") "*Regular expression to find fixed<...>")
(defvar gappa-event-regexp (regexp-opt gappa-events 'words))
(defconst gappa-functions-regexp (concat "->\\|[?]\\|/\\\\") "*Regular expression to find enclosures")
(defvar gappa-comments-regexp (concat "#.*") "*Regular expression to find gappa comments")
(defvar gappa-constant-regexp (concat "0[xX][0-9a-fA-F]+p-[0-9]+\\|[-]?[0-9]+b[-]?[0-9]+") "*Regular expression to find hexa constants")
(defvar gappa-variable-regexp (concat ">\\|<\\|<=\\|>=") "*Regular expression to find hexa constants")
(defvar gappa-preprocessor-regexp (concat "*\\|=\\|;") "*Regular expression to find hexa constants")


;; clear memory
(setq gappa-keywords nil)
(setq gappa-events nil)


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
