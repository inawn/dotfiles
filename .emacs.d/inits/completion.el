;;helm
(require 'cl-lib)
(require 'helm-config)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(setq helm-idle-delay             0.3
      helm-input-idle-delay       0.3
                                        ;        helm-exit-idle-delay 0
      helm-candidate-number-limit 1000
      helm-maybe-use-default-as-input t
      helm-c-locate-command "locate-with-mdfind %.0s %s"
      helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t)
(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))
;; Unset key C-h to use normal C-h
(add-hook 'helm-before-initialize-hook
          '(lambda ()
             (define-key helm-map (kbd "C-h") nil)))
(eval-after-load 'helm
  '(progn
     (define-key helm-map (kbd "C-h") 'delete-backward-char)
     ; available option: 'same, 'other,'right, 'left, 'below, 'above
     (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
     (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
     (define-key helm-map (kbd "C-z") 'helm-select-action)
     (defconst helm-split-window-default-side 'other)
     ))
(helm-mode t)
;;[Display not ready]
(defun my/helm-exit-minibuffer ()
  (interactive)
  (helm-exit-minibuffer))
(eval-after-load "helm"
  '(progn
     (define-key helm-map (kbd "<RET>") 'my/helm-exit-minibuffer)))

;; auto completion like IntelliSense
(require 'popup)
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "TAB")
(setq ac-auto-show-menu 0.5)
(setq ac-use-menu-map t)
(add-to-list 'ac-modes 'c-mode)
(defvar my-ac-sources
  '(ac-source-yasnippet
    ac-source-abbrev
    ac-source-dictionary
    ac-source-words-in-same-mode-buffers))
(defun ac-c-mode-setup ()
  (setq-default ac-sources my-ac-sources))
(add-hook 'c-mode-hook 'ac-c-mode-setup)
(eval-after-load 'auto-complete
  '(progn
     (define-key ac-complete-mode-map "\C-n" 'ac-next)
     (define-key ac-complete-mode-map "\C-p" 'ac-previous)
     ;;(add-to-list 'ac-sources 'ac-source-yasnippet)
     ;;complete from some other source
     ;;(save-excursion )tq ac-sources(whichis buffer-local var) "pre-defined symbbol"
     ;;ex.complete Emacs Lisp symbol in emacs-lisp-mode
     (defun emacs-lisp-ac-setup ()
       (setq ac-sources
             '(ac-source-words-in-same-mode-buffers
               ac-source-symbols)))
     (add-hook 'emacs-lisp-mode-hook 'emacs-lisp-ac-setup)))
(global-auto-complete-mode t)
;; avoid yasnippet key-binding error
(setf (symbol-function 'yas-active-keys)
      (lambda ()
        (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))
(bundle! auto-complete-latex)

; yasnippet
(require 'dropdown-list)
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"                 ; personal
        "~/.emacs.d/el-get/yasnippet/snippets" ; default
        "~/.emacs.d/el-get/yasnippet/yasmate/snippets" ; yasmate
        ))
(yas-global-mode 1)
;  (custom-set-variables '(yas-trigger-key "TAB"))
(eval-after-load 'yasnippet
  '(progn
     (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
     (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
     ;; 既存スニペットを閲覧・編集
     ;; yas-visit-snippet-file関数中の(yas-prompt-functions '(yas-ido-prompt yas-completing-prompt))をコメントアウト
     (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
     (define-key yas-minor-mode-map (kbd "M-i") 'yas-expand)))
(eval-after-load 'helm
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (helm-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*helm yas/prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))))
;; snippet-mode for *.yasnippet files
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))

; zsh like completion
(setq read-file-name-completion-ignore-case t)
(require 'zlc)
(zlc-mode t)
(let ((map minibuffer-local-map))
  (define-key map (kbd "C-p") 'zlc-select-previous)
  (define-key map (kbd "C-n") 'zlc-select-next)
  (define-key map (kbd "<up>") 'zlc-select-previous-vertical)
  (define-key map (kbd "<down>") 'zlc-select-next-vertical)
  (define-key map (kbd "C-u") 'backward-kill-path-element))
