;;; init-ripgrep.el --- Support for deadgrep -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (executable-find "rg")
  (maybe-require-package 'deadgrep))

(provide 'init-ripgrep)
;;; init-ripgrep.el ends here
