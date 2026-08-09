{ ... }: {
  flake.nixosModules.ghostty =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {
      home-manager.users.${user} = {
        programs.ghostty = {
          enable = true;

          settings = {
            # Font Configuration
            font-family = "JetBrainsMono Nerd Font";
            font-size = 15;
            adjust-cell-height = "8%";

            # Window Layout & Decoration
            window-padding-x = 14;
            window-padding-y = 12;
            window-padding-balance = true;
            window-decoration = "server";

            # Visuals
            background-opacity = 0.85;
            background-blur = true;

            # Cursor & Mouse Behavior
            cursor-style = "block";
            cursor-style-blink = false;
            mouse-hide-while-typing = true;

            # Clipboard & Session
            copy-on-select = "clipboard";
            confirm-close-surface = false;

            keybind = [
              "ctrl+v=paste_from_clipboard"
            ];

            # FIX: Use an absolute path so Ghostty doesn't search the Nix store
            theme = "/home/${user}/.config/ghostty/themes/wallust";
          };
        };
        xdg.configFile."ghostty/themes/.keep".text = "";
      };
    };
}
