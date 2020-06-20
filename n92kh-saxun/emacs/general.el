
;; General macros
;;
;; Author: txixco
;;

;;;; Keymaping
(global-set-key [(control f6)] 'fn-insert-buffer-full-name)

;; Variables
;(defvar af-current-alert 0)
;(defvar af-current-string "")

;; Functions
(defun fn-insert-buffer-full-name (str)
  (interactive "BBuffer to insert: ")
  (save-excursion
	(set-buffer str)
	(setq buffer-full-name (buffer-file-name)))
  (insert buffer-full-name))