;;; init-eshell.el --- Summary

;;; Commentary:
;;; Some stuff for working with eshell

;;; Code:
(global-set-key (kbd "C-x e") 'eshell)

(with-eval-after-load "esh-opt"
  (when (maybe-require-package 'eshell-prompt-extras)
    (autoload 'epe-theme-lambda "eshell-prompt-extras"))
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-lambda))

(provide 'init-eshell)
;;; init-eshell.el ends here
