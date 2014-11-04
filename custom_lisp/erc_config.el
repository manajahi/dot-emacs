;;; erc_config.el --- 
;; 
;; Filename: erc_config.el
;; Description: 
;; Author: amine najahi amine.najahi@univ-perp.fr
;; Maintainer: amine najahi amine.najahi@univ-perp.fr
;; Created: Sat May 31 02:38:27 2014 (+0200)
;; Version: 
;; Last-Updated: Wed Jul 16 21:32:11 2014 (+0200)
;;           By: amine najahi
;;     Update #: 10
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
(require 'erc)

;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
  '((".*\\.freenode.net" "#emacs" "#haskell" "#lisp")))

;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
				"324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?
      (erc-track-switch-buffer 1) ;; yes: switch to last active
    (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      (erc :server "irc.freenode.net" :port 6667 :nick "manfoo7" :full-name "man"))))

;; to get nicknames coloring
(require 'erc-hl-nicks)
;(add-to-list 'erc-modules 'erc-hl-nicks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; erc_config.el ends here
