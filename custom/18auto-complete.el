(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/new_emacs/auto_complete/ac-dict")
(ac-config-default)
(setq ac-use-quick-help nil)

(add-hook 'rhtml-mode-hook
	  (lambda ()
	    (yas/minor-mode-on)
	    ))
(add-to-list 'ac-modes 'scala-mode)
(add-to-list 'ac-modes 'html-mode)





