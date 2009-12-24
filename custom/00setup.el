(add-to-list 'default-frame-alist '(left . 0))

(add-to-list 'default-frame-alist '(top . 0))

(add-to-list 'default-frame-alist '(height . 45))

(add-to-list 'default-frame-alist '(width . 175))

;; y/n instead of yes/no
(defalias 'yes-or-no-p 'y-or-n-p)              

;; highlight incremental search
(setq search-highlight t)
(transient-mark-mode t)
(tool-bar-mode nil)
(menu-bar-mode nil)
(display-time)
;;(scroll-bar-mode nil)
(setq x-select-enable-clipboard t)

(setq x-select-enable-clipboard t)	; as above
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

(global-set-key [f2] 'comment-region)
(global-set-key [f3] 'uncomment-region)
(global-set-key [f4] 'goto-line)
(global-set-key [f5] 'indent-region)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-l" 'end-of-line)

(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-xt" 'select-frame-by-name)

(global-set-key "\C-cr" 'revert-buffer)

(setq backup-inhibited t)
;;disable auto save
(setq auto-save-default nil)

;; change cursor color
(set-cursor-color "Red")

;;some custom functions, stolen for internet
(defun geosoft-forward-word ()
   ;; Move one word forward. Leave the pointer at start of word
   ;; instead of emacs default end of word. Treat _ as part of word
   (interactive)
   (forward-char 1)
   (backward-word 1)
   (forward-word 2)
   (backward-word 1)
   (backward-char 1)
   (cond ((looking-at "_") (forward-char 1) (geosoft-forward-word))
         (t (forward-char 1)))) 
(defun geosoft-backward-word ()
 ;; Move one word backward. Leave the pointer at start of word
 ;; Treat _ as part of word
  (interactive)
  (backward-word 1)
  (backward-char 1)
  (cond ((looking-at "_") (geosoft-backward-word))
        (t (forward-char 1)))) 

(global-set-key [C-right] 'geosoft-forward-word)
(global-set-key [C-left] 'geosoft-backward-word)

;; automatically indenting yanked text if in programming-modes
(defvar yank-indent-modes '(emacs-lisp-mode
                            c-mode c++-mode
                            tcl-mode sql-mode
                            perl-mode cperl-mode
                            java-mode jde-mode
                            lisp-interaction-mode
                            LaTeX-mode TeX-mode ruby-mode)
  "Modes in which to indent regions that are yanked (or yank-popped)")

(defvar yank-advised-indent-threshold 1000
  "Threshold (# chars) over which indentation does not automatically occur.")

(defun yank-advised-indent-function (beg end)
  "Do indentation, as long as the region isn't too large."
  (if (<= (- end beg) yank-advised-indent-threshold)
      (indent-region beg end nil)))

(defadvice yank (after yank-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
      (let ((transient-mark-mode nil))
    (yank-advised-indent-function (region-beginning) (region-end)))))

(defadvice yank-pop (after yank-pop-indent activate)
  "If current mode is one of 'yank-indent-modes, indent yanked text (with prefix arg don't indent)."
  (if (and (not (ad-get-arg 0))
           (member major-mode yank-indent-modes))
    (let ((transient-mark-mode nil))
    (yank-advised-indent-function (region-beginning) (region-end)))))

(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers
