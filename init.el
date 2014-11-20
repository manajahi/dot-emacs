;; run server if necessary and if called from emacsclient
(require 'server)
(unless (server-running-p) (server-start))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add .emacs.d to path
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/custom_lisp")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Early load of packages and add melpa
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(defconst mohaminaj-packages
  '(
    ;; Color theme
    solarized-theme
    ;; UI improvements
    anzu                                ; Mode line indicators for isearch
    browse-kill-ring                    ; Kill ring browser
    smex                                ; Improved M-x
    ;; File handling
    hardhat                             ; Protect user-writable files
    launch                              ; Open files externally
    ;; Navigation tools
    ido-ubiquitous                      ; Use IDO everywhere
    imenu-anywhere                      ; imenu with IDO and for all buffers
    ido-vertical-mode                   ; Show IDO vertically
    ;ace-jump-mode                       ; Fast jump within the buffer
    ;; Editing indicators
    ;page-break-lines                    ; page breaks
    ;volatile-highlights                 ; certain editing operations,
    flycheck                            ; and syntax errors
    ;; Editing helpers
    ;whitespace-cleanup-mode             ; Cleanup whitespace on save
    ;undo-tree                           ; Undo reloaded
    ;adaptive-wrap                       ; Automatic wrap prefix
    ;expand-region                       ; Expand region by semantic units
    multiple-cursors                    ; Multiple cursors
    easy-kill                           ; Killing and marking on steroids
    ;; Search and replace
    ag                                  ; Code search
    wgrep wgrep-ag                      ; Edit ag results in-place
    visual-regexp                       ; Regexp reloaded
    ;; Completion and expansion
    company                             ; Auto completion
    ;; LaTeX/AUCTeX
    auctex                              ; The one and only LaTeX environment
    auctex-latexmk                      ; latexmk support for AUCTeX
    ;; Markup languages
    markdown-mode                       ; Markdown major mode
    graphviz-dot-mode                   ; Graphviz mode
    ;; Configuration languages
    puppet-mode                         ; For Puppet files
    ;; YAML
    yaml-mode                           ; YAML major mode
    ansible-doc                         ; Ansible documentation lookup
    ;; General programming utilities
    highlight-symbol                    ; Symbol awareness
    pcre2el                             ; Regular expression utilities
    highlight-numbers                   ; Syntax highlighting for numeric
					; literals
    rainbow-delimiters                  ; Color delimiters by level
    rainbow-mode                        ; Show colours as they are
    ;; Programming languages
    ;js2-mode                            ; Powerful Javascript mode
    ;feature-mode                        ; Cucumber major mode
    cmake-mode                          ; CMake files
    ;; Python
    anaconda-mode                       ; Documentation, lookup and navigation
    company-anaconda                    ; Company integration for Anaconda
    pip-requirements                    ; requirements.txt files
    ;; Ruby support
    inf-ruby                            ; Ruby interpreter in Emacs
    robe                                ; Code navigation, docs and completion
    ;; Rust
    ;rust-mode
    ;toml-mode                           ; For Cargo.toml
    ;flycheck-rust                       ; Better Rust support for Flycheck
    ;; Haskell support
    haskell-mode                        ; Haskell major modes
    ghci-completion                     ; Complete GHCI commands
    flycheck-haskell                    ; Improve Haskell syntax checking
    shm                                 ; Structured Haskell editing
    ;; OCaml support
    tuareg                              ; OCaml major mode
    merlin                              ; OCaml completion engine
    ;; Lisp tools
    paredit                            ; Balanced parenthesis editing
    ;; Emacs Lisp utility modes and libraries
    elisp-slime-nav                     ; Navigate to symbol definitions
    macrostep                           ; Interactively expand macros
    flycheck-cask                       ; Cask support for Flycheck
    ;; Clojure
    ;cider                               ; Clojure IDE
    ;clojure-mode-extra-font-locking
    ;; General Version Control
    diff-hl                             ; Highlight VCS diffs in the fringe
    ;; Git and Gist integration
    magit                               ; Git frontend
    git-commit-mode                     ; Git commit message mode
    gitconfig-mode                      ; Git configuration mode
    gitignore-mode                      ; .gitignore mode
    gitattributes-mode                  ; Git attributes mode
    git-rebase-mode                     ; Mode for git rebase -i
    git-timemachine                     ; Go back in (Git) time
    ;; Utilities
    google-this                         ; Google from Emacs
    paradox                             ; Better package menu
    )
  "Packages needed by my configuration. Hijacked from lunaryon.")

(defun mohaminaj-ensure-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package mohaminaj-packages)
    (unless (package-installed-p package)
      (package-install package))))

(mohaminaj-ensure-packages)

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
;; header configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "header_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bbdb configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "bbdb_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ERC configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "erc_config.el")


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auctex configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "auctex_config.el")


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
;; eshell configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "eshell_config.el")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ac and spelling configuration
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "ac_spelling_config.el")


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
;;;; --------------------- Printer options  ---------------------------
;;(setq lpr-switches '("-w80"))
(setq ps-printer-name "copieur_dali")
(setq ps-paper-type 'a4)

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
