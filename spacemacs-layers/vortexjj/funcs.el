;; Random functions I want provided via a spacemacs layer.

;; Mark the current file executable
(defun chmod-executable ()
  (interactive)
  (shell-command (concat "chmod +x " (buffer-file-name))))

;; chmod's the file to be writable, then reloads the buffer
(defun chmod-writable()
  (interactive)
  (shell-command (concat "chmod +w " (buffer-file-name)))
  (revert-buffer t t))

;; Find all lines that are only whitespace and flush them
(defun strip-ws-lines ()
  "Removes all whitespace on lines that only have whitespace"
  (interactive)
  (beginning-of-buffer)
  (while (re-search-forward "[ ]+$" nil t)
    (replace-match "" nil nil))
  )

(defun comment-line()
  "toggles the commenting in/out of the current region or line"
  (interactive)
  (if (not (and transient-mark-mode mark-active))
      (progn
        (beginning-of-line)
        (push-mark)
        (end-of-line)))
  (comment-or-uncomment-region (region-beginning) (region-end)))

;; Take query and un-url-encode them. Also split them across multiple lines. If one of the lines
;; looks like it is json, beautify it.
;; Not all of this is done, only the un-url-encoding. Still need to support splitting into key=value
;; pairs too.
;; This works on a string argument, or on a region interactively.
(defun unfurl-query-args (string &optional from to)
  "Given a string or region, un-escape the URL-encoded bits"

  (interactive
   (if (use-region-p)
       (list nil (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) )
       (list nil (car bds) (cdr bds)))))
  (let (workOnStringP inputStr outputStr)
    (setq workOnStringP (if string t nil))
    (setq inputStr (if workOnStringP string (buffer-substring-no-properties from to)))
    (setq outputStr
          (let ((case-fold-search t))
            (url-unhex-string inputStr)))

    (if workOnStringP
        outputStr
      (save-excursion
        (delete-region from to)
        (goto-char from)
        (insert outputStr))))
  )

;; Shift the selected region right if distance is positive, left if
;; negative

(defun shift-region (distance)
  (let ((mark (mark)))
    (save-excursion
      (indent-rigidly (region-beginning) (region-end) distance)
      (push-mark mark t t)
      ;; Tell the command loop not to deactivate the mark
      ;; for transient mark mode
      (setq deactivate-mark nil))))

(defun shift-right ()
  (interactive)
  (shift-region 1))

(defun shift-left ()
  (interactive)
  (shift-region -1))

(defun coverage-report ()
  "Open the coverage report for this project."
  (interactive)

  (let*
      (
       (r (vc-git-root default-directory))
       (f (expand-file-name (concat r "coverage/index.html")))
       )
    (browse-url-of-file f)
    (message (concat "Opened " f))
    )
  )

(defun unix-file ()
  "Change the current buffer to Latin 1 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-unix t))
(defun dos-file ()
  "Change the current buffer to Latin 1 with DOS line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-dos t))
(defun mac-file ()
  "Change the current buffer to Latin 1 with Mac line-ends."
  (interactive)
  (set-buffer-file-coding-system 'iso-latin-1-mac t))

;; Randomize the region (shuffle the lines in a buffer)
(defun my-randomize-region (beg end)
  "Randomize lines in region from BEG to END."
  (interactive "*r")
  (let ((lines (split-string
                (delete-and-extract-region beg end) "\n")))
    (when (string-equal "" (car (last lines 1)))
      (setq lines (butlast lines 1)))
    (apply 'insert
           (mapcar 'cdr
                   (sort (mapcar (lambda (x) (cons (random) (concat x "\n"))) lines)
                         (lambda (a b) (< (car a) (car b))))))))
