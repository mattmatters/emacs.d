;;; init-fonts.el --- Configure default font
;;; Commentary:
;;; Code:


(require 'fira-code-mode)
;; (custom-set-variable 'fira-code-mode-disabled-ligatures '("[]" "#{" "#(" "#_" "#_(" "x")) ;; List of ligatures to turn off

;; Enable fira-code-mode automatically for programming major modes
(add-hook 'prog-mode-hook 'fira-code-mode)

(provide 'init-fonts)
;;; init-fonts.el ends here
