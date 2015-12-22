;;; hardhat-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "hardhat" "hardhat.el" (21583 64528 35432 655000))
;;; Generated autoloads from hardhat.el

(autoload 'hardhat-customize-set-regexp "hardhat" "\
Set function which clears the computed regexp cache.

SYMBOL and VALUE are passed to `custom-set-default'.

\(fn SYMBOL VALUE)" nil nil)

(let ((loads (get 'hardhat 'custom-loads))) (if (member '"hardhat" loads) nil (put 'hardhat 'custom-loads (cons '"hardhat" loads))))

(let ((loads (get 'hardhat-protect 'custom-loads))) (if (member '"hardhat" loads) nil (put 'hardhat-protect 'custom-loads (cons '"hardhat" loads))))

(let ((loads (get 'hardhat-editable 'custom-loads))) (if (member '"hardhat" loads) nil (put 'hardhat-editable 'custom-loads (cons '"hardhat" loads))))

(put 'hardhat-protect 'safe-local-variable 'booleanp)

(autoload 'hardhat-mode "hardhat" "\
Turn on `hardhat-mode'.

When called interactively with no prefix argument this command
toggles the mode.  With a prefix argument, it enables the mode
if the argument is positive and otherwise disables the mode.

When called from Lisp, this command enables the mode if the
argument is omitted or nil, and toggles the mode if the argument
is 'toggle.

\(fn &optional ARG)" t nil)

(autoload 'global-hardhat-mode "hardhat" "\
Toggle Hardhat mode in all buffers.
With prefix ARG, enable Global-Hardhat mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

\(fn &optional ARG)" t nil)

(autoload 'hardhat-status "hardhat" "\
Echo the `hardhat-mode' status of the current buffer.

\(fn)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; hardhat-autoloads.el ends here
