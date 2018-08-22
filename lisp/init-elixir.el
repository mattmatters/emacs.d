;;; init-elixir --- Summary

;;; Commentary:
;;; Pretty Basic

;;; Code:
(maybe-require-package 'elixir-mode)


(when (maybe-require-package 'alchemist-mode)
  (after-load 'elixir
    (add-hook 'elixir-mode-hook 'alchemist-mode))
  (when (maybe-require-package 'company-elixir)
    (after-load 'company
      (add-hook 'elixir-mode-hook
                (lambda () (sanityinc/local-push-company-backend 'company-elixir))))))

(provide 'init-elixir)
;;; init-elixir ends here
