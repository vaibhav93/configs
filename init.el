
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)

(add-to-list 'package-archives
             '("MELPA Stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(projectile-mode)
;;Hide toolbars
(tool-bar-mode -1)
(menu-bar-mode -1)
;;Python
(elpy-enable)

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    py-autopep8))
(require 'py-autopep8)
(remove-hook 'elpy-modules 'elpy-module-flymake)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;;beautify
(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'json-mode
  '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

(eval-after-load 'sgml-mode
  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'web-mode
  '(define-key web-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

;;Load monokai theme
(load-theme 'monokai t)
;;HELM
(require 'helm-config)
(helm-mode 1)
;;HELM addons
(require 'helm-ls-git)
(require 'helm-swoop)
;;Swoop prevent searching current word
(setq helm-swoop-pre-input-function (lambda () ""))

(helm-projectile-on)
(global-set-key (kbd "C-x o") 'helm-swoop)

;;Change paste
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "M-v") 'yank-pop)

;;Magit
(global-set-key (kbd "C-x o") 'helm-swoop)

;;Custom cursor bindings
(bind-key* "C-j" 'backward-char)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-j") 'backward-char)

(define-key input-decode-map (kbd "C-i") (kbd "H-i"))
(global-set-key (kbd "H-i") 'previous-line)
;;(global-set-key (kbd "C-i") 'previous-line)
(global-set-key (kbd "C-k") 'next-line)

(global-set-key (kbd "M-l") 'forward-word)
(global-set-key (kbd "M-j") 'backward-word)

;; Show line number
(global-linum-mode t)

;;Reload emacs init
(defun reload-init-file ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

(global-set-key (kbd "C-c C-l") 'reload-init-file)

;;enlarge window
(global-set-key (kbd "<M-down>") 'enlarge-window)
(global-set-key (kbd "<M-up>") 'shrink-window)

(setq org-replace-disputed-keys t)
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)
;;Org mode sepatrator line
(setq org-cycle-separator-lines 1)
(global-set-key (kbd "C-S-j")  'windmove-left)
(global-set-key (kbd "C-S-l")  'windmove-right)
;;Shift windows focus
;;Move windows using shift+arrow
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;;Stop annoying bell sound
(setq ring-bell-function 'ignore)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal)))))

;;java mode
(require 'eclim)
(add-hook 'java-mode-hook 'eclim-mode)
(require 'gradle-mode)
(add-hook 'java-mode-hook '(lambda() (gradle-mode 1)))
(defun build-and-run ()
	(interactive)
	(gradle-run "build run"))

(define-key gradle-mode-map (kbd "C-c C-r") 'build-and-run)
(require 'company)
(global-company-mode t)
  (require 'company-emacs-eclim)
  (company-emacs-eclim-setup)
(global-set-key "\M-," 'hippie-expand)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(require 'flycheck)

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

(setq-default flycheck-flake8-maximum-line-length 99)
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(setq-default flycheck-temp-prefix ".flycheck")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package py-autopep8 elpy helm-projectile projectile magit flycheck helm-flycheck flycheck-apertium web-beautify json-mode avy-flycheck tide js2-mode latex-preview-pane ztree company-emacs-eclim company gradle-mode eclim monokai-theme helm-ls-git helm-swoop helm)))
 '(send-mail-function (quote smtpmail-send-it)))

;;change location of temp files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

;;magit
(global-set-key (kbd "C-x g") 'magit-status)

;;Open TODO
(global-set-key (kbd "C-c t") (lambda() (interactive)(find-file "~/todo.org")))
(setq TeX-parse-self t) ; Enable parse on load.
(setq TeX-auto-save t) ; Enable parse on save.	
(setq-default TeX-master nil)

(server-start)
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))
(defun my-mail-mode-hook ()
     (auto-fill-mode 1)
     (abbrev-mode 1)
     (local-set-key "\C-Xk" '(lambda ()
         (interactive)
         (save-buffer)
         (server-edit))))
   (add-hook 'mail-mode-hook 'my-mail-mode-hook)
