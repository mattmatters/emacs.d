;;; init-elixir.el --- Support for Elixir and heex templates  -*- lexical-binding: t -*-

;;; Commentary:
;;; Pretty Basic

;;; Code:
(maybe-require-package 'elixir-ts-mode)
(maybe-require-package 'heex-ts-mode)

;; TODO we can install the grammar here if need be on emacs 30

(add-to-list 'auto-mode-alist '("\\.exs?\\'" . elixir-ts-mode))
(add-to-list 'auto-mode-alist '("\\.heex\\'" . heex-ts-mode))



;; Flycheck
(when (maybe-require-package 'flycheck-elixir)
  (add-hook 'elixir-ts-mode-hook 'flycheck-mode))


;; Treesitter

;; Eglot
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'elixir-ts-mode-hook 'eglot-ensure)

;; Lots of my projects are monorepos
(with-eval-after-load 'project
  (add-to-list 'project-vc-extra-root-markers "mix.exs"))

;; The marker moves the project boundary for navigation too, so you can't jump
;; to sibling dirs. If that gets annoying in polyglot worktrees, play around
;; with this instead. Narrows the root for eglot only, leaves project.el alone:
;;   (defun m/eglot-mix-root (dir)
;;     (when (bound-and-true-p eglot-lsp-context)
;;       (when-let ((root (locate-dominating-file dir "mix.exs")))
;;         (cons 'transient root))))
;;   (add-hook 'project-find-functions #'m/eglot-mix-root)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(elixir-ts-mode "~/elixir-ls/language_server.sh")))

;; Format kbd (I might want to move this to just after eglot loads)
(add-hook 'elixir-ts-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'eglot-format)))

(add-hook 'heex-ts-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'eglot-format)))

(provide 'init-elixir)
;;; init-elixir.el ends here
