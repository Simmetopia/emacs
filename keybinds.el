(global-set-key (kbd "C-c f") 'projectile-find-file )
(global-set-key (kbd "C-c l") 'prettier-js )
(global-set-key (kbd "C-c p") 'projectile-switch-project )
(defun open-frame-organizor ()
  (interactive)
  (find-file-other-frame "~/documentation/organizor.org"))
(global-set-key (kbd "C-c v") 'open-frame-organizor )




