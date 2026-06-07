{
  flake.nixosModules.emacs = { pkgs, config, ... }:
let
  user = config.preferences.user.name;

  doomWrapper = pkgs.writeShellApplication {
    name = "doom";
    runtimeInputs = with pkgs; [
      git
      emacs-pgtk
      ripgrep
      fd
    ];
    text = ''
      export DOOMDIR="$HOME/.config/doom"
      export EMACSDIR="$HOME/.config/emacs"

      # If the Doom engine doesn't exist yet, clone it automatically
      if [ ! -d "$EMACSDIR" ]; then
        echo "🚀 Doom Emacs engine not found. Bootstrapping..."
        git clone --depth 1 https://github.com/doomemacs/doomemacs "$EMACSDIR"
        "$EMACSDIR/bin/doom" install --no-env --no-fonts
      else
        # Pass any arguments directly to the doom binary
        "$EMACSDIR/bin/doom" "$@"
      fi
    '';
  };

in {
  environment.systemPackages = [
    pkgs.emacs-pgtk # Native Wayland supportse
    doomWrapper
  ];
   home-manager.users.${user} = {
     programs.emacs = {
       enable = true;
       package = pkgs.emacs-pgtk;
     };
     xdg.configFile = {
             # --- init.el ---
             "doom/init.el".text = ''
               (doom! :input
                      :completion
                      company           ; the standard completion engine
                      vertico           ; the search engine of the future
                      :ui
                      doom              ; what makes DOOM look the way it does
                      doom-dashboard    ; a nifty splash screen for Emacs
                      doom-quit         ; DOOM quit-message prompts when you quit
                      hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
                      modeline          ; snazzy, Atom-inspired modeline
                      treemacs          ; a project drawer, like neotree but cooler
                      window-select     ; visually switch windows
                      :editor
                      (evil +everywhere); come to the dark side, we have cookies
                      file-templates    ; auto-snippets for empty files
                      fold              ; (n)vim C-f/C-b style folding
                      snippets          ; my elves. They type so I don't have to
                      :emacs
                      dired             ; making dired pretty [functional]
                      electric          ; smarter, keyword-based electric-indent
                      vc                ; version-control and file-classes
                      :term
                      vterm             ; the best terminal emulation in Emacs
                      :checkers
                      syntax            ; tfly checking, requires flycheck
                      :tools
                      eval              ; run code, run (also, repls)
                      lookup            ; navigate your code and its documentation
                      magit             ; a git porcelain to rest my aches
                      :lang
                      (org              ; Your ultimate knowledge/task center
                       +journal
                       +pomodoro
                       +roam2)
                      sh                ; POSIX shell
                      nix               ; Nix language support
                      :config
                      (default +bindings +smartparens))
             '';

             # --- packages.el ---
             "doom/packages.el".text = ''
               ;; Install org-super-agenda for advanced Taskwarrior-like layouts
               (package! org-super-agenda)
             '';

             # --- config.el ---
             "doom/config.el".text = ''
               ;; ============================================================================
               ;; Core Identity & Theming
               ;; ============================================================================
               (setq user-full-name "abosafiya"
                     user-mail-address "abdellahazarfane@proton.me")

               (setq doom-theme 'doom-gruvbox) ;; Matches your system vibe
               (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

               ;; ============================================================================
               ;; Org Core Settings (Replacing Obsidian, Joplin, Taskwarrior)
               ;; ============================================================================
               (setq org-directory "~/documents/org/")
               (setq org-agenda-files (directory-files-recursively "~/documents/org/" "\\.org$"))

               ;; Standard task states
               (setq org-todo-keywords
                     '((sequence "TODO(t)" "NEXT(n)" "IN_PROGRESS(p)" "|" "DONE(d)" "CANCELLED(c)")))

               ;; ============================================================================
               ;; Org Capture Templates (For Quick Notes & Tasks)
               ;; ============================================================================
               (setq org-capture-templates
                     '(("t" "Todo Task" entry (file+headline "~/documents/org/tasks.org" "Inbox")
                        "* TODO %?\n  Created: %U\n  %i")
                       ("n" "Quick Note" entry (file+headline "~/documents/org/notes.org" "Quick Notes")
                        "* %^{Title}\n  Date: %U\n\n  %?")))

               ;; ============================================================================
               ;; Org Pomodoro Settings
               ;; ============================================================================
               (after! org-pomodoro
                 (setq org-pomodoro-length 25
                       org-pomodoro-short-break-length 5
                       org-pomodoro-long-break-length 15))

               ;; ============================================================================
               ;; Custom Keybindings (Space + o prefix)
               ;; ============================================================================
               (map! :leader
                     (:prefix-map ("o" . "open")
                      :desc "Org Agenda Layout"        "a" #'org-agenda
                      :desc "Org Capture Template"     "c" #'org-capture
                      :desc "Start Pomodoro Timer"     "p" #'org-pomodoro))
             '';
           };
     services.emacs = {
       enable = true;
       client.enable = true;
     };
   };
  };
 }
