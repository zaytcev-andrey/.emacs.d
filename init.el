;; Add and enable MELPA
(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; add your modules path
(add-to-list 'load-path "~/.emacs.d/custom/")

(require 'volatile-highlights)
(volatile-highlights-mode t)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-width 40)
(add-hook 'emacs-startup-hook 
    (lambda ()
    (sr-speedbar-open) ) )

(require 'highlight-symbol)
(highlight-symbol-nav-mode)

(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

(setq highlight-symbol-idle-delay 0.2
      highlight-symbol-on-navigation-p t)

(global-set-key [(control shift mouse-1)]
                (lambda (event)
                  (interactive "e")
                  (goto-char (posn-point (event-start event)))
                  (highlight-symbol-at-point)))

(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)

;; GROUP: Editing -> Editing Basics
(setq global-mark-ring-max 5000         ; increase mark ring to contains 5000 entries
      mark-ring-max 5000                ; increase kill ring to contains 5000 entries
      mode-require-final-newline t      ; add a newline to end of file
      )

;; default to 4 visible spaces to display a tab
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(global-linum-mode t)

;; GROUP: Editing -> Killing
(setq
      kill-ring-max 5000 ; increase kill-ring capacity
      kill-whole-line t  ; if NIL, kill whole line and move the next line up
      )

;; show important whitespace in diff-mode
(add-hook 'diff-mode-hook (lambda ()
                            (setq-local whitespace-style
                                        '(face
                                          tabs
                                          tab-mark
                                          spaces
                                          space-mark
                                          trailing
                                          indentation::space
                                          indentation::tab
                                          newline
                                          newline-mark))
                            (whitespace-mode 1)))

(add-hook 'c-mode-common-hook
    (lambda ()
      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
  (ggtags-mode 1))))

(add-hook 'dired-mode-hook 'ggtags-mode)

(setq-local imenu-create-index-function #'ggtags-build-imenu-index)
