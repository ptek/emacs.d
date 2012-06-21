;; ========== LOADING/PATHS=============
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins"))
(add-to-list 'load-path "~/.emacs.d/elpa/hasktags-emacs")
(load "~/.emacs.d/elpa/haskell-mode/haskell-site-file")
(load "hasktags")
(require 'haskell-cabal)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'sane-haskell-indent-hook)
(defun sane-haskell-indent-hook ()
   (haskell-indentation-mode -1) ;; turn off, just to be sure, because this blows A$$
   (haskell-indent-mode 1)       ;; turn on indent-mode
   )


;; ======= BACKUP & AUTOSAVE FILES >> /dev/null
;; We have version control for a reason :)
(setq-default make-backup-files nil)
(setq-default auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-default nil)


;; ======== FILE EXTENSIONS =============
(mapcar (lambda (pair)
    (add-to-list 'auto-mode-alist pair))
        '(("Gemfile$"  . ruby-mode)
          ("\\.rake$"  . ruby-mode)
          ("Rakefile$" . ruby-mode)
          ("\\.json$"  . js-mode)
          ("\\.cabal$" . haskell-cabal-mode)))


;; ========= TABS/INDENTATION ===========
(setq-default tab-width 2)
(setq-default js-indent-level 2)       ; javascript
(setq-default css-indent-offset 2)     ; css
(setq-default haskell-indent-offset 2) ; Yeah
; spaces for tabbing
(setq-default indent-tabs-mode nil)

; always show that horrible trailing whitespace
(setq-default show-trailing-whitespace t)

; Use acutal tabs in Makefiles
(add-hook 'makefile-mode-hook
  (lambda()
    (setq indent-tabs-mode t)
    (setq tab-width 8)))

;; ========== BUFFERS/DIRED =============
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(put 'dired-find-alternate-file 'disabled nil)
(kill-buffer "*scratch*")

;; ========== LOOK AND FEEL =============
(setq inhibit-startup-message t)
(global-font-lock-mode 1)
(setq-default show-trailing-whitespace 't)
(setq scroll-step 1)
(show-paren-mode t)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(transient-mark-mode 1)
(delete-selection-mode 1)
(menu-bar-mode -1)
(set-language-environment "UTF-8")


;; ========== INPUT/CONTROL ============
(fset 'yes-or-no-p 'y-or-n-p)
;(global-set-key (kbd "C-c C-r") 'revert-buffer)
(global-unset-key (kbd "C-z"))
(global-unset-key (kbd "C-x C-z"))
(global-set-key (kbd "<C-tab>") 'other-window)
(put 'upcase-region 'disabled nil)

;; === Clear trailing whitespace
(defun toggle-noisy-whitespace ()
  (interactive)
  (if show-trailing-whitespace
      (progn
        (setq show-trailing-whitespace nil)
        (message "Noisy whitespace disabled"))
    (progn
      (setq show-trailing-whitespace t)
      (message "Noisy whitespace enabled"))))

(global-set-key (kbd "C-c w") 'delete-trailing-whitespace)
(global-set-key (kbd "C-c e") 'toggle-noisy-whitespace)
;; (add-hook 'before-save-hook 'whitespace-cleanup)
;; (add-hook 'makefile-mode-hook (lambda() (remove-hook 'before-save-hook 'whitespace-cleanup))) ;; Do not clean up whitespaces for makefiles. It breaks them.

;; === Easy commenting/uncommenting
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)

;; ========= Other functions ===
(defun terminal ()
  (interactive)
  (ansi-term "/bin/bash" "ansi-term")
  (toggle-noisy-whitespace))
(global-set-key (kbd "M-RET") 'terminal)

(set-face-attribute  'mode-line
                 nil
                 :foreground "white"
                 :background "black")

(set-face-attribute  'mode-line-inactive
                 nil
                 :foreground "white"
                 :background "black")
