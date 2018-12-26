;;; init-php --- Summary

;;; Commentary:
;;; PHP with some nice extras

;;; Code:
(when (maybe-require-package 'php-mode)
  (maybe-require-package 'smarty-mode)

  (when (maybe-require-package 'company-php)
    (after-load 'company
      (add-hook 'php-mode-hook
                (lambda () (sanityinc/local-push-company-backend 'company-ac-php-backend))))))

(add-hook 'php-mode-hook 'php-enable-psr2-coding-style)

;;; Formatter
;; (when (maybe-require-package 'phpcbf)
;;   (custom-set-variables
;;    '(phpcbf-executable "~/.config/composer/vendor/bin/phpcbf")
;;    '(phpcbf-standard "PSR2"))
;;   (after-load 'php-mode
;;     (add-hook 'php-mode-hook (lambda () (local-set-key (kbd "C-i f") #'phpcbf)))))

(provide 'init-php)
;;; init-php ends here
