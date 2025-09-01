;;; init-claude-code.el --- Integrate with Claude Code -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-l" . claude-code-ide-menu)
  :config (claude-code-ide-emacs-tools-setup))

(provide 'init-claude-code)

;;; init-claude-code.el ends here
