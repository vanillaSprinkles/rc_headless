(require 'custom-comments)

(setq custom-comment-suppress-init-message t) ;; NOTE: suppress initial confirmation message

(setq custom-comment-tag-alist-heading '("AUTHOR"
					 "SOURCE"
					 "COMMENT"
					 "FILE")) ;; NOTE: add `heading' tags to highlighting

(add-to-list 'custom-comment-tag-alist-heading "TIME") ;; NOTE: this is not in the default `heading' list

(setq custom-comment-tag-alist-comment '("IMPORTANT"
					 "NOTE"
					 "TODO")) ;; NOTE: add `comment' tags to highlighting

(setq custom-comment-tag-alist-warning '("BUG"
					 "DEBUG"
					 "ERROR"
					 "FIX"
					 "WARNING"
					 "TEST")) ;; NOTE: add `warning' tages to highlighting

(setq custom-comment-tag-mode-hooks '(emacs-lisp-mode-hook
				      lisp-mode-hook
				      shell-script-mode-hook
				      sh-mode-hook
				      conf-mode-hook
				      haskell-mode-hook
				      scheme-mode-hook
				      cc-mode-hook
				      c++-mode-hook
				      c-mode-hook
				      python-mode-hook
				      js-mode-hook
				      javascript-mode-hook
				      bibtex-mode
				      )) ;; NOTE: add `major-modes' to highlighting list

(activate-highlight-custom-comment-tags) ;; NOTE: activate custom comment tags