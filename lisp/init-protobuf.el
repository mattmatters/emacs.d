;;; init-protobuf.el --- Support for Elixir and heex templates  -*- lexical-binding: t -*-

;;; Commentary:
;;; Pretty Basic

;;; Code:
(maybe-require-package 'protobuf-mode)

(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

(when (maybe-require-package 'flycheck-buf-lint)
  (add-hook 'protobuf-mode-hook 'flycheck-mode))


(provide 'init-protobuf)
;;; init-protobuf.el ends here
