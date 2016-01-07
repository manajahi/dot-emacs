;; run server if necessary and if called from emacsclient
(require 'server)
(unless (server-running-p) (server-start))

(mapcar (lambda (dir) (add-to-list 'load-path dir))
	'("~/.emacs.d/custom_lisp" "~/.emacs.d/sollya-mode" "~/.emacs.d/gappa-mode"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;(load "inf-sollya.el")			     ;;
;; ;;(load "sollya.el")				     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; (load "gappa-mode.el")			    ;;
;; ;; (load "gappa-out.el")			    ;;

;;;; -------------------  autoload gappa mode-----------------------------
;; (add-to-list 'auto-mode-alist '("\\.gappa$" . gappa-mode)) 
;; (autoload 'gappa-mode "gappa-mode.el" "Autoloading Gappa major mode" t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Early load of packages and add melpa
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(setq package-enable-at-startup nil)

;;; Used to time the initialization process
;;(require 'benchmark-init)

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
    company                             ; Auto completion
    company-anaconda                    ; Company integration for Anaconda
    diff-hl                             ; Highlight VCS diffs in the fringe
    easy-kill                           ; Killing and marking on steroids
    elisp-slime-nav                     ; Navigate to symbol definitions
    flycheck                            ; and syntax errors
    flycheck-cask                       ; Cask support for Flycheck
    flycheck-haskell                    ; Improve Haskell syntax checking
    ghci-completion                     ; Complete GHCI commands
    git-commit-mode                     ; Git commit message mode
    git-rebase-mode                     ; Mode for git rebase -i
    git-timemachine                     ; Go back in (Git) time
    gitattributes-mode                  ; Git attributes mode
    gitconfig-mode                      ; Git configuration mode
    gitignore-mode                      ; .gitignore mode
    google-this                         ; Google from Emacs
    guide-key                           ; Show active keys
    haskell-mode                        ; Haskell major modes
    helm                                ; Completion package
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
    solarized-theme                     ; Color theme
    tuareg                              ; OCaml major mode
    use-package                         ; Used to initialize other packages
    visual-regexp                       ; Regexp reloaded
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

;;;;;;;;;;;;;;;;;;;
;; Personal info ;;
;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Mohamed Amine Najahi"
      user-mail-address "mohaminaj@gmail.com")


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
         ("C-x c y" . helm-yas-complete)
         ("C-x c Y" . helm-yas-create-snippet-on-region)
         ("C-x c b" . my/helm-do-grep-book-notes)
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

(use-package header2
  :config
  (defun user-mail-address()
    (interactive)
    (message "amine.najahi@univ-perp.fr")
    )
  (defun user-web-url()
    (interactive)
    (message "http://perso.univ-perp.fr/mohamedamine.najahi")
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


(use-package emms
  :init
  (setq emms-source-file-default-directory "/home/amine/Music/")
  :config
  (require 'emms-setup)
  (emms-devel)

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
  (use-package erc-hl-nicks)
  (setq erc-autojoin-channels-alist
	'((".*\\.freenode.net" "#emacs" "#haskell" "#lisp")))

  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				  "324" "329" "332" "333" "353" "477"))
  ;; don't show any of this
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
  ;; switch to ERC
  (global-set-key (kbd "C-c m") 'erc-start-or-switch)

  :config
  (add-to-list 'erc-modules 'erc-hl-nicks)
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


;;(require 'guide-key)
;;(setq guide-key/guide-key-sequence '("C-x" "C-x r" "C-c" "C-x"))
;;(guide-key-mode 1) ; Enable guide-key-mode


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load global look of emacs
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "look.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load global configurations
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "global_configurations.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; load my functions
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "my_functions.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autoload_modes.el contains modes to autoload 
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "autoload_modes.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bbdb configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "bbdb_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auctex configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(load "auctex_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "orgmode_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-journal configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "journal.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To handle accents in html and tex files
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "accents.el")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings.el contains keybindings
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "keybindings.el")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-save-query nil)
 '(TeX-view-program-selection
   (quote
    ((engine-omega "dvips and gv")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "Evince")
     (output-html "xdg-open"))))
 '(gnuserv-program "/usr/lib/xemacs-21.0/i386-pc-linux/gnuserv")
 '(inhibit-startup-screen t)
 '(virtualenv-root "/home/amine/Documents/tests/django/Firstblog/"))


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


(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; --------------------- Printer options  --------------------------- ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setq lpr-switches '("-w80"))
;; (setq ps-printer-name "copieur_dali")
;; (setq ps-paper-type 'a4)

;;;;;;;;;;;;;;;
;; old-stuff ;;
;;;;;;;;;;;;;;;

;; (defun mohaminaj-uniquify-list (l)
;;   (let ((res ()))
;;     (dolist (el l)
;;       (when (not (memq el res))
;; 	  (push el res)
;; 	  ))
;;     res))

;; (defun mohaminaj-sync-packages (file-path)
;;   (with-temp-buffer
;;     (find-file (concat user-emacs-directory file-path))
;;     (let* ((packs (ignore-errors (read (current-buffer))))
;; 	   (new (mohaminaj-uniquify-list (append packs package-activated-list)))
;; 	   )
;;       (progn
;; 	(dolist (p new)
;; 	  (unless (package-installed-p p)
;; 	    (package-install p)
;; 	    ))
;; 	(erase-buffer)
;; 	(insert (format "%S" (sort new #'(lambda (x y) (string< (symbol-name x) (symbol-name y))))))))
;;     (save-buffer)
;;     (kill-buffer)))

;; (mohaminaj-sync-packages "packs.el")

