(load-file "/home/anault/.emacs.d/key_bindings.el")                  ;; load key_bindings file
(load-file "/home/anault/.emacs.d/gtags.el")                         ;; load gtags file, used for Global Tags 
(load-file "/home/anault/.emacs.d/defaults.el")                      ;; load default configuration file
;;;(load-file "/home/anault/.emacs.d/files.el") ;; not working in emacs 24.5

;;;(load-file "/home/anault/.emacs.d/elpa/diff-hl-1.5.1/diff-hl.el")    ;; load diff-hl lisp file ;; not working in emacs 24.5 (cannot open cl-lib)

;;;(add-to-list 'load-path "~/.emacs.d/") ;; causes warning in emacs 24.5

;; ido creates a list of files in the mini buffer when doing things
;; like open file or change to buffer
(require 'ido)  ;; Interactively DO things - available after Emacs 22
(ido-mode t)    ;; Turn on ido by default

;; ------------- python mode -------------
(setq py-install-directory "~/.emacs.d/python-mode-6.1.3")
(add-to-list 'load-path py-install-directory)
(load-file "/home/anault/.emacs.d/python-mode-6.1.3/python-mode.el")
(require 'python-mode)

;; use IPython
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")

;; use the wx backend, for both mayavi and matplotlib
(setq py-python-command-args
	  '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
(setq py-force-py-shell-name-p t)

;; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
(setq py-switch-buffers-on-execute-p nil)
;; don't split windows
(setq py-split-windows-on-execute-p nil)
;; try to automatically figure out indentation
(setq py-smart-indentation t)
;; ------------- end python mode -------------

;; ------------- elDoc options -------------
;; elDoc shows the argument list of the function call you are 
;; currently writing.  This shows up in the echo area
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;; ------------- elDoc end -------------

;; ------------- el-get options -------------
;; el-get is a tool that allows downloading external scripts/extensions
;; for Emacs, install, update, initialize them for you.
;; disabled most of this because it causes errors and a long time to load
;; emacs.
(add-to-list 'load-path "~/.emacs.d/el-get/el-get-master")

;;;(unless (require 'el-get nil 'noerror)
;;;  (with-current-buffer
;;;	  (url-retrieve-synchronously
;;;	   "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;;	(goto-char (point-max))
;;;	(eval-print-last-sexp)))

;;;(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get/el-get-master/recipes")
;;;(el-get 'sync)
;; ------------- end el-get -------------

;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;;(ac-config-default)

;; ------------- cscope options -------------
;;;(setq cscope-do-not-update-database t)               ;; Do not update cscope database every time a cscope command is run (this causes cscope to run very slow)
;;;(load-file "/usr/share/emacs/site-lisp/xcscope.el")  ;; load xcscope.el (required to run cscope in emacs)
;;;(require 'xcscope)

;; ------------- color theme options -------------
(add-to-list 'load-path "/home/anault/opt/lib/color-theme-6.6.0/")  ;; directory with custom color themes
(require 'color-theme)                                              ;; require color-theme
(setq color-theme-is-global t)                                      ;; set color theme global
(color-theme-initialize)                                            ;; initialize color-theme
(color-theme-nault2)                                                ;; custom make color-theme - located in load-path

(add-hook 'c-mode-hook
	(lambda ()
	(c-set-style "bsd")
	(setq c-basic-offset 4)
	(gtags-mode 1)))

(setq c-default-style "linux"
	c-basic-offset 4)
(setq-default c-tab-always-indent t)  ;; always indent current line
(setq-default tab-width 4)

(global-visual-line-mode 1)           ;; instead of word wrap it just continues code on next line

;; ------------- diff viewer options -------------
;;;(require 'diff-hl)
;;;(setq ediff-split-window-function 'split-window-horizontally)
;;;(setq ediff-diff-options "-w")
;;;(setq-default ediff-highlight-all-diffs nil)
;;;(setq-default ediff-window-setup-function 'ediff-setup-windows-plain)

;; Toggle window dedication

;;;(defun toggle-window-dedicated ()
;;;"Toggle whether the current active window is dedicated or not"
;;;(interactive)
;;;(message
;;;	(if (let (window (get-buffer-window (current-buffer)))
;;;		(set-window-dedicated-p window
;;;		(not (window-dedicated-p window))))
;;;	"Window '%s' is dedicated"
;;;	"Window '%s' is normal")
;;;	(current-buffer)))

;;(global-set-key [pause] 'toggle-window-dedicated)

;;;(setq even-window-heights nil)
;;;(custom-set-faces
;;; '(diff-added ((t (:foreground "Green"))) 'now)
;;; '(diff-removed ((t (:foreground "Red"))) 'now)
;;; '(diff-changed ((t (:foregroud "Blue"))) 'now)
;;;)
;; ------------- end diff viewer options -------------

;; ------------- gdb options -------------
(setq-default gdb-many-windows t)          ;; starts gdb with 5 windows (file, gdb cmd, stack, )

;; add color to the current GUD line
(defvar gud-overlay
(let* ((ov (make-overlay (point-min) (point-min))))
(overlay-put ov 'face 'secondary-selection)
ov)
"Overlay variable for GUD highlighting.")

(defadvice gud-display-line (after my-gud-highlight-act)
"Highlight current line."
(let* ((ov gud-overlay)
(bf (gud-find-file true-file)))
(save-excursion
	(set-buffer bf)
	(move-overlay ov (line-beginning-position) (line-end-position)
	(current-buffer)))))

(defun gud-kill-buffer ()
(if (eq major-mode 'gud-mode)
(delete-overlay gud-overlay)))

(add-hook 'kill-buffer-hook 'gud-kill-buffer)
;; ------------- end gdb options -------------

;; ------------- copy current line -------------

(defun xah-copy-line-or-region ()
  "Copy current line, or text selection.
When `universal-argument' is called first, copy whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position 1))
                        (setq p2 (line-beginning-position 2)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-ring-save p1 p2)))

;; ------------- copy current line end -------------

;; ------------- cut current line -------------

(defun xah-cut-line-or-region ()
  "Cut current line, or text selection.
When `universal-argument' is called first, cut whole buffer (but respect `narrow-to-region')."
  (interactive)
  (let (p1 p2)
    (if (null current-prefix-arg)
        (progn (if (use-region-p)
                   (progn (setq p1 (region-beginning))
                          (setq p2 (region-end)))
                 (progn (setq p1 (line-beginning-position))
                        (setq p2 (line-beginning-position 2)))))
      (progn (setq p1 (point-min))
             (setq p2 (point-max))))
    (kill-region p1 p2)))

;; ------------- cut current line end -------------

;; ;; ------------- search for word under cursor -------------

;;;(defun search-under-cursor ()
;;;   "Searches for word under the cursor"
;;;   (interactive)
;;;   (backword-word)
  
;; ;; ------------- search for word under cursor end -------------

