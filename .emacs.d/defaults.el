(setq-default inhibit-startup-screen t)

(show-paren-mode 1)    ;; show matching parenthesis
(blink-cursor-mode 0)  ;; turn off blinking cursor
(require 'pcvs)        ;; required for code checkout

(semantic-mode 1)

(set-face-attribute 'default nil :height 130)
;;(set-face-attribute 'default nil :font "Deja Vu Sans Mono") 

(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
 '(ediff-current-diff-A ((t (:background "#330000"))))
 '(ediff-current-diff-B ((t (:background "#003300"))))
 '(ediff-fine-diff-A ((t (:background "#332222"))))
 '(ediff-fine-diff-B ((t (:background "#004400")))))
