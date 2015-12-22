;;; shortcuts.el --- 
;; 
;; Filename: shortcuts.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:28:25 2013 (+0200)
;; Version: 
;; Last-Updated: Thu Jun 25 17:16:19 2015 (+0200)
;;           By: Mohamed Amine Najahi
;;     Update #: 38
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

;; to avoid using backspace for carachters
;(global-set-key (kbd "C-h") 'delete-backward-char)
;; to avoid using backspace for words
;(global-set-key (kbd "M-h") 'backward-kill-word)

;; comment-region
(global-unset-key (kbd "C-c c"))
(global-set-key (kbd "C-c c") 'comment-region)

;; uncomment-region
(global-unset-key (kbd "C-c u"))
(global-set-key (kbd "C-c u") 'uncomment-region)

;; replace string
(global-unset-key (kbd "C-c r"))
(global-set-key (kbd "C-c r") 'replace-string)

;; kill to the beginning of line
(global-set-key (kbd "C-c C-;") 'kill-start-of-line)

;; switch between source and corresponding header file
(global-set-key (kbd "C-c h") 'ff-find-other-file)

;; show only function declarations in C-C++ modes
(global-set-key (kbd "C-c o") 'show-all)

;; show everything
(global-set-key (kbd "C-c n") 'hide-other)

;; show only current subtree
(global-set-key (kbd "C-c j") 'show-subtree)

;; To toggle the menubar
(global-set-key [f11] 'tool-bar-mode)

;; To jump to a file pointed to by the current text
(global-set-key (kbd "C-c f") 'find-file-at-point)

;; To jump to a file pointed to by the current text
(global-set-key (kbd "C-c v") 'revert-buffer)

;; To replace M-x when needed
;; (global-set-key (kbd "M-x") (if (commandp 'smex)
;; 				'smex
;; 			      'execute-extended-command))

;; (global-set-key (kbd "C-x C-m") (if (commandp 'smex)
;; 				    'smex
;; 				  'execute-extended-command))

;; (global-set-key (kbd "C-c C-m") (if (commandp 'smex)
;; 				    'smex
;; 				  'execute-extended-command))

;; To search regexp forward and backward
(global-set-key (kbd "M-s") 'isearch-forward-regexp)
(global-set-key (kbd "M-r") 'isearch-backward-regexp)

;; To apply previously recorded macro
(global-set-key [f5] 'call-last-kbd-macro)

;; switch to ERC
(global-set-key (kbd "C-c m") 'erc-start-or-switch)

;; kill buffer of next window and close it
(global-set-key (kbd "C-c k") 'close-and-kill-next-pane)

;; kill buffer of this window and close it
(global-set-key (kbd "C-x C-k") 'close-and-kill-this-pane)

;; This makes the argument to yank the count of the number of times
;; to yank
(global-set-key (kbd "C-y") (lambda (n)
			      (interactive "p")
			      (dotimes (i (abs n)) (yank))))

;; rgrep
(global-set-key (kbd "<f2>") 'rgrep)

;; to search word at point
(define-key isearch-mode-map (kbd "C-d")
  'mohaminaj-isearch-yank-symbol)

;; to use ace-window
(global-set-key (kbd "M-s") #'avi-goto-word-1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; shortcuts.el ends here
