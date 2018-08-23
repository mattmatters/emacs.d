;;; init-elixir --- Summary

;;; Commentary:
;;; Pretty Basic

;;; Code:
(maybe-require-package 'elixir)

;; Format kbd
(add-hook 'elixir-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'elixir-format)))

(require 'flycheck-elixir)

;; Alchemist Stuff
(when (maybe-require-package 'alchemist-mode)
  (after-load 'elixir
    (add-hook 'elixir-mode-hook 'alchemist-mode)))

;; Company
(when (maybe-require-package 'company-elixir)
  (after-load 'company
    (add-hook 'elixir-mode-hook
              (lambda () (sanityinc/local-push-company-backend 'company-elixir)))))

;; Flycheck
(when (maybe-require-package 'flycheck-elixir)
  (add-hook 'elixir-mode-hook 'flycheck-mode))

(provide 'init-elixir)
;;; init-elixir ends here
