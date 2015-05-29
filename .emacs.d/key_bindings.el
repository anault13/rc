;; goto key bindings
(global-set-key (quote [f1]) 'beginning-of-buffer)
(global-set-key (quote [f2]) 'goto-line)
(global-set-key (quote [f3]) 'end-of-buffer)
;; (global-set-key (quote [f4]) ')

(global-set-key (quote [f5]) 'scroll-all-mode)
(global-set-key (quote [f6]) 'ido-mode)
;; (global-set-key (quote [f7]) ')
;; (global-set-key (quote [f8]) ')

(global-set-key (quote [f9]) 'diff-hl-mode)
(global-set-key (quote [f10]) 'comment-region)
(global-set-key (kbd "C-<f10>") 'uncomment-region)
(global-set-key (quote [f11]) 'tabify)
(global-set-key (kbd "C-<f11>") 'untabify)
(global-set-key (quote [f12]) (quote global-whitespace-mode))

(global-set-key [(control up)] 'backward-paragraph)
(global-set-key [(control down)] 'forward-paragraph)

(global-set-key (kbd "C-r") 'query-replace)

;; cscope key bindings
(global-set-key (kbd "C-c c") 'cscope-find-functions-calling-this-function)
(global-set-key (kbd "C-c d") 'cscope-find-global-definition)
(global-set-key (kbd "C-c e") 'cscope-find-egrep-pattern)
(global-set-key (kbd "C-c f") 'cscope-find-this-file)
(global-set-key (kbd "C-c m") 'cscope-find-this-symbol)
(global-set-key (kbd "C-c t") 'cscope-find-this-text-string)

;; gtags key bindings
;; (global-set-key (kbd "C-c c") 'cscope-find-functions-calling-this-function)
;; (global-set-key (kbd "C-c d") 'cscope-find-global-definition)
;; (global-set-key (kbd "C-c f") 'gtags-find-file)
;; (global-set-key (kbd "C-c g") 'cscope-find-with-grep)
;; (global-set-key (kbd "C-c m") 'gtags-find-symbol)
;; (global-set-key (kbd "C-c t") 'cscope-find-this-text-string)


;; gdb key bindings


;; diff-hl key bindings


;; ediff key bindings
(define-prefix-command 'mode-specific-map)
(global-set-key (kbd "C-d") 'mode-specific-map)
(global-set-key (kbd "C-d r") 'ediff-revision)
(global-set-key (kbd "C-d f") 'ediff-files)

;; iPython key bindings
;;(global-set-key (kbd "C-p") 'mode-specific-map)
;;(global-set-key (kbd "C-p r") 'py-send-region-ipython)
;;(global-set-key (kbd "C-p r") 'ediff-revision)
;(global-set-key (kbd "C-p r") 'ediff-revision)
;(global-set-key (kbd "C-p r") 'ediff-revision)

;; copy/cut key bindings
(global-set-key (kbd "C-w") 'xah-cut-line-or-region)
(global-set-key (kbd "M-w") 'xah-copy-line-or-region)

;; compile and run using make
;;(global-set-key (kbd "C-m c") 'compile)

