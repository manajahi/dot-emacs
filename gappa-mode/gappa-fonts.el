
;; classes of keywords
(defvar gappa-keywords
  '("dn")
  "gappa keywords.")

(defvar gappa-events
  '("in")
  "gappa events.")

(defvar gappa-warning-regexp "Warning: .*"
  "*Regular expression to find Warnings")

(defvar gappa-results-regexp "Results")
(defvar gappa-key-regexp "in")

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
;; (setq gappa-keywords nil)
;; (setq gappa-events nil)

(provide 'gappa-fonts)
