{ self, lib, ... }: {
  flake.nixosModules.zsh = { pkgs, config, ... }: let
    user = config.preferences.user.name;
  in {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    home-manager.users.${user} = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autocd = true;
        
        autosuggestion = {
          enable = true;
          strategy = [ "completion" "history" ];
        };

        # From shells2/zsh.nix
        oh-my-zsh = {
          enable = true;
          plugins = [ "fzf" "git" "sudo" "vi-mode" "last-working-dir" "dotenv" "extract" ];
        };

        syntaxHighlighting = {
          enable = true;
          highlighters = [ "main" "brackets" "pattern" "regexp" "root" "line" ];
        };

        initContent = ''
          # fzf-tab configuration
          zstyle ':completion:*:git-checkout:*' sort false
          zstyle ':completion:*:descriptions' format '[%d]'
          zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
          zstyle ':completion:*' menu no
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
          zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
          zstyle ':fzf-tab:*' switch-group '<' '>'

          # lf wrapper
          lf() { cd "$(command lf -print-last-dir "$@")" }
          
          # From shells2/zsh.nix: Colourful sparklines
          function print_terminal_line_sparklines {
            seq 1 $(tput cols) | sort -R | ${lib.getExe pkgs.python3Packages.sparklines} | ${lib.getExe pkgs.lolcat}
          }
        '';
      };
    };
  };
}