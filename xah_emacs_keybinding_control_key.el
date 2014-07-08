;; -*- coding: utf-8 -*-

(global-set-key (kbd "C-1") 'xah-cycle-font-previous)
(global-set-key (kbd "C-2") 'xah-cycle-font-next)
(global-set-key (kbd "C-3") 'xah-cycle-hyphen-underscore-space)
(global-set-key (kbd "C-4") 'xah-cycle-camel-style-case)
(global-set-key (kbd "C-5") 'xah-cycle-font-2)
(global-set-key (kbd "C-6") 'tags-loop-continue)
(global-set-key (kbd "C-7") 'xah-backward-punct)
(global-set-key (kbd "C-8") 'xah-forward-punct)
(global-set-key (kbd "C-9") nil)

(global-set-key (kbd "C-w") 'xah-close-current-buffer)
(global-set-key (kbd "C-o") 'find-file)
(global-set-key (kbd "C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-n") 'xah-new-empty-buffer)
(global-set-key (kbd "C-S-s") 'write-file)
(global-set-key (kbd "C-S-t") 'xah-open-last-closed)

;;
;; cut x C-x
;; copy c C-c
;; paste p prev line
;; undo z suspend frame
;; redo y yank



(global-set-key (kbd "<C-f9>") 'xah-syntax-bracket-backward)
(global-set-key (kbd "<C-f10>") 'xah-syntax-bracket-forward)
(global-set-key (kbd "<C-f7>") 'xah-goto-previous-overlay)
(global-set-key (kbd "<C-f8>") 'xah-goto-next-overlay)