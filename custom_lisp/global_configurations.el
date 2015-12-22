;;; global_configurations.el --- 
;; 
;; Filename: global_configurations.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:53:49 2013 (+0200)
;; Version: 
;; Last-Updated: Tue May  5 10:54:28 2015 (+0200)
;;           By: amine najahi
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

;; replace yes-no questions by y-n questions
(fset 'yes-or-no-p 'y-or-n-p)

;; Allows scroll to move to top or bottom when it hits it
(setq scroll-error-top-bottom t)

;; allow to work with compressed etags ctags files
(require 'jka-compr)

;; function to remove completion buffer when done
(add-hook 'minibuffer-exit-hook 
      '(lambda ()
         (let ((buffer "*Completions*"))
           (and (get-buffer buffer)
            (kill-buffer buffer)))))


;; To show the total number of lines in the buffer and  modify the modeline
(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

(setq-default mode-line-format
	      '("%e"
		#("-" 0 1
		  (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
		mode-line-mule-info mode-line-client eshell-command-running-string mode-line-remote mode-line-frame-identification mode-line-buffer-identification
		#("   " 0 3
		  (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
		;;mode-line-position
		#("  " 0 2
		  (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
                (:eval (when line-number-mode
                         (let ((str "Line %l"))
                           (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
                             (setq str (concat str "/" my-mode-line-buffer-line-count)))
                           str)))
                (list 'column-number-mode "  Column %c  %p  ")
		mode-line-modes
		(vc-mode vc-mode)
		(global-mode-string
		 ("" global-mode-string
		  #("--" 0 2
		    (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))))
		#("-%-" 0 3
		  (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))))


(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)


;;;; ---------------- set encoding to utf --------------------------------
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


;; match parenthesis
(show-paren-mode 1)
;; (defadvice show-paren-function
;;   (after show-matching-paren-offscreen activate)
;;   "If the matching paren is offscreen, show the matching line in the
;;         echo area. Has no effect if the character before point is not of
;;         the syntax class ')'."
;;   (interactive)
;;   (if (not (minibuffer-prompt))
;;       (let ((matching-text nil))
;; 	;; Only call `blink-matching-open' if the character before point
;; 	;; is a close parentheses type character. Otherwise, there's not
;; 	;; really any point, and `blink-matching-open' would just echo
;; 	;; "Mismatched parentheses", which gets really annoying.
;; 	(if (char-equal (char-syntax (char-before (point))) ?\))
;; 	    (setq matching-text (blink-matching-open)))
;; 	(if (not (null matching-text))
;; 	    (message matching-text)))))

;; backup files creation is done in a unique directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )

;; Set google chrome as the default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; To tune match paren to show the matched area
(setq show-paren-style 'mixed)


;; Stuff for ace-window mode to jump quickly
(setq avi-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l ?m))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; global_configurations.el ends here
