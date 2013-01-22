(dolist (unkey '("\C-z"
                 "\C-h" "\C-H"))
  (global-unset-key unkey))

;(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key "\C-z" 'undo)

;; Map certain keypad keys into ASCII characters
;; that people usually expect.
(define-key function-key-map [backspace] [127])
(define-key function-key-map [delete] [127])

(define-key function-key-map [delete] [deletechar])


(custom-set-faces
;  use  C-u C-x =    see the face at cursor position
;
;   custom-set-faces was added by Custom.
;   If you edit it by hand, you could mess it up, so be careful.
;   Your init file should contain only one such instance.
;   If there is more than one, they won't work right.
;  '(default ((t (:inherit nil :stipple nil :background "lightyellow2" :foreground "gray20" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :width normal :family "liberation mono"))))

;  '(default ((t (:inherit nil :stipple nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :width normal :family "liberation mono"))))

;  '(background "blue")
;  '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "Turquoise"))))
;  '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
;  '(font-lock-constant-face ((((class color) (background dark)) (:bold t :foreground "DarkOrchid"))))
;  '(font-lock-doc-string-face ((t (:foreground "green2"))))
;;  '(font-lock-function-name-face ((t (:foreground "SkyBlue"))))
;  '(font-lock-keyword-face ((t (:bold t :foreground "CornflowerBlue"))))
;  '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
;  '(font-lock-reference-face ((t (:foreground "DodgerBlue"))))
;  '(font-lock-string-face ((t (:foreground "LimeGreen"))))

  '(font-lock-function-name-face ((t (:foreground "royalblue"))))

;  '(font-lock-comment-face ((t (:foreground "firebrick"))))
;    '(font-lock-comment-delimiter-face  ((t (:foreground "firebrick"))))


)

(cua-mode 1)
(add-to-list 'load-path "~/.emacs.d/elisp_scripts/")
(load "xclip")

;(setq x-select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


;(defvar fst-mode-syntax-table
;  (let ( (fst-mode-syntax-table (make-syntax-table) ) )
;    (modify-syntax-entry  ?#   "<"   fst-mode-syntax-table)  ; start comment
;    (modify-syntax-entry  ?\n  ">"   fst-mode-syntax-table)  ; end comment
;    (modify-syntax-entry  ?\\  "_"   fst-mode-syntax-table)  ; don't escape quote
;    (modify-syntax-entry  ?%   "/"   fst-mode-syntax-table)  ; functions as escape char
;    fst-mode-syntax-table )
;  "Syntax table for fst-mode" )




