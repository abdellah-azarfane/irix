{ ... }: {
  flake.nixosModules.ghostty =
    { pkgs, config, ... }:
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
            adjust-cell-height = "8%"; # Strings required for percentage values

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

            theme = "wallust";
          };
        };
        systemd.user.services."app-com.mitchellh.ghostty" = {
          Unit = {
            Description = "Ghostty Terminal Emulator Daemon";
            PartOf = [ "graphical-session.target" ];
            After = [ "graphical-session.target" ];
          };
          Service = {
            # Start Ghostty in the background without spawning a window
            ExecStart = "${pkgs.ghostty}/bin/ghostty --initial-window=false";
            Restart = "on-failure";
          };
          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };
    };
}
