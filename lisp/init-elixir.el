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

;; Eglot
(add-hook 'elixir-mode-hook 'eglot-ensure)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(elixir-mode "~/elixir-ls/language_server.sh")))

(provide 'init-elixir)
;;; init-elixir ends here
