(setq user-full-name "Azarfane Abdellah"
      user-mail-address "abdellahazrfane@proton.me")

(setq display-line-numbers-type t)   ;; Turn line numbers on
(setq confirm-kill-emacs nil)        ;; Don't confirm on exit
(setq initial-buffer-choice 'eshell) ;; Eshell is initial buffer

;; Use bash for internal Emacs processes
(setq shell-file-name (executable-find "bash"))

;; Use your favorite shell (Fish) for the terminal emulator
(setq-default vterm-shell "/run/current-system/sw/bin/fish")
(setq-default explicit-shell-file-name "/run/current-system/sw/bin/fish")

;;(setq doom-theme 'doom-gruvbox)
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
(load-theme 'noctalia t)

;; Set default background opacity for all new frames (0-100, where 100 is fully opaque)
(add-to-list 'default-frame-alist '(alpha-background . 85))

;; Apply it immediately to the current, already-open frame
(set-frame-parameter nil 'alpha-background 85)

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

(add-hook 'server-after-make-frame-hook #'doom/reload-font)
;;(add-hook 'server-after-make-frame-hook #'doom/reload-theme)

(map! :leader
      :desc "Comment line" "-" #'comment-line)

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle eshell split"            "e" #'+eshell/toggle
       :desc "Toggle line highlight in frame" "h" #'hl-line-mode
       :desc "Toggle line highlight globally" "H" #'global-hl-line-mode
       :desc "Toggle line numbers"            "l" #'doom/toggle-line-numbers
       :desc "Toggle markdown-view-mode"      "m" #'ix/toggle-markdown-view-mode
       :desc "Toggle truncate lines"          "t" #'toggle-truncate-lines
       :desc "Toggle treemacs"                "T" #'+treemacs/toggle
       :desc "Toggle vterm split"             "v" #'+vterm/toggle))

(map! :leader
      (:prefix ("o" . "open here")
       :desc "Open eshell here"    "e" #'+eshell/here
       :desc "Open vterm here"     "v" #'+vterm/here
       :desc "Open agenda"         "a" #'org-agenda
       :desc "Quick capture"       "c" #'org-capture
       :desc "Start Pomodoro"      "p" #'org-pomodoro
       :desc "Ollama chat"         "g" #'gptel))

(setq read-process-output-max (* 3 1024 1024))   ; 3mb chunks from LSP servers
(setq gcmh-high-cons-threshold (* 64 1024 1024)) ; raise gcmh's ceiling for LSP sessions

(after! lsp-mode
  (setq lsp-clients-clangd-executable "clangd"
        lsp-clients-clangd-args
        '("-j=4"
          "--background-index"
          "--clang-tidy"
          "--completion-style=detailed"
          "--header-insertion=iwyu"
          "--pch-storage=memory")

        lsp-rust-analyzer-cargo-watch-enable t
        lsp-rust-analyzer-cargo-load-out-dirs-from-check t
        lsp-rust-analyzer-proc-macro-enable t
        lsp-rust-analyzer-display-parameter-hints t
        lsp-rust-analyzer-display-chaining-hints t

        lsp-idle-delay 0.2
        lsp-log-io nil
        lsp-headerline-breadcrumb-enable t))

(after! rustic
  (setq rustic-lsp-client 'lsp-mode
        rustic-analyzer-command '("rust-analyzer")))

;; Nix LSP via `nil` (the actively maintained server; rnix-lsp is dead).
;; Install with: environment.systemPackages = with pkgs; [ nil nixpkgs-fmt ];
(after! lsp-nix-nil
  (setq lsp-nix-nil-server-path "nil"
        lsp-nix-nil-formatter '("nixpkgs-fmt")))

(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.6))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.5))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.4))))
 '(markdown-header-face-4 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-5 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-6 ((t (:inherit markdown-header-face :height 1.1)))))

(defun ix/toggle-markdown-view-mode ()
  "Toggle between `markdown-mode' and `markdown-view-mode'."
  (interactive)
  (if (eq major-mode 'markdown-view-mode)
      (markdown-mode)
    (markdown-view-mode)))

(setq org-directory "~/documents/org/")
(setq org-agenda-files (list org-directory))
(setq org-modern-table-vertical 1)
(setq org-modern-table t)
(add-hook 'org-mode-hook #'hl-todo-mode)

(custom-theme-set-faces!
  'doom-gruvbox
  '(org-level-8 :inherit outline-3 :height 1.0)
  '(org-level-7 :inherit outline-3 :height 1.0)
  '(org-level-6 :inherit outline-3 :height 1.1)
  '(org-level-5 :inherit outline-3 :height 1.2)
  '(org-level-4 :inherit outline-3 :height 1.3)
  '(org-level-3 :inherit outline-3 :height 1.4)
  '(org-level-2 :inherit outline-2 :height 1.5)
  '(org-level-1 :inherit outline-1 :height 1.6)
  '(org-document-title  :height 1.8 :bold t :underline nil))

(setq org-todo-keywords
      '((sequence
         "TODO(t)"          ; not started
         "NEXT(n)"          ; the next actionable thing
         "IN_PROGRESS(i)"   ; actively being worked
         "|"
         "DONE(d)"
         "CANCELLED(c)")))

(setq org-todo-keyword-faces
      '(("TODO"        . (:foreground "#fb4934" :weight bold))  ; gruvbox red
        ("NEXT"        . (:foreground "#fabd2f" :weight bold))  ; gruvbox yellow
        ("IN_PROGRESS" . (:foreground "#83a598" :weight bold))  ; gruvbox blue
        ("DONE"        . (:foreground "#b8bb26" :weight bold))  ; gruvbox green
        ("CANCELLED"   . (:foreground "#928374" :weight bold)))) ; gruvbox gray

(setq org-capture-templates
      '(("t" "Task" entry (file+headline "inbox.org" "Inbox")
         "* TODO %?\n%i\n%a" :prepend t)
        ("n" "Quick note" entry (file+headline "inbox.org" "Notes")
         "* %?\n%U\n%i" :prepend t)
        ("j" "Journal" entry (file+olp+datetree "journal.org")
         "* %U %?\n%i")))

(after! org-roam
  (setq org-roam-directory (concat org-directory "roam/")
        org-roam-dailies-directory "journal/"
        org-roam-completion-everywhere t
        org-roam-capture-templates
        '(("d" "default" plain "%?"
           :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: :\n")
           :unnarrowed t))
        org-roam-dailies-capture-templates
        '(("d" "default" entry "* %?"
           :target (file+head "%<%Y-%m-%d>.org"
                              "#+title: %<%Y-%m-%d>\n")))))

(after! org-pomodoro
  (setq org-pomodoro-length 120
        org-pomodoro-short-break-length 10
        org-pomodoro-long-break-length 30))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-super-agenda-groups
        '((:name "In progress" :todo "IN_PROGRESS")
          (:name "Next up" :todo "NEXT")
          (:name "Overdue" :deadline past)
          (:name "Due soon" :deadline future)
          (:name "Tasks" :todo "TODO")))
  :config
  (org-super-agenda-mode))

(after! gptel
  (setq gptel-model 'qwen2.5-coder:14b   ; swap for whatever you've `ollama pull`ed
        gptel-backend
        (gptel-make-ollama "Ollama"
          :host "localhost:11434"
          :stream t
          :models '(qwen2.5-coder:14b llama3.2:latest deepseek-coder-v2:latest))))
