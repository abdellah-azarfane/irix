{lib, ...}: {
  flake.nixosModules.docs = {pkgs, config, ...}: let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = with pkgs; [
      # --- PDF & Research Workhorses ---
      zathura # The ultimate minimalist PDF viewer
      pandoc  # The backbone of your academic writing workflow

      # --- CLI PDF Tools ---
      qpdf     # Better than Stirling-PDF for command-line manipulation
      pdftk    # Essential for splitting/merging PDFs
      # E-book
      koreader
      hunspell
      hunspellDicts.fr-any
      languagetool
    ];

    home-manager.users.${user} = {
      xdg.configFile."zathura/zathurarc".text = let
        options = {
        # --- Performance ---
        render-loading = true;
        render-loading-bg = "#1a1a2e";
        render-loading-fg = "#c8c8d0";
        page-cache-size = 50;
        pages-per-row = 1;
        scroll-page-aware = true;
        scroll-full-overlap = "0.01";
        scroll-step = 100;

        # --- UI & Appearance ---
        font = "JetBrainsMono Nerd Font 11";
        statusbar-home-tilde = true;
        window-title-home-tilde = true;
        window-title-basename = true;
        guioptions = "shv";

        # --- Search ---
        incremental-search = true;
        nohlsearch = false;

        # --- Clipboard ---
        selection-clipboard = "clipboard";
        selection-notification = true;

        # --- Zoom ---
        zoom-min = 10;
        zoom-max = 1000;
        zoom-step = 10;
        adjust-open = "best-fit";

        # --- Colors ---
        default-bg = "#1a1a2e";
        default-fg = "#c8c8d0";
        statusbar-bg = "#141420";
        statusbar-fg = "#c8c8d0";
        inputbar-bg = "#1a1a2e";
        inputbar-fg = "#c8c8d0";
        notification-bg = "#1a1a2e";
        notification-fg = "#87a987";
        notification-error-bg = "#1a1a2e";
        notification-error-fg = "#c4746e";
        notification-warning-bg = "#1a1a2e";
        notification-warning-fg = "#c4b28a";
        highlight-color = "#c4b28a";
        highlight-active-color = "#87a987";
        completion-bg = "#141420";
        completion-fg = "#c8c8d0";
        completion-highlight-bg = "#8ba4b0";
        completion-highlight-fg = "#1a1a2e";
        completion-group-bg = "#141420";
        completion-group-fg = "#8ba4b0";
        index-bg = "#1a1a2e";
        index-fg = "#c8c8d0";
        index-active-bg = "#8ba4b0";
        index-active-fg = "#1a1a2e";

        # --- Recolor ---
        recolor = false;
        recolor-keephue = true;
        recolor-darkcolor = "#c8c8d0";
        recolor-lightcolor = "#1a1a2e";
        recolor-reverse-video = true;
      };

      mappings = {
        # Navigation
        "<C-d>" = "scroll half-down";
        "<C-u>" = "scroll half-up";
        "D" = "toggle_page_mode";
        "r" = "rotate rotate-cw";
        "R" = "rotate rotate-ccw";
        "K" = "zoom in";
        "J" = "zoom out";
        "i" = "recolor";
        "<C-r>" = "reload";
        "p" = "print";
        "b" = "toggle_statusbar";
        "<C-c>" = "abort";

        # Bookmarks
        "m" = "mark_evaluate";
        "'" = "mark_evaluate";

        # Index
        "<Tab>" = "toggle_index";
      };

      # Generate the config blocks
      genOpts =
        lib.concatStringsSep "\n"
        (lib.mapAttrsToList (k: v: "set ${k} ${builtins.toJSON v}") options);

        genMaps =
          lib.concatStringsSep "\n"
          (lib.mapAttrsToList (k: v: "map ${k} ${v}") mappings);
      in ''
        # --- Zathura Options ---
        ${genOpts}

        # --- Zathura Key Mappings ---
        ${genMaps}

        # --- Additional Settings ---
        set database sqlite
        set sandbox normal
        set page-padding 2
        set show-recent 20
        set first-page-column 1
      '';
    };
  };
}
