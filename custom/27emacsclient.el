;; (add-hook 'server-switch-hook
;; 	  (lambda nil
;; 	    (let ((server-buf (current-buffer)))
;; 	      (bury-buffer)
;; 	      (switch-to-buffer-other-frame server-buf))))
;; (add-hook 'server-done-hook 'delete-frame)

(add-hook 'server-switch-hook
	  (lambda ()
	    (menu-bar-mode -1)))

(add-hook 'server-done-hook (lambda nil (kill-buffer nil)))
