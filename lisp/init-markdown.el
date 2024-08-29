;;; init-markdown.el --- Markdown support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'markdown-mode)
  (add-auto-mode 'markdown-mode "\\.md\\.html\\'")
  (with-eval-after-load 'whitespace-cleanup-mode
    (add-to-list 'whitespace-cleanup-mode-ignore-modes 'markdown-mode))
  (when (executable-find "marksman")
    (with-eval-after-load 'eglot
      (add-to-list 'eglot-server-programs '(markdown-mode . ("marksman" "server"))))
    (add-hook 'markdown-mode-hook #'eglot-ensure)))

(provide 'init-markdown)
;;; init-markdown.el ends here
