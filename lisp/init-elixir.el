;;; init-elixir --- Summary

;;; Commentary:
;;; Pretty Basic

;;; Code:
(maybe-require-package 'elixir-mode)

;; Format kbd
(add-hook 'elixir-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'elixir-format)))

;; Flycheck
(when (maybe-require-package 'flycheck-elixir)
  (add-hook 'elixir-mode-hook 'flycheck-mode))

;; Alchemist Stuff
(when (maybe-require-package 'alchemist)
  (after-load 'elixir-mode
    (add-hook 'elixir-mode-hook 'alchemist-mode)))



(provide 'init-elixir)
;;; init-elixir ends here
