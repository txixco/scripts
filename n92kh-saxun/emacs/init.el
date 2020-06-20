(load "~/.emacs.d/general")

;(load "t:/Scripts/emacs/thirdparty/nxhtml/autostart.el")

;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
    (autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))
    (autoload 'css-mode "css-mode" nil t)

(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.asp$" . html-helper-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.phtml$" . html-helper-mode) auto-mode-alist))

(setq ahk-syntax-directory "c:/Archivos de programa/AutoHotkey/Extras/Editors/Syntax/")
(add-to-list 'auto-mode-alist '("\\.ahk$" . ahk-mode))
(autoload 'ahk-mode "ahk-mode")


(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)

(autoload 'rtf-mode "rtf-mode" "RTF mode" t)
(add-to-list 'auto-mode-alist
  '("\\.rtf$" . rtf-mode))


(global-set-key [(f5)]  'af-load-debugging )

(defun af-load-debugging ()
  (interactive)
  (load "~/.emacs.d/debugging"))

(defun local-sgml-mode-hook
      (setq fill-column 80
            indent-tabs-mode nil
            next-line-add-newlines nil
            standard-indent 4
            sgml-indent-data t)
      (auto-fill-mode t)

      ; faces creation
	  (make-face 'sgml-comment-face)
	  (make-face 'sgml-start-tag-face)
	  (make-face 'sgml-end-tag-face)
	  (make-face 'sgml-entity-face)
	  (make-face 'sgml-doctype-face)

      ; faces definitions
	  (set-face-foreground 'sgml-comment-face "FireBrick")
	  (set-face-foreground 'sgml-start-tag-face "SlateBlue")
	  (set-face-foreground 'sgml-end-tag-face "SlateBlue")
	  (set-face-background 'sgml-entity-face "SlateBlue")
	  (set-face-foreground 'sgml-entity-face "Red")
	  (set-face-foreground 'sgml-doctype-face "FireBrick")

      ; markup to face mappings
	  (setq sgml-set-face t)  ; without this, all SGML text is in same color
	  (setq sgml-markup-faces
			'((comment   . sgml-comment-face)
			  (start-tag . sgml-start-tag-face)
			  (end-tag   . sgml-end-tag-face)
			  (doctype   . sgml-doctype-face)
			  (entity    . sgml-entity-face)))

    (add-hook 'sgml-mode-hook
      '(lambda () (local-sgml-mode-hook))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(abbrev-mode t)
 '(current-language-environment "Spanish")
 '(fill-column 80)
 '(font-lock-mode t t (font-lock))
 '(indent-tabs-mode t)
 '(inhibit-startup-screen t)
 '(make-backup-files nil)
 '(tab-width 4))

(setq c-offsets-alist '((statement-cont . ++)))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
