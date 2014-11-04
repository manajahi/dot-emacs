;;; autoload_modes.el --- 
;; 
;; Filename: autoload_modes.el
;; Description: 
;; Author: Amine Najahi amine.najahi@univ-perp.fr
;; Maintainer: Amine Najahi amine.najahi@univ-perp.fr
;; Created: Mon Jun  3 17:26:26 2013 (+0200)
;; Version: 
;; Last-Updated: Mon Oct 27 12:48:52 2014 (+0100)
;;           By: amine najahi
;;     Update #: 69
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

;;;; -------------------  toggle minibuffer completion  ------------------
;(icomplete-mode 1)

;;;; -------------------  ido mode for completion       ------------------
(ido-mode 1)

;;;; --------------- to initialize smex (goes with ido)  -----------------
(smex-initialize)

;; Is ido-ubiquitous a replacement for smex ??
(require 'ido-ubiquitous)
(ido-everywhere)
(ido-ubiquitous-mode)

;;;; --------------- to color parenthesis with appropriate depth ---------
(global-rainbow-delimiters-mode)

;;;; --------------- to print the current function in the modeline -------
(which-function-mode)

;;;; --------------- to print the current function in the modeline -------
(yas-global-mode 1)

;;;; --------------------------- to have the journal ---------------------
(require 'org-journal)

;; -- put the function name in a header line
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
(setq mode-line-misc-info
            ;; We remove Which Function Mode from the mode line, because it's mostly
            ;; invisible here anyway.
            (assq-delete-all 'which-func-mode mode-line-misc-info))
;; better to print n/a when the function is unknown
(setq which-func-unknown "n/a")

;;;; -------------------  header filling  ------------------
(require 'header2)

;;;; -------------------  multiple cursors stuff  ------------------
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-c <C-down>") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c <C-up>") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-s") 'mc/mark-all-like-this)

;;;; -------------------  autoload gappa mode-----------------------------
(add-to-list 'auto-mode-alist '("\\.gappa$" . gappa-mode)) 
(autoload 'gappa-mode "gappa-mode.el" "Autoloading Gappa major mode" t)

;;;; -----------   outline-minor-mode (to hide function definitions) -----
(add-hook 'c-mode-hook 'outline-minor-mode)
(add-hook 'c++-mode-hook 'outline-minor-mode)

;;;; -------------------   autoload eldoc mode for lisp  -----------------
(add-hook 'emacs-lisp-mode-hook       'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook             'turn-on-eldoc-mode)

;;;; ----------  hl line highlighting for dired and buffer mode  ---------
(add-hook 'dired-mode-hook 'hl-line-mode)
(add-hook 'buffer-menu-mode-hook 'hl-line-mode)
(add-hook 'gnus-summary-mode-hook 'hl-line-mode)
(add-hook 'package-menu-mode-hook 'hl-line-mode)

;;;; ----------  Stuff to run at emacs startup   ---------
;; (add-hook 'emacs-startup-hook
;;   (lambda ()
;;     (slime)
;;     (ielm)
;;   ))

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
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (paredit-mode 1)
	    (rainbow-delimiters-mode 1)
	    ))

;; function to prepare a pair of parenthesis after an evaluation in ielm
(defadvice ielm-eval-input (after ielm-paredit activate)
  "Begin each IELM prompt with a ParEdit parenthesis pair."
  (paredit-open-round))

;;;; ----------  Changes gnus init file location inside .emacs.d  ---------
(setq gnus-init-file "~/.emacs.d/.gnus")
(setq gnus-startup-file "~/.emacs.d/.newrc")

;;;; ---------- slime has a fancy prompt and uses sbcl by default  ---------
(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy))

;;;; -------------------  enable emms and its players            ---------
(require 'emms-setup)
(emms-devel)

(setq emms-source-file-default-directory "/home/amine/Music/")

(define-emms-simple-player mplayer-mp3 '(file url)
  "\\.[mM][pP][23]$" "mplayer")

(define-emms-simple-player mplayer-ogg '(file)
  (regexp-opt '(".ogg" ".OGG" ".FLAC" ".flac" )) "mplayer")

(define-emms-simple-player mplayer-playlist '(streamlist)
  "http://" "mplayer" "-playlist")

(define-emms-simple-player mplayer-list '(file url)
  (regexp-opt '(".m3u" ".pls")) "mplayer" "-playlist")

(define-emms-simple-player mplayer-video '(file url)
  (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv"
                ".wma" ".mov" ".avi" ".divx" ".ogm" ".asf"
                ".mkv" "http://")) "mplayer")

(setq emms-player-list '(emms-player-mplayer-mp3
                         emms-player-mplayer-ogg
                         emms-player-mplayer-playlist
                         emms-player-mplayer-video
                         emms-player-mplayer-list
                         ))

(setq emms-playlist-buffer-name "*EMMS*")

(setq emms-info-asynchronously t)

(setq emms-stream-default-action "play")

(defun emms-add-universe-synchronously ()
  (interactive)
  (let ((emms-info-asynchronously nil))
    (emms-add-directory-tree emms-source-file-default-directory)
     (message "Thud!")))

;debug players
(emms-player-for '(*track* (type . file)
                          (name . "myfile.pls")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; autoload_modes.el ends here
