{
  self,
  inputs,
  ...
}:
{
  perSystem =
    {
      pkgs,
      self',
      ...
    }:
    {
      # Alias for convenience
      packages.terminal = self'.packages.kitty;

      packages.kitty =
        (self.lib.wrapperModules.kitty.apply {
          inherit pkgs;

          # --- Developer Mode Toggle ---
          devMode = false;
          #  devSessionPath = pkgs.writeText "kitty-dev-session.conf" ''
          #   '';

          settings = {
            # --- Performance & Feedback ---
            enable_audio_bell = "no";
            font_size = 15;
            font_family = "JetBrainsMono Nerd Font";
            cursor_trail = 3;

            # --- Development & IPC ---
            allow_remote_control = "yes";
            listen_on = "unix:/tmp/kitty";
            shell_integration = "enabled";
            allow_hyperlinks = "yes";

            # --- Visuals ---
            background_opacity = "0.85";
            dynamic_background_opacity = "yes";
            cursor_text_color = "background";

            # --- Keybinds ---
            map = [
              "alt+1 goto_tab 1"
              "alt+2 goto_tab 2"
              "alt+3 goto_tab 3"
              "alt+4 goto_tab 4"
              "alt+5 goto_tab 5"
              "alt+6 goto_tab 6"
              "alt+7 goto_tab 7"
              "alt+8 goto_tab 8"
              "alt+9 goto_tab 9"
              "ctrl+shift+w close_tab"
              "ctrl+t new_tab_with_cwd"
              "ctrl+shift+t new_tab"
            ];

            # --- Colors (Standalone Fallback Palette) ---
            background = "#1a1b26";
            foreground = "#cdd6f4";
            cursor = "#cdd6f4";
            selection_foreground = "#cdd6f4";
            selection_background = "#313244";
            active_tab_foreground = "#a6e3a1";
            active_tab_background = "#313244";
            inactive_tab_background = "#1e1e2e";

            color0 = "#45475a";
            color8 = "#585b70";
            color1 = "#f38ba8";
            color9 = "#f38ba8";
            color2 = "#a6e3a1";
            color10 = "#a6e3a1";
            color3 = "#f9e2af";
            color11 = "#f9e2af";
            color4 = "#89b4fa";
            color12 = "#89b4fa";
            color5 = "#f5c2e7";
            color13 = "#f5c2e7";
            color6 = "#94e2d5";
            color14 = "#94e2d5";
            color7 = "#bac2de";
            color15 = "#a6adc8";
          };
        }).wrapper;
    };

  # --- The Module Definition ---
  flake.lib.wrapperModules.kitty = inputs."wrapper-modules".lib.wrapModule (
    {
      config,
      wlib,
      lib,
      ...
    }:
    let
      inherit (lib) mkOption types;
      inherit (lib.generators) mkKeyValueDefault;

      # Safely pull pkgs from config to ensure module scope consistency
      pkgs = config.pkgs;

      # Generator for kitty's config format
      kittyKeyValueFormat = pkgs.formats.keyValue {
        listsAsDuplicateKeys = true;
        mkKeyValue = mkKeyValueDefault { } " ";
      };

      # The safe way to merge a generated derivation and an extra string in Nix
      writeKittyConfig =
        settings: extra:
        pkgs.concatTextFile {
          name = "kitty.conf";
          files = [
            (kittyKeyValueFormat.generate "base-kitty.conf" settings)
            (pkgs.writeText "extra-kitty.conf" extra)
          ];
        };

    in
    {
      options = {
        settings = mkOption {
          type = kittyKeyValueFormat.type;
          default = { };
        };

        extraConfig = mkOption {
          type = types.str;
          default = "";
        };

        devMode = mkOption {
          type = types.bool;
          default = false;
        };

        devSessionPath = mkOption {
          type = types.nullOr types.path;
          default = null;
        };

        configFile = mkOption {
          type = wlib.types.file pkgs;
        };
      };

      config = {
        package = pkgs.kitty;

        # Set the default path for the config file
        configFile.path = writeKittyConfig config.settings config.extraConfig;

        # Define the CLI flags passed to kitty
        flags = lib.mkMerge [
          { "-c" = "${config.configFile.path}"; }

          # Only inject the session flag if devMode is true AND a path is provided
          (lib.mkIf (config.devMode && config.devSessionPath != null) {
            "--session" = "${config.devSessionPath}";
          })
        ];
      };
    }
  );
}
