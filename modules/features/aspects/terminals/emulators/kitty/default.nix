{
  self,
  inputs,
  ...
}: let
  inherit (self.lib) theme;
in {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
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
          background_opacity = "0.7";
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

          # --- Colors (Theming) ---
          background = theme.base00;
          foreground = theme.base07;
          cursor = theme.base07;
          selection_foreground = theme.base02;
          selection_background = theme.base01;
          active_tab_foreground = theme.base0B;
          active_tab_background = theme.base03;
          inactive_tab_background = theme.base01;

          color0 = theme.base00;
          color8 = theme.base02;
          color1 = theme.base08;
          color9 = theme.base08;
          color2 = theme.base0B;
          color10 = theme.base0B;
          color3 = theme.base0A;
          color11 = theme.base0A;
          color4 = theme.base0D;
          color12 = theme.base0D;
          color5 = theme.base0E;
          color13 = theme.base0E;
          color6 = theme.base0C;
          color14 = theme.base0C;
          color7 = theme.base03;
          color15 = theme.base03;
        };
      }).wrapper;
  };

  # --- The Module Definition ---
  flake.lib.wrapperModules.kitty = inputs."wrapper-modules".lib.wrapModule ({
    config,
    wlib,
    lib,
    ...
  }: let
    inherit (lib) mkOption types;
    inherit (lib.generators) mkKeyValueDefault;

    # Safely pull pkgs from config to ensure module scope consistency
    pkgs = config.pkgs;

    # Generator for kitty's config format
    kittyKeyValueFormat = pkgs.formats.keyValue {
      listsAsDuplicateKeys = true;
      mkKeyValue = mkKeyValueDefault {} " ";
    };

    # The safe way to merge a generated derivation and an extra string in Nix
    writeKittyConfig = settings: extra: pkgs.concatTextFile {
      name = "kitty.conf";
      files = [
        (kittyKeyValueFormat.generate "base-kitty.conf" settings)
        (pkgs.writeText "extra-kitty.conf" extra)
      ];
    };

  in {
    options = {
      settings = mkOption {
        type = kittyKeyValueFormat.type;
        default = {};
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
  });
}
