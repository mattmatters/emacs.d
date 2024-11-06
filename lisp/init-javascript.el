;;; init-javascript.el --- Support for Javascript and derivatives -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'json-mode)
(maybe-require-package 'js2-mode)
(maybe-require-package 'prettier)
(maybe-require-package 'add-node-modules-path)


;;; Basic js-mode setup

(add-to-list 'auto-mode-alist '("\\.\\(m?js\\|es6\\)\\(\\.erb\\)?\\'" . js-mode))

(with-eval-after-load 'js
  (sanityinc/major-mode-lighter 'js-mode "JS")
  (sanityinc/major-mode-lighter 'js-jsx-mode "JSX"))

(setq-default js-indent-level 2)
(add-hook 'js-mode-hook 'add-node-modules-path)


;;; Basic typescript-mode setup

(setq-default typescript-indent-level 2)
(add-hook 'typescript-ts-base-mode-hook 'add-node-modules-path)


;; js2-mode

;; Change some defaults: customize them to override
(setq-default js2-bounce-indent-p nil)
(with-eval-after-load 'js2-mode
  ;; Disable js2 mode's syntax error highlighting by default...
  (setq-default js2-mode-show-parse-errors nil
                js2-mode-show-strict-warnings nil)
  ;; ... but enable it if flycheck can't handle javascript
  (autoload 'flycheck-get-checker-for-buffer "flycheck")
  (defun sanityinc/enable-js2-checks-if-flycheck-inactive ()
    (unless (flycheck-get-checker-for-buffer)
      (setq-local js2-mode-show-parse-errors t)
      (setq-local js2-mode-show-strict-warnings t)
      (when (derived-mode-p 'js-mode)
        (js2-minor-mode 1))))
  (add-hook 'js-mode-hook 'sanityinc/enable-js2-checks-if-flycheck-inactive)
  (add-hook 'js2-mode-hook 'sanityinc/enable-js2-checks-if-flycheck-inactive)
  (js2-imenu-extras-setup))

(add-to-list 'interpreter-mode-alist (cons "node" 'js2-mode))

(with-eval-after-load 'js2-mode
  (sanityinc/major-mode-lighter 'js2-mode "JS2")
  (sanityinc/major-mode-lighter 'js2-jsx-mode "JSX2"))


(require 'derived)
(when (and (or (executable-find "rg") (executable-find "ag"))
           (maybe-require-package 'xref-js2))
  (when (executable-find "rg")
    (setq-default xref-js2-search-program 'rg))

  (defun sanityinc/enable-xref-js2 ()
    (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))

  (let ((base-mode (if (fboundp 'js-base-mode) 'js-base-mode 'js-mode)))
    (with-eval-after-load 'js
      (add-hook (derived-mode-hook-name base-mode) 'sanityinc/enable-xref-js2)
      (define-key js-mode-map (kbd "M-.") nil)
      (when (boundp 'js-ts-mode-map)
        (define-key js-ts-mode-map (kbd "M-.") nil))))
  (with-eval-after-load 'js2-mode
    (define-key js2-mode-map (kbd "M-.") nil)))



;; Formatter

;; Run `npm install -g prettier` to get it everywhere
;; for some reason with-eval-after-load doesn't work with typescript-ts-base-mode
(add-hook 'typescript-ts-base-mode-hook
          (lambda () (when (executable-find "prettier")
                  (prettier-mode 1)
                  (local-set-key (kbd "C-i f") #'prettier-prettify))))

(add-hook 'js2-mode-hook 'prettier-mode)
(add-hook 'js2-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'prettier-prettify)))
(add-hook 'js-mode-hook 'prettier-mode)
(add-hook 'js-mode-hook
          (lambda () (local-set-key (kbd "C-i f") #'prettier-prettify)))

(setq-default prettier-prettify-on-save-flag nil)


;; Language server

;; Run npm install -g typescript-language-server
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((typescript-ts-base-mode) "typescript-language-server" "--stdio")))

(add-hook 'typescript-ts-base-mode-hook
          (lambda () (when (executable-find "typescript-language-server")
                  (eglot-ensure))))

;; Run and interact with an inferior JS via js-comint.el

(when (maybe-require-package 'js-comint)
  (setq js-comint-program-command "node")

  (defvar inferior-js-minor-mode-map (make-sparse-keymap))
  (define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
  (define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)

  (define-minor-mode inferior-js-keys-mode
    "Bindings for communicating with an inferior js interpreter."
    :init-value nil :lighter " InfJS" :keymap inferior-js-minor-mode-map)

  (dolist (hook '(js2-mode-hook js-mode-hook))
    (add-hook hook 'inferior-js-keys-mode)))


(provide 'init-javascript)
;;; init-javascript.el ends here
