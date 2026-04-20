{ self, ...}: 
{
  flake.nixosModules.files = {pkgs, config, ...}:
  let
    user = config.preferences.user.name;
  in  {
    imports = [
      self.nixosModules.env
    ];

    home-manager.users.${user} = {
      home.packages = with pkgs; [
       # --- Files interactions ---
        dua # Interactive disk usage analyzer
        dust # Modern du replacement with colors
        eza # Modern ls replacement
        file # Determine file types
        gawk # GNU's awk
        lsof # Tool to list open files
        ncdu # NCurses disk usage analyzer
        p7zip # 7-Zip archiver
        rar # RAR archives
        unzip # Extract ZIP archives
        zip # Create ZIP archives
        zstd # Compression algorithm (optional Emacs dep) 
        fd # Better find
        jq # JSON processor
        ripgrep # Silver searcher plus grep
        ripgrep-all # Ripgrep for extended file types
        sd # Better sed
        yq # Command-line YAML, JSON, XML, and TOML processor
        fselect # Find files with SQL-like queries
        plocate # A much faster locate
        repgrep # Interactive find & replace within files
        sd # Sed alternative
        filezilla
        celeste
        thunar
        thunar-volman
        thunar-archive-plugin
        kdePackages.dolphin
        kdePackages.dolphin-plugins
        glow
        desktop-file-utils # Command line utilities for working with .desktop files
        most # Pager
        less # Pager
        miller # Like awk, sed, cut, join, and sort for data formats such as CSV, TSV, JSON,etc
        tree # Produce an indented directory tree view
        broot # Interactive tree view
        rich-cli # CLI for Python's rich
        csvkit # Toolkit for tabular file processing
        xlsx2csv # Lightweight toolkit for tabular file processing
        duckdb # Embeddable SQL OLAP database (required for yazi duckdb plugin)
        ranger # VIM-inspired file manager
        xplr # Hackable, minimal file explorer
        visidata # Terminal spreadsheet multitool for tabular data
      ];

      # --- Search Utils ---
      ## Atuin
      programs.atuin = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
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
      
      ### Eza & fzf
      programs.eza.enable = true;
      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;

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
      
      ### Others ...
      programs.jq.enable = true;
      programs.ripgrep.enable = true;
      programs.mcfly = {
        enable = true;
        fzf.enable = true;
      };
      programs.skim = {
        enable = true;
      };
      
      programs.television = {
        enable = true;

        enableZshIntegration = true;
        enableBashIntegration = true;
        enableFishIntegration = true;

        # Settings
        settings = {
          tick_rate = 30;

          ui = {
            ui_scale = 100;
            layout = "landscape";
            input_bar_position = "top";
            theme = "kanso";

            preview_panel = {
              size = 50;
              scrollbar = true;
            };

            status_bar = {
              separator_open = "▐";
              separator_close = "▌";
            };

            features = {
              preview_panel = {
                enabled = true;
                visible = true;
              };
              remote_control = {
                enabled = true;
                visible = false;
              };
              help_panel = {
                enabled = true;
                visible = false;
              };
              status_bar = {
                enabled = true;
                visible = true;
              };
            };
          };

          # Binds (format: key = "action")
          keybindings = {
            # Navigation
            down = "select_next_entry";
            "ctrl-j" = "select_next_entry";
            up = "select_prev_entry";
            "ctrl-k" = "select_prev_entry";
            # Selection
            enter = "confirm_selection";
            "ctrl-y" = "copy_entry_to_clipboard";
            # Toggles
            "ctrl-p" = "toggle_preview";
            "ctrl-r" = "toggle_remote_control";
            "?" = "toggle_help";
          };
        };
      };
    };
  };
}
