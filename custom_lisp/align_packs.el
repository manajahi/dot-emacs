;;; align_packs.el --- 
;; 
;; Filename: align_packs.el
;; Description: 
;; Author: amine najahi
;; Maintainer: 
;; Created: Fri Oct 17 18:52:21 2014 (+0200)
;; Version: 
;; Package-Requires: ()
;; Last-Updated: Fri Oct 17 20:02:40 2014 (+0200)
;;           By: amine najahi
;;     Update #: 14
;; URL: 
;; Doc URL: 
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
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;; 

(defun custom-set-difference (a b)
  (remove-if
     #'(lambda (x) (and (member x a) (member x b)))
     (append a b)))

(with-temp-buffer
  (find-file ".emacs.d/packs.txt")
  (let* ((packs (read (current-buffer)))
	 (to-inst (custom-set-difference packs package-activated-list)))
    (progn
      (dolist (p to-inst)
	(if (memq p packs)
	    (package-install p)
	  (setq packs (cons p packs))))
      (erase-buffer)
      (insert (format "%S" packs))))
  (kill-buffer))
