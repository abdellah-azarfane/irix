{ self, ... }:
{
  flake.nixosModules.files =
    { pkgs, config, ... }:
    let
      user = config.preferences.user.name;
    in
    {
      imports = [
        self.nixosModules.env
      ];
      home-manager.users.${user} = {
        home.packages = with pkgs;
        [
          # --- File & Archive Interactions ---
          dust # Modern du replacement with colors
          eza # Modern ls replacement
          file # Determine file types
          lsof # Tool to list open files
          p7zip # 7-Zip archiver
          rar
          # RAR archives
          unzip # Extract ZIP archives
          zip # Create ZIP archives
          zstd # Compression algorithm

          # --- Text & Data Processing ---
          gawk # GNU awk
          jq # JSON processor
          yq # Command-line YAML, JSON, XML, and TOML processor
          sd # Better sed
          miller # Like awk, sed, cut, join, and sort for data formats
          visidata # Terminal spreadsheet multitool for tabular data

          # --- Search & Navigation ---
          fd # Better find
          ripgrep # Silver searcher plus grep
          ripgrep-all # Ripgrep for extended file types
          plocate # A much faster locate
          repgrep # Interactive find & replace within files
          broot # Interactive tree view

          # --- Utilities & Viewers ---
          duckdb # Embeddable SQL OLAP database (required for yazi duckdb plugin)
          thunar
          thunar-volman
          thunar-archive-plugin
          glow # Markdown renderer
          desktop-file-utils # Command line utilities for working with .desktop files
          less # Pager
        ];

        # ==========================================
        # Search & History TUIs
        # ==========================================

        ## Atuin (Shell History Tracker)
        programs.atuin = {
          enable = true;
          enableFishIntegration = true;
          settings = {
            auto_sync = false;
            sync_enabled = false;
            search_mode = "fuzzy";
            filter_mode = "global";
            style = "full";
            show_preview = true;
            show_help = false;
            show_tabs = true;
            inline_height = 25;
            max_preview_height = 10;
            keymap_mode = "vim-insert";
            invert = false;
            enter_accept = false;
            exit_mode = "return-original";
          };
        };

        ## FZF (Global Fuzzy Finder)
        programs.fzf = {
          enable = true;
          enableBashIntegration = true;

          # Disable fzf's Ctrl-R history widget so Atuin can take priority without collision
          historyWidget.command = "";

          # Default command for file finding
          defaultCommand = "fd --type f --strip-cwd-prefix";

          # Default options applied to all fzf invocations
          defaultOptions = [
            "--preview-window=right:50%:wrap"
            "--color=bg+:-1,bg:-1,border:240,spinner:108,hl:108,fg:252,header:108,info:108,pointer:161,marker:161,fg+:252,prompt:161,hl+:161"
            "--border=sharp"
            "--margin=1"
            "--padding=1"
          ];

          # Custom color scheme
          colors = {
            "bg+" = "-1";
            "bg" = "-1";
            "border" = "240";
            "spinner" = "108";
            "hl" = "108";
            "fg" = "252";
            "header" = "108";
            "info" = "108";
            "pointer" = "161";
            "marker" = "161";
            "fg+" = "252";
            "prompt" = "161";
            "hl+" = "161";
          };
        };
      };
    };
}
