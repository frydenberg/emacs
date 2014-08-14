(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bookmark-save-flag 1)
 '(column-number-mode t)
 '(company-dabbrev-code-time-limit 0.05)
 '(company-frontends (quote (company-pseudo-tooltip-frontend company-echo-metadata-frontend)))
 '(company-idle-delay 0.1)
 '(cua-mode t nil (cua-base))
 '(dired-dwim-target t)
 '(display-battery-mode t)
 '(erc-hide-list (quote ("JOIN" "KICK" "PART" "QUIT")))
 '(flycheck-csharp-omnisharp-curl-executable "curl")
 '(font-lock-global-modes (quote (not speedbar-mode)))
 '(font-use-system-font t)
 '(global-company-mode t)
 '(magit-git-executable "git.exe")
 '(max-specpdl-size 3000)
 '(omnisharp-timeout 1)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote bottom)))
 
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




(setq mouse-wheel-scroll-amount '(4 ((shift) . 1) ((control) . nil))) 
(setq mouse-wheel-progressive-speed nil)
(global-set-key [f5] 'compile)

;;package handling
(require 'package)
;;;adding the melpa archive
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;;Adding marmalade repo !This rep is often not working, making emacs hang on boot and list-package
;; (add-to-list 'package-archives 
;;     '("marmalade" .
;;       "http://marmalade-repo.org/packages/"))
;;init package manager
(package-initialize)
;;refresh the list of packages
(package-refresh-contents)


;company mode
(add-hook 'after-init-hook 'global-company-mode)
(global-set-key [C-tab] 'company-complete)
(setq company-idle-delay 0.1)

;load ace jump when used.
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;make ace jump case insensitive
(setq ace-jump-mode-case-fold t)
;;keybinding for ace jump
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(setq ace-jump-mode-submode-list
	'(ace-jump-word-mode
	  ace-jump-char-mode
	  ace-jump-line-mode))

;ace jump buffer mode
(require 'ace-jump-buffer) 
(define-key global-map (kbd "C-c b") 'ace-jump-buffer)


;Get rid of yes-no questions
(defalias 'yes-or-no-p 'y-or-n-p)

;Get rid of scrollbar
;(scroll-bar-mode -1)

;; Global line numbers
(global-nlinum-mode t)


;; Enable winner mode for easy window restore
(winner-mode 1)

;; Enable Powerline
(powerline-vim-theme)

;; Enable Undo Tree
(global-undo-tree-mode)

;; Enable window numbering mode. Switch windows with M-1 M-2 M-3 etc.
(window-numbering-mode t)


;;Expand region
(require 'expand-region)
    (global-set-key (kbd "C-=") 'er/expand-region)

;; Compilation output scroll
(setq compilation-scroll-output t)


;;Globally enable ido mode
;;Really enable ido everywhere :D
(ido-ubiquitous)
(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;;try out the ido-vertical mode
(require 'ido-vertical-mode)
(ido-vertical-mode 1)


;;load wombat theme
(load-theme 'wombat t)


;;SMEX. Used for ido completion when executing commands
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;;enable yas
(yas-global-mode 1)

;;Omnisharp setup
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-omnisharp))

(server-start)

;;Add to webjumps
(global-set-key (kbd "C-x j") 'webjump)
(eval-after-load "webjump"
'(add-to-list 'webjump-sites
              '("Unity scripting reference" .
                [simple-query
                 "http://docs.unity3d.com/"
                 "http://docs.unity3d.com/Documentation/ScriptReference/30_search.html?q="
                 ""])))

;;Keep a list of recently opened files
(recentf-mode 1)

(require 'tramp)

(if (eq system-type 'windows-nt)
      (set-default 'tramp-default-method "plink")
 )


;; Shift enter will now do:
;; go to end of line
;; make new line
;; indent
(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(global-set-key (kbd "<S-return>") 'end-of-line-and-indented-new-line)

;; collapse white lines!
(defun collapse-blank-lines (start end)
  (interactive "r")
  (replace-regexp "^\n\\{2,\\}" "\n" nil start end))


;; make cursor movement keys under right hand's home-row.
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-k") 'next-line)
(global-set-key (kbd "M-l") 'forward-char)

(global-set-key (kbd "M-u") 'backward-word)
(global-set-key (kbd "M-o") 'forward-word)

;;org mode keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;Enable eldoc mode
(add-hook 'csharp-mode-hook 'turn-on-eldoc-mode)

;; Backwards kill word
(global-set-key "\C-w" 'backward-kill-word)

;;Disable cursor blink
(blink-cursor-mode 0)

;;Automaticly refresh buffer if file has changed on disc.
;;Since we might change files in a Unity project from outside emacs, this is very usefull.
(global-auto-revert-mode 1)

;;The standard comment function was never helpful :(
;;This taken from http://www.emacswiki.org/emacs/CommentingCode
;;is so much better!!!
(defun comment-eclipse ()
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (comment-or-uncomment-region start end)))

(global-set-key "\M-;" 'comment-eclipse)

;;Flycheck stuff
(global-flycheck-mode)
(require 'flycheck-tip)
;;Show flycheck errors in a popup instead of echo area
(flycheck-tip-use-timer 'verbose)
