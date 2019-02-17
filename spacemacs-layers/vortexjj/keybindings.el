;; Keybindings for my custom layer.
;; Shortcut to get into deft
(global-set-key [f8] 'deft)

;; I've started learning M-g g instead.
;; (global-set-key [(meta g)] 'goto-line)
(global-set-key [(meta k)] 'kill-whole-line)

;; Trying to learn SPC c l
;; (global-set-key (kbd "M-?") 'comment-line)

;; Find file in project (git repositories)
;; Trying to learn SPC p f to use helm-projectile-find-file
;;(global-set-key (kbd "M-R") 'find-file-in-project)
;;(global-set-key (kbd "M-R") 'helm-cmd-t-yesware-main)

;; find-file-in-project doesn't really seem to do a great job. Let's just use
;;plain ole helm-cmd-t, so it's consistent with the serup-search I setup above.
;; (global-set-key (kbd "C-M-R") 'helm-cmd-t)

;; Shortcuts to indent/outdent
(global-set-key (kbd "C->") 'shift-right)
(global-set-key (kbd "C-<") 'shift-left)

;; Dash-at-point load documentation in Dash.
;;(global-set-key (kbd "C-c d") 'dash-at-point)
