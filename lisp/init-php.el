;;; init-php.el --- Support for working with PHP -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'php-mode)
  (maybe-require-package 'smarty-mode)

  (when (maybe-require-package 'company-php)
    (after-load 'company
      (push 'company-ac-php-backend company-backends))))

(add-hook 'php-mode-hook 'php-enable-psr2-coding-style)

;;; Formatter
;; (when (maybe-require-package 'phpcbf)
;;   (custom-set-variables
;;    '(phpcbf-executable "~/.config/composer/vendor/bin/phpcbf")
;;    '(phpcbf-standard "PSR2"))
;;   (after-load 'php-mode
;;     (add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-i f") #'phpcbf)))))

(provide 'init-php)
;;; init-php.el ends here
