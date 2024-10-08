;;; init-elixir.el --- Support for Elixir and heex templates  -*- lexical-binding: t -*-

;;; Commentary:
;;; Pretty Basic

;;; Code:
(maybe-require-package 'elixir-ts-mode)
(maybe-require-package 'heex-ts-mode)

;; TODO we can install the grammar here if need be on emacs 30

;; Format kbd
(add-hook 'elixir-ts-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'elixir-format)))

(add-hook 'heex-ts-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'elixir-format)))

;; Flycheck
(when (maybe-require-package 'flycheck-elixir)
  (add-hook 'elixir-ts-mode-hook 'flycheck-mode))

;; Treesitter

;; Eglot
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-ts-mode-hook 'eglot-ensure)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(elixir-ts-mode "~/elixir-ls/language_server.sh")))

(provide 'init-elixir)
;;; init-elixir.el ends here
