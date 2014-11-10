;;; look.el --- 
;; 
;; Filename: look.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun 24 17:45:17 2013 (+0200)
;; Version: 
;; Last-Updated: Wed Nov  5 18:19:01 2014 (+0100)
;;           By: amine najahi
;;     Update #: 61
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

;; Set the graphical theme to a high contrast
(require 'color-theme)
(color-theme-initialize)

(require 'color-theme-solarized)
(load-theme 'solarized-dark t)

;; temporarily solves the problem of the background in solarized
;(custom-set-faces (if (not window-system) '(default ((t (:background nil))))))
;(custom-set-faces '(default ((t (:background nil)))))

;; to load the theme for each new frame
;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions
;; 	      '(lambda (f)
;; 		 (with-selected-frame f
;; 		   (when (window-system f) (color-theme-solarized-dark)))))
;;   (color-theme-solarized-dark))

;; (set-face-attribute 'default nil :font "DejaVu Sans Mono")

;; Turn off the menu bar at startup
(menu-bar-mode -1)

;; Turn off the tool mode at startup
(tool-bar-mode -1) 

;; Turn off the sroll bar at startup
(scroll-bar-mode -1)

;; Small customization of the modeline
;; (set-face-attribute 'mode-line nil
;;    :foreground "white"
;;    :background "blue"
;;    ;; :overline "green"
;;    ;; :underline "white"
;;    )

;; stuff for using emacs in xterm
(defun terminal-init-xterm-256color ()
  "Terminal initialization function for xterm."
  ;; Use the xterm color initialization code.
  (tty-set-up-initial-frame-faces)
;  (tty-run-terminal-initialization (selected-frame) "xterm")
  (define-key function-key-map "\e[1;5A" '[C-up])
  (define-key function-key-map "\e[1;5B" '[C-down])
  (define-key function-key-map "\e[1;5C" '[C-right])
  (define-key function-key-map "\e[1;5D" '[C-left])
  (define-key function-key-map "\e[1;3A" '[M-up])
  (define-key function-key-map "\e[1;3B" '[M-down])
  (define-key function-key-map "\e[1;3C" '[M-right])
  (define-key function-key-map "\e[1;3D" '[M-left])
  (xterm-register-default-colors)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; look.el ends here
