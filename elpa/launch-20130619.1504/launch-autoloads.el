;;; launch-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "launch" "launch.el" (21583 64528 583432 649000))
;;; Generated autoloads from launch.el

(let ((loads (get 'launch 'custom-loads))) (if (member '"launch" loads) nil (put 'launch 'custom-loads (cons '"launch" loads))))

(defvar launch-program (cond ((eq system-type 'darwin) (executable-find "open")) ((or (eq system-type 'windows-nt) (eq system-type 'cygwin)) (executable-find "start.exe")) (t (or (executable-find "xdg-open") (executable-find "exo-open") (executable-find "kde-open") (executable-find "gnome-open") (executable-find "run-mailcap") ""))) "\
Program to use as a launcher.

If an empty string, use the built-in mailcap library.")

(custom-autoload 'launch-program "launch" t)

(defvar launch-minimum-confirm 5 "\
Minimum number of files before confirmation.

If the number of files to launch exceeds this minimum, confirm
with the user.")

(custom-autoload 'launch-minimum-confirm "launch" t)

(autoload 'launch-file "launch" "\
Launch FILENAME using its associated program.

Return (process . buffer), where process is the process object of
the associated program, and buffer is the buffer object (or
nil).

\(fn FILENAME)" t nil)

(autoload 'launch-directory "launch" "\
Launch the file manager for DIRNAME-OR-FILENAME.

If DIRNAME-OR-FILENAME is a file, launch its directory.

Return (process . buffer), where process is the process object of
the associated program, and buffer is the buffer object (or
nil).

\(fn DIRNAME-OR-FILENAME)" t nil)

(autoload 'launch-files "launch" "\
Launch each file in FILE-LIST using its associated program.

If CONFIRM is set, ask the user if they meant to open a large
number of files.

\(fn FILE-LIST &optional CONFIRM)" nil nil)

(autoload 'launch-mode "launch" "\
Toggle Launch mode on or off.
With a prefix argument ARG, enable Launch mode if ARG is
positive, and disable it otherwise.  If called from Lisp, enable
the mode if ARG is omitted or nil.

Turning on launch-mode will add keybindings for `launch-file' and
`launch-directory'.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-launch-mode "launch" "\
Unconditionally turn on Launch mode.

\(fn)" nil nil)

(autoload 'turn-off-launch-mode "launch" "\
Unconditionally turn off Launch mode.

\(fn)" nil nil)

(defvar global-launch-mode nil "\
Non-nil if Global-Launch mode is enabled.
See the command `global-launch-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-launch-mode'.")

(custom-autoload 'global-launch-mode "launch" nil)

(autoload 'global-launch-mode "launch" "\
Toggle Launch mode in all buffers.
With prefix ARG, enable Global-Launch mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Launch mode is enabled in all buffers where
`turn-on-launch-mode' would do it.
See `launch-mode' for more information on Launch mode.

\(fn &optional ARG)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; launch-autoloads.el ends here
