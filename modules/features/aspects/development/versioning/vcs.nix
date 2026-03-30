{ self, lib, ... }: {
  flake.nixosModules.vcs = { pkgs, config, ... }: let
    user = config.preferences.user.name;
    difft = lib.getExe pkgs.difftastic;
  in {
    home-manager.users.${user} = {
      
      home.packages = with pkgs; [
        delta
        diff-so-fancy
        git-extras
        commitizen # Commit rules for projects
        serie # Rich TUI commit graph
        tig # Text-mode interface for git
      ];

      # ==========================================
      # Git Configuration
      # ==========================================
      programs.git = {
        enable = true;
        
        # Globally ignored files 
        ignores = [
          # Editor files
          "*~"
          "*.swp"
          "*.swo"
          ".vscode/"
          ".idea/"

          # OS files
          ".DS_Store"
          "Thumbs.db"

          # Build artifacts
          "*.o"
          "*.so"
          "*.a"
          "*.out"

          # Logs
          "*.log"

          # Temporary & Tool files
          "*.tmp"
          "*.bak"
          ".cache/"
          ".jj/"
          ".direnv/"
        ];

        settings = {
          user = {
            name = "Abdellah Azarfane";
            email = "abdellahazarfane@proton.me";
          };

          alias = {
            a = "add";
            aa = "add --update";
            aaa = "add --all";
            ap = "add --patch";
            aar = "!git aa && git ar";
            aaar = "!git aaa && git ar";
            ar = "commit --amend --reset-author --verbose";
            c = "commit --verbose";
            ca = "commit --all --verbose";
            bl = "blame";
            br = "branch --verbose";
            co = "checkout";
            cob = "checkout -b";
            d = "diff";
            ds = "diff --staged";
            f = "fetch --all --prune";
            g = "grep";
            hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
            l = "!git --no-pager log -20 --pretty='format:%C(yellow)%h %C(green)%ai %C(bold blue)%an %C(red)%d%C(reset) %s'; echo";
            lg = "log --graph --pretty='format:%C(yellow)%h %C(green)%ai %C(bold blue)%an %C(red)%d%C(reset) %s %Cgreen(%cr)'";
            p = "push";
            pl = "pull --rebase=merges --autostash --stat --prune";
            r = "reset";
            rb = "rebase --rebase-merges";
            s = "status --short --branch";
            sw = "show --format=fuller --show-signature";
            undo = "!git reset --soft HEAD^ && git reset";
            wip = "!git add --all && git commit -m 'WIP'";
          };

          pull.rebase = true;
          core = {
            whitespace = "trailing-space,space-before-tab";
            editor = "nvim";
          };
          init.defaultBranch = "main";
          color = {
            ui = true;
            branch = "auto";
            interactive = "auto";
            pager = true;
          };
          pager = {
            show = "diff-so-fancy | less --tabs=1,5 -RFX";
            diff = "diff-so-fancy | less --tabs=4 -RFXS --pattern '^(Date|added|deleted|modified): '";
          };
          commit.gpgsign = true;
          diff = {
            renames = "copies";
            renameLimit = 10000;
          };
          fetch.prune = true;
          gc.autoDetach = false;
          status.submoduleSummary = true;
          push = {
            default = "current";
            recurseSubmodules = "check";
          };
          rebase.autoStash = true;
          "merge-tools.meld" = {
            "merge-args" = [ "$left" "$base" "$right" "-o" "$output" "--auto-merge" ];
          };
          credential.helper = "cache --timeout=0";
          "git-edit-index".onEmptyBuffer = "act";
          cola = {
            startupmode = "list";
            spellcheck = false;
            statusshowtotals = true;
          };
        };
      };

      # ==========================================
      # Delta 
      # ==========================================
      programs.delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          plus-color = "#012800";
          minus-color = "#340001";
          syntax-theme = "Monokai Extended";
        };
      };

      # ==========================================
      # Lazygit Configuration
      # ==========================================
      programs.lazygit = {
        enable = true;
        settings = {
          git = {
            pagers = [
              { colorArg = "always"; pager = "${difft}"; }
              { colorArg = "always"; pager = "delta --dark --paging=never"; }
            ];
          };
          gui = {
            branchColors = { "docs" = "#11aaff"; };
          };
          os = {
            open = "nvim";
            editPreset = "nvim";
          };
          keybinding = {
            commits = { renameCommit = "R"; renameCommitWithEditor = "r"; };
            files = { commitChanges = "C"; commitChangesWithEditor = "c"; };
          };
          notARepository = "skip";
          customCommands = [
            {
              key = "f";
              command = "git difftool -y {{.SelectedLocalCommit.Sha}} -- {{.SelectedCommitFile.Name}}";
              context = "commitFiles";
              description = "Compare (difftool) with local copy";
            }
          ];
        };
      };

      # ==========================================
      # GitHub CLI & Dash
      # ==========================================
      programs.gh = {
        enable = true;
        settings = {
          git_protocol = "ssh";
          prompt = "enabled";
          aliases = {
            pc = "pr checkout";
            pv = "pr view";
          };
        };
      };

      programs.gh-dash = {
        enable = true;
        settings = {
          prSections = [
            { title = "My Pull Requests"; filters = "is:open author:@me sort:updated-desc"; }
          ];
        };
      };

      # ==========================================
      # Misc VCS Tools
      # ==========================================
      programs.gitui.enable = true;
      programs.difftastic.enable = true;

      programs.mergiraf = {
        enable = true;
        enableGitIntegration = true;
      };

      programs.lazyworktree = {
        enable = true;
      };
      
    };
  };
}