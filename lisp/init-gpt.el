;;; init-gpt.el --- Integrate with gpt -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'gptel)
  (gptel-make-anthropic "Claude" :stream t :key gptel-api-key))

(provide 'init-gpt)

;;; init-gpt.el ends here
