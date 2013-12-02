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



;; disable the automatic EOF generation in Shell Mode
(eval-after-load "sh-mode" '(progn (define-key sh-mode-map (if "<" "<") (local-set-key "<" 'self-insert-command) )))
;;; bpalmer  (eval-after-load "sh-mode" '(progn (define-key sh-mode-map (if ...))))
;;; BAD FORM: bpalmer: shouldn't defvar something that's defined in a library
;(defvar sh-use-prefix nil
;  "If non-nil when loading, `$' and `<' will be  C-c $  and  C-c < .")
;(defvar sh-mode-map
;  (let ((map (make-sparse-keymap)))
;    (define-key map (if sh-use-prefix "\C-c<" "<")
;      (local-set-key "<" 'self-insert-command))
;   map)
;  "Keymap used in Shell-Script mode.")
;; end automatic EOF in Shell Mode






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





;;;;;;   gnuplot
; To add the gnuplot mode in Emacs, add the content of /usr/share/emacs/site-lisp/dotemacs to your ~/.emacs file
;;--------------------------------------------------------------------
;; Lines enabling gnuplot-mode

;; move the files gnuplot.el to someplace in your lisp load-path or
;; use a line like
;;  (setq load-path (append (list "/path/to/gnuplot") load-path))

;; these lines enable the use of gnuplot mode
  (autoload 'gnuplot-mode "gnuplot" "gnuplot major mode" t)
  (autoload 'gnuplot-make-buffer "gnuplot" "open a buffer in gnuplot mode" t)

;; this line automatically causes all files with the .gp extension to
;; be loaded into gnuplot mode
  (setq auto-mode-alist (append '(("\\.gp$" . gnuplot-mode)) auto-mode-alist))

;; This line binds the function-9 key so that it opens a buffer into
;; gnuplot mode
  (global-set-key [(f9)] 'gnuplot-make-buffer)

;; end of line for gnuplot-mode
;;--------------------------------------------------------------------






