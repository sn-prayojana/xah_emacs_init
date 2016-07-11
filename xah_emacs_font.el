;; -*- coding: utf-8 -*-
;; some font related emacs commands

;; 2011-03-08
;;   Xah Lee
;; ∑ http://xahlee.org/



(defun xah-cycle-font-2 (_n)
  "Change font in current window between 2 fonts.
URL `http://ergoemacs.org/emacs/emacs_switching_fonts.html'
Version 2015-09-21"
  (interactive "p")
  ;; this function sets a property “state”. It is a integer. Possible values are 0 to length of -fontList
  (let (
        (-fontList '("DejaVu Sans Mono-10" "DejaVu Sans-10"))
        -fontToUse
        -stateBefore
        -stateAfter)

    (setq -stateBefore (if (get 'xah-cycle-font-2 'state) (get 'xah-cycle-font-2 'state) 0))
    (setq -stateAfter (% (+ -stateBefore (length -fontList) _n) (length -fontList)))
    (put 'xah-cycle-font-2 'state -stateAfter)

    (setq -fontToUse (nth -stateAfter -fontList))
    (set-frame-parameter nil 'font -fontToUse)
    (message "Font set to: %s" -fontToUse)))



(defcustom xah-font-list nil "A list of fonts for `xah-cycle-font' to cycle from." :group 'font)
(set-default 'xah-font-list
             (cond
              ((string-equal system-type "windows-nt") ; Windows
               '(
                 "Courier New-10"
                 "DejaVu Sans Mono-9"
                 "Lucida Console-10"
                 "Segoe UI Symbol-12"
                 "DejaVu Sans-10"
                 "Lucida Sans Unicode-10"
                 ))
              ((string-equal system-type "gnu/linux")
               '(
                 "DejaVu Sans Mono-9"
                 "DejaVu Sans-9"
                 "Symbola-13"
                 ))
              ((string-equal system-type "darwin") ; Mac
               '(
                 "DejaVu Sans Mono-9"
                 "DejaVu Sans-9"
                 "Symbola-13"
                 ))))

(defun xah-cycle-font (_n)
  "Change font in current frame.
Each time this is called, font cycles thru a predefined list of fonts in the variable `xah-font-list' .
If _n is 1, cycle forward.
If _n is -1, cycle backward.
See also `xah-cycle-font-next', `xah-cycle-font-previous'.
URL `http://ergoemacs.org/emacs/emacs_switching_fonts.html'
Version 2015-09-21"
  (interactive "p")
  ;; this function sets a property “state”. It is a integer. Possible values are any index to the fontList.
  (let (-fontToUse -stateBefore -stateAfter )
    (setq -stateBefore (if (get 'xah-cycle-font 'state) (get 'xah-cycle-font 'state) 0))
    (setq -stateAfter (% (+ -stateBefore (length xah-font-list) _n) (length xah-font-list)))
    (setq -fontToUse (nth -stateAfter xah-font-list))
    (set-frame-font -fontToUse t)
    ;; (set-frame-parameter nil 'font -fontToUse)
    (message "Current font is: %s" -fontToUse )
    (put 'xah-cycle-font 'state -stateAfter)))

(defun xah-cycle-font-next ()
  "Switch to the next font, in current window.
See `xah-cycle-font'."
  (interactive)
  (xah-cycle-font 1))

(defun xah-cycle-font-previous ()
  "Switch to the previous font, in current window.
See `xah-cycle-font'."
  (interactive)
  (xah-cycle-font -1))



;; correct syntax for some fonts (tested on Windows Vista)
;; "-*-Courier New-normal-r-*-*-14-112-96-96-c-*-iso8859-1"
;; "-outline-Lucida Sans Unicode-normal-normal-normal-sans-13-*-*-*-p-*-iso8859-1"
;; "-outline-Code2000-normal-normal-normal-*-15-*-*-*-p-*-iso8859-1"
;; "-raster-Fixedsys-normal-normal-normal-mono-15-*-*-*-c-*-iso8859-1"
;; "-outline-FixedsysTTF-semi-bold-normal-normal-mono-16-*-*-*-c-*-iso8859-1"

;; fixed-width "Courier New" "Unifont"  "FixedsysTTF" "Miriam Fixed" "Lucida Console" "Lucida Sans Typewriter" "DejaVu Sans Mono-10" "Lucida Console-10"
;; variable-width "Arial Unicode MS-10" "Code2000" "STIXGeneral" "Lucida Console-10"
