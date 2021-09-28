;;; init.el --- my emacs init file

;;; Commentary:
;; all configurations are in this file

;;; Code:

;; run server if necessary and if called from emacsclient
(require 'server)
(unless (server-running-p) (server-start))

;; (mapc (lambda (dir) (add-to-list 'load-path dir))
;; 	'("~/.emacs.d/custom_lisp"))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Early load of packages and add melpa
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq package-enable-at-startup nil)

;;; Used to time the initialization process
(require 'benchmark-init)
(benchmark-init/activate)

(defconst mohaminaj-packages
  '(
    ace-jump-mode                       ; Fast jump within the buffer
    ace-window                          ; Fast jump to another window
    anaconda-mode                       ; Documentation, lookup and navigation for Python
    anzu                                ; Mode line indicators for isearch
    auctex                              ; The one and only LaTeX environment
    auctex-latexmk                      ; latexmk support for AUCTeX
    benchmark-init                      ; get init benchmarks
    browse-kill-ring                    ; Kill ring browser
    cmake-mode                          ; CMake files
    color-theme
    company                             ; Auto completion
    company-anaconda                    ; Company integration for Anaconda
    diff-hl                             ; Highlight VCS diffs in the fringe
    dumb-jump                           ; Jump to definitions
    easy-kill                           ; Killing and marking on steroids
    elisp-slime-nav                     ; Navigate to symbol definitions
    erc-hl-nicks
    flycheck			        ; and syntax errors
    flycheck-cask                       ; Cask support for Flycheck
    flycheck-haskell                    ; Improve Haskell syntax checking
    ghci-completion                     ; Complete GHCI commands
    git-timemachine                     ; Go back in (Git) time
    gitattributes-mode                  ; Git attributes mode
    gitconfig-mode                      ; Git configuration mode
    gitignore-mode                      ; .gitignore mode
    google-this                         ; Google from Emacs
    guide-key                           ; Show active keys
    haskell-mode                        ; Haskell major modes
    helm                                ; Completion package
    highlight-parentheses
    inf-ruby                            ; Ruby interpreter in Emacs
    macrostep                           ; Interactively expand macros
    magit                               ; Git frontend
    markdown-mode                       ; Markdown major mode
    merlin                              ; OCaml completion engine
    multiple-cursors                    ; Multiple cursors
    paradox                             ; Better package menu
    paredit                             ; Balanced parenthesis editing
    rainbow-delimiters                  ; Color delimiters by level
    rainbow-mode                        ; Show colours as they are
    rtags
    solarized-theme                     ; Color theme
    tuareg                              ; OCaml major mode
    use-package                         ; Used to initialize other packages
    visual-regexp                       ; Regexp reloaded
    xref                                ; Used by dumb-jump to jump to definitons
    xterm-color                         ; Support color parsing from xterm in compile mode
    )
  "Packages needed by my configuration.")

(defun mohaminaj-ensure-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package mohaminaj-packages)
    (unless (package-installed-p package)
      (package-install package))))

(mohaminaj-ensure-packages)

;; (defun custom-set-difference (a b)
;;   (remove-if
;;      #'(lambda (x) (and (member x a) (member x b)))
;;      (append a b)))

;; (with-temp-buffer
;;   (find-file ".emacs.d/packs.txt")
;;   (let* ((packs (read (current-buffer)))
;; 	 (to-inst (custom-set-difference packs package-activated-list)))
;;     (progn
;;       (dolist (p to-inst)
;; 	(if (memq p packs)
;; 	    (package-install p)
;; 	  (setq packs (cons p packs))))
;;       (erase-buffer)
;;       (insert (format "%S" packs))))
;;   (kill-buffer))

;;;;;;;;;;;;;;;;;;;
;; Personal info ;;
;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Amine Najahi"
      user-mail-address "anajahi@nvidia.com")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Early loading of use-package ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-verbose t)
(require 'use-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Initialize helm	       ;;
;; config hijacked from sachac ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (require 'recentf)
    (recentf-mode 1)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
	  helm-mode-fuzzy-match t ; to enable fuzzy search
	  helm-completion-in-region-fuzzy-match t ; to enable fuzzy search
          helm-ff-skip-boring-files t)
    (helm-mode))
  :bind (("C-c h" . helm-mini)
         ("C-h a" . helm-apropos)
         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
	 ("C-x C-m" . helm-M-x)
         ("C-x c o" . helm-occur)
         ("C-x c s" . helm-swoop)
	 ("C-x C-f" . helm-find-files)
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
	 ("C-x C-r" . helm-recentf)
         ("C-x c SPC" . helm-all-mark-rings)))

;; anzu - number of search matches in modeline
(use-package anzu
  :diminish anzu-mode
  :config
  (global-anzu-mode))

(use-package ace-jump-mode
  :commands ace-jump-mode
  :init
  (progn
    (setq avi-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l ?m))
    (autoload 'ace-jump-mode "ace-jump-mode" nil t)
    (global-set-key (kbd "M-s") 'ace-jump-mode)
    )
  ;; :bind
  ;; ("M-s" . ace-jump-mode)
  )

(use-package dumb-jump
  :init
  (progn
    (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
    ;; (setq xref-show-definitions-function #'xref-show-definitions-completing-read)
    )
  )

;; Compile mode to support parsing escape characters intended for xterm
(use-package xterm-color
  :config
  (setq compilation-environment '("TERM=xterm-256color"))
  (defun my/advice-compilation-filter (f proc string)
    (funcall f proc (xterm-color-filter string)))
  (advice-add 'compilation-filter :around #'my/advice-compilation-filter)
  )

;; Stuff for ace-window mode to jump quickly
(use-package ace-window
  :config
  (setq aw-keys '(?q ?s ?d ?f ?g ?h ?j ?k ?l ?m))
  :bind
  ("M-p" . ace-window)
  )

;; The global function was deprecated
;(global-rainbow-delimiters-mode)
(use-package rainbow-delimiters
  :init
  (dolist (hook '(text-mode-hook prog-mode-hook))
    (add-hook hook #'rainbow-delimiters-mode))  
  )

(use-package highlight-parentheses
  :init
    ;; The following is for the show-paren package
  (show-paren-mode 1)
  (setq show-paren-style 'expression) 
  (global-highlight-parentheses-mode)
  )

(use-package header2
  :config
  (defun user-mail-address()
    (interactive)
    (message "anajahi@nvidia.com")
    )
  (defun user-web-url()
    (interactive)
    (message "https://manajahi.com")
    )

  (add-hook 'write-file-hooks 'auto-update-file-header)
  (add-hook 'emacs-lisp-mode-hook 'auto-make-header)
  (add-hook 'c-mode-common-hook   'auto-make-header)
  (add-hook 'LaTeX-mode-hook   'auto-make-header)
  (add-hook 'python-mode-hook   'auto-make-header)
  (global-set-key (kbd "C-x C-h") 'make-header)
  (global-set-key (kbd "C-x C-u") 'update-file-header)
  )

(use-package multiple-cursors
  :init ;; change to bind in the future ?
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C-c <C-down>") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c <C-up>") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-s") 'mc/mark-all-like-this)
  )


(use-package slime
  :init
  (setq inferior-lisp-program "sbcl")
  :config
  (slime-setup '(slime-fancy))
  (add-hook 'slime-repl-mode-hook
	    (lambda ()
	      (paredit-mode 1)
	      (rainbow-delimiters-mode 1)
	      ))
  )

(use-package flycheck
  :init
  (add-hook 'after-init-hook #'global-flycheck-mode)
  )

(use-package auto-complete
  :init
  (progn (global-auto-complete-mode t)
	 (setq ac-auto-start t)
	 (ac-flyspell-workaround)

;;;; -------------------  flyspell --------------------------------------
	 (add-hook 'text-mode-hook 'turn-on-flyspell)

;;;; ------  To switch between the english and french language  -------
	 (global-set-key (kbd "<f8>")   'fd-switch-dictionary))
  )


(use-package dired
  :init
  (add-hook 'dired-mode-hook        'hl-line-mode)
  (add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)
  (progn
    (put 'dired-find-alternate-file 'disabled nil)
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
  )

(use-package eshell
  :init
  (progn (setq eshell-aliases-file "~/.emacs.d/eshell/alias")

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
	 )
  )

(use-package erc

  :init
  (setq erc-autojoin-channels-alist
	'((".*\\.freenode.net" "#emacs" "#haskell" "#lisp")))

  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				  "324" "329" "332" "333" "353" "477"))
  ;; don't show any of this
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
  ;; switch to ERC
  (global-set-key (kbd "C-c m") 'erc-start-or-switch)

  :config
  ; (add-to-list 'erc-modules 'erc-hl-nicks)
  (use-package erc-hl-nicks)
  (erc-hl-nicks-mode)
  (erc-autojoin-mode t)
  ;; check channels
  (erc-track-mode t)
  (defun erc-start-or-switch ()
    "Connect to ERC, or switch to last active buffer"
    (interactive)
    (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
	(erc-track-switch-buffer 1) ;; yes: switch to last active
      (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
	(erc :server "irc.freenode.net" :port 6667 :nick "manfoo7" :full-name "man"))))
  )

(use-package magit
  :commands magit-status
  :init
  (progn
    (global-set-key (kbd "C-x g") 'magit-status)
    )
  )

(use-package auctex
  :mode ("\\.tex\\'" . latex-mode)
  :init
  ;;Make pdf the default output for auctex
  (setq TeX-PDF-mode t)

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

  :config
  (TeX-global-PDF-mode t)
  ;; avoid indenting tikzpictures
  (add-to-list 'LaTeX-indent-environment-list '("tikzpicture"))
  
  :bind
    ;; print a todo in tex
  ("C-c t" . print_todo)
  )

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global look of emacs
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set the graphical theme to a high contrast solarize ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package color-theme
  :init
  (color-theme-initialize)
  ;; Turn off the menu bar at startup
  (menu-bar-mode -1)

  ;; Turn off the tool mode at startup
  (tool-bar-mode -1)
  
  ;; replace yes-no questions by y-n questions
  (fset 'yes-or-no-p 'y-or-n-p)

  ;; Allows scroll to move to top or bottom when it hits it
  (setq scroll-error-top-bottom t)

  ;; disable dialogs
  (setq use-dialog-box nil)

  ;; Turn off the sroll bar at startup
  (scroll-bar-mode -1)
  (use-package color-theme-solarized
    :init
    (load-theme 'solarized-dark t)
    ;; the following temporarily solves the problem of the background in solarized
    (custom-set-faces (if (not window-system) '(default ((t (:background "nil"))))))
    )
  :config
  )

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

;; to load the theme for each new frame
;; (if (daemonp)
;;     (add-hook 'after-make-frame-functions
;; 	      '(lambda (f)
;; 		 (with-selected-frame f
;; 		   (when (window-system f) (color-theme-solarized-dark)))))
;;   (color-theme-solarized-dark))



;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; global configurations
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;;; ---------------- set encoding to utf --------------------------------
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; --------------- to print the current function in the modeline ------- ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(which-function-mode)
;; -- put the function name in a header line
(setq-default header-line-format
              '((which-func-mode ("" which-func-format " "))))
;; We remove Which Function Mode from the mode line, because it's mostly invisible here anyway.
(setq mode-line-misc-info
      (assq-delete-all 'which-func-mode mode-line-misc-info))
;; better to print n/a when the function is unknown
(setq which-func-unknown "n/a")


;;;; --------------- 
(yas-global-mode 1)


;;;; --------------- To change the frame's name -------
(setq frame-title-format '(buffer-file-name "%f" ("%b")))
;;;; --------------- To use nvidia-style C indent -------
(setq-default c-basic-offset 8 tab-width 8
              indent-tabs-mode t)

;;;; --------------- To run commands such as find on Win64 -------
(if (eq system-type 'windows-nt)
    (and (setq exec-path  (cons "c:/Program Files/Git/usr/bin" exec-path))
	 (setenv "PATH" (concat "c:/Program Files/Git/usr/bin;" (getenv "PATH"))))
  )

;;; ------- To have the correct behavior from the DEL key
(normal-erase-is-backspace-mode 1)





;;;; -------------------  Some functions -------------------------------
(defun date ()
  (interactive)
  (insert (shell-command-to-string "date"))
  (backward-char 1)
  (insert "\\\\")
  )

;; function to print ifndefs for conditional compilation
(defun header_cond ()
  "Inserts conditional compilation directives necessary for C and C++ programming"
  (interactive)
  (save-excursion
    (let* ((name (upcase-initials (buffer-name)))
           (case-fold-search nil)
           (name (substring (replace-regexp-in-string "\\([A-Z]\\)" "_\\1" name) 1 nil))
           (name (replace-regexp-in-string "\\." "" name))
           (name (upcase name))
           (upper (concat "#ifndef "
                          "__"
                          name
                          "__\n"
                          "#define "
                          "__"
                          name
                          "__\n"))
           (lower (concat "\n#endif //"
                          "__"
                          name
                          "__")))
      ;; (goto-char (return-to))                                                                                                                                      
      (insert upper)
      (goto-char (point-max))
      (insert lower)
      )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function to wrap text verbatim for an output stream in c++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun aux (stream str)
  (insert (concat stream " << \"" str "\" << endl;"))
  (insert "\n")
  )

(defun verbatim (start end stream)
  (interactive "r\nsStream's name: ")
  (setq str (buffer-substring start end))
  (let ((lin (split-string str "\n")))
    (let (value)
      (dolist (elt lin value)
	(aux stream elt))   
      )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Kill to the beginning of the line
(defun kill-start-of-line ()
  "kill from point to start of line"
  (interactive)
  (kill-line 0)
  )

;; Kill and close other window
(defun close-and-kill-next-pane ()
  "If there are multiple windows, then close the other pane and kill the buffer in it also."
  (interactive)
  (other-window 1)
  (kill-this-buffer)
  (if (not (one-window-p))
      (delete-window)))

(defun close-and-kill-this-pane ()
  "If there are multiple windows, then close the other pane and kill the buffer in it also."
  (interactive)
  (kill-this-buffer)
  (other-window 1)
  (if (not (one-window-p))
      (delete-window)))

;; To better handle gpg-agent either from terminal or from X
(defadvice epg--start (around advice-epg-disable-agent disable)
  "Don't allow epg--start to use gpg-agent in plain text terminals."
  (if (display-graphic-p)
      ad-do-it
    (let ((agent (getenv "GPG_AGENT_INFO")))
      (setenv "GPG_AGENT_INFO" nil) ; give us a usable text password prompt
      ad-do-it
      (setenv "GPG_AGENT_INFO" agent))))

(ad-enable-advice 'epg--start 'around 'advice-epg-disable-agent)
(ad-activate 'epg--start)

;; Checks for strings [n] and increments n
(defun my_inc ()
  (interactive)
  (query-replace-regexp-eval "\\[\\([[:digit:]]+\\)\\]"
			     (quote (concat "[" (number-to-string (+ 1 (string-to-number (match-string 1)))) "]")) nil
			     (if (and transient-mark-mode mark-active) (region-beginning)) (if (and transient-mark-mode mark-active) (region-end)))
  )

;; Increments an integer at point (can take an optional
;; argument which is the number to add)
(defun my_increment_number_decimal  (&optional arg)
  "Increment the number forward from point by 'arg'."
  (interactive "p*")
  (save-excursion
    (save-match-data
      (let (inc-by field-width answer)
        (setq inc-by (if arg arg 1))
        (skip-chars-backward "0123456789")
        (when (re-search-forward "[0-9]+" nil t)
          (setq field-width (- (match-end 0) (match-beginning 0)))
          (setq answer (+ (string-to-number (match-string 0) 10) inc-by))
          (when (< answer 0)
            (setq answer (+ (expt 10 field-width) answer)))
          (replace-match (format (concat "%0" (int-to-string field-width) "d")
                                 answer)))))))

(defun mohaminaj-isearch-yank-symbol ()
    "Yank the symbol at point into the isearch minibuffer."
    (interactive)
    (isearch-yank-string
     (save-excursion
       (when (and (not isearch-forward)
		  isearch-other-end)
	 (goto-char isearch-other-end))
            (thing-at-point 'symbol))))

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
    	 (change (if (string= dic "english") "francais" "english")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)
    ))

;; To quickly jump to my init file
(defun find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") 'find-user-init-file)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package org
  :init
  :config
  (require 'org-journal)
  (require 'org-install)
  (require 'org-agenda)
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (setq org-element-use-cache nil)

  (setq org-directory "~/Dropbox/org")
  (setq org-mobile-directory "~/Dropbox/Applications/MobileOrg")
  (setq org-mobile-inbox-for-pull "~/Dropbox/org/univ.org")

  (setq org-agenda-files (list "~/Dropbox/org/admin.org"
			       "~/Dropbox/org/misc.org"
			       "~/Dropbox/org/univ.org"))

  ;; (setq org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE" "CANCELED")))
  (setq org-todo-keywords '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
  ;; number of days shown in the agenda
  (setq org-agenda-span 30)

  ;; number of days to warn abount deadlines
  (setq ord-deadline-warning-days 4)

  ;; to jump to links destinations with a simple return
  (setq org-return-follows-link 1)
(defvar org-journal-file "~/Documents/journal/journal.org"  
  "Path to OrgMode journal file.")  

(defvar org-journal-date-format "%d-%m-%Y"  
  "Date format string for journal headings.")

(setq org-journal-file-format "%d-%m-%Y")

;; (defun org-journal-entry ()  
;;   "Create a new diary entry for today or append to an existing one."  
;;   (interactive)  
;;   (switch-to-buffer (find-file org-journal-file))  
;;   (widen)  
;;   (let ((today (format-time-string org-journal-date-format)))  
;;     (beginning-of-buffer)  
;;     (unless (org-goto-local-search-forward-headings today nil t)  
;;       ((lambda ()   
;; 	 (org-insert-heading)  
;; 	 (insert today)  
;; 	 (insert "\n\n  \n"))))  
;;     (beginning-of-buffer)  
;;     (org-show-entry)  
;;     (org-narrow-to-subtree)  
;;     (end-of-buffer)  
;;     (backward-char 2)  
;;     (unless (= (current-column) 2)  
;;       (insert "\n\n  "))))

  )

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

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;; function to prepare a pair of parenthesis after an evaluation in ielm
(defadvice ielm-eval-input (after ielm-paredit activate)
  "Begin each IELM prompt with a ParEdit parenthesis pair."
  (paredit-open-round))


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To handle accents in html and tex files
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (load "accents.el")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;; To search regexp forward and backward
;; (global-set-key (kbd "M-s") 'isearch-forward-regexp)
;; (global-set-key (kbd "M-r") 'isearch-backward-regexp)

;; To apply previously recorded macro
(global-set-key [f5] 'call-last-kbd-macro)

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

(global-set-key (kbd "C-c y") 'yas-expand)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; custom
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-save-query nil)
 '(TeX-view-program-selection
   '((engine-omega "dvips and gv")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Evince")
     (output-html "xdg-open")))
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   '("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))
 '(fci-rule-color "#073642")
 '(gnuserv-program "/usr/lib/xemacs-21.0/i386-pc-linux/gnuserv")
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100)))
 '(hl-bg-colors
   '("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4"))
 '(org-agenda-files nil)
 '(package-selected-packages
   '(xterm-color xref dumb-jump org-babel-eval-in-repl gnuplot yaml-mode wgrep-ag w3m visual-regexp use-package tuareg solarized-theme smex shm rtags robe rainbow-mode rainbow-delimiters racket-mode puppet-mode poker pip-requirements pcre2el paredit paradox org-journal org multiple-cursors molokai-theme matlab-mode markdown-mode magit lua-mode launch json-rpc imenu-anywhere highlight-symbol highlight-parentheses highlight-numbers helm-cider helm header2 hardhat guide-key graphviz-dot-mode google-translate google-this gnuplot-mode gitignore-mode gitconfig-mode gitattributes-mode git-timemachine ghci-completion geiser flycheck-ocaml flycheck-haskell flycheck-cask erc-hl-nicks emms elpy elisp-slime-nav eide easy-kill dired+ diff-hl debbugs cuda-mode company-anaconda color-theme-solarized cmake-mode chess browse-kill-ring benchmark-init bbdb auto-complete-c-headers auto-complete-auctex auctex-latexmk anzu ansible-doc ag ace-window ace-jump-mode ac-slime ac-cider))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2")))
 '(vc-annotate-very-old-color nil)
 '(virtualenv-root "/home/amine/Documents/tests/django/Firstblog/")
 '(weechat-color-list
   '(unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-sectioning-5-face ((((type tty pc) (class color) (background light)) (:foreground "cyan" :weight bold))))
 '(font-lock-function-name-face ((t (:foreground "color-21"))))
 '(gnus-cite-1 ((((class color) (background light)) (:foreground "cyan"))))
 '(hl-line ((t (:inherit highlight :background "#ffffff"))))
 '(message-header-subject ((((class color) (background light)) (:foreground "cyan" :weight bold))))
 '(message-header-to ((((class color) (background light)) (:foreground "cyan" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "cyan"))))
 '(org-document-title ((t (:foreground "cyan" :weight bold))))
 '(show-paren-match ((((class color) (background light)) (:background "red"))))
 '(which-func ((t (:foreground "magenta" :underline nil)))))

(provide 'init)
;;; init.el ends here
