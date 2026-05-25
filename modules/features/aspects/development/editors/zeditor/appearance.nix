{
  flake.nixosModules.zedappearance = { pkgs, config, inputs, lib,... }: let
    user = config.preferences.user.name;
  in {
    home-manager.users.${user} = {
      programs.zed-editor = {
        userSettings = {
          buffer_font_family = "JetBrainsMono Nerd Font";
          syntax = {
            comment.font_style = "italic";
            "comment.doc".font_style = "italic";
          };
          theme = {
            mode = "system";
            light = "Dayfox - opaque";
            dark = "Carbonfox - opaque";
          };
          icon_theme = "Catppuccin Latte";
          show_whitespaces = "all";
          buffer_font_size = 15;
          buffer_font_weight = 300;
          buffer_line_height = "comfortable";
          current_line_highlight = "all";
          selection_highlight = true;
          ui_font_family = "Work Sans";
          ui_font_size = 15;
          ui_font_weight = 400;

          # --- Gutter ---
          gutter = {
            breakpoints = true;
            code_actions = true;
            folds = true;
            line_numbers = true;
            runnables = true;
          };

          # --- Indent Guides ---
          indent_guides = {
            active_line_width = 1;
            background_coloring = "enabled";
            coloring = "fixed";
            enabled = true;
            line_width = 1;
          };

          # --- Scrollbar ---
          scrollbar = {
            axes = {
              horizontal = true;
              vertical = true;
            };
            cursors = true;
            diagnostics = "all";
            git_diff = true;
            search_results = true;
            selected_symbol = true;
            selected_text = true;
            show = "auto";
          };

          # --- Title Bar ---
          title_bar = {
            show_branch_icon = false;
            show_onboarding_banner = true;
            show_user_picture = true;
          };

          # --- Toolbar ---
          toolbar = {
            agent_review = false;
            breadcrumbs = true;
            quick_actions = true;
            selections_menu = true;
          };
        };
      };
    };
  };
}
