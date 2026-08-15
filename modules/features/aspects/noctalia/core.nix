{
  flake.nixosModules.noctalia =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    let
      user = config.preferences.user.name;
    in
    {
      hjem.extraModules = [
        inputs.noctalia.hjemModules.default
      ];
      hjem.users.${user}.programs.noctalia = {
        enable = true;
        settings = {
          theme = {
            mode = "dark";
            source = "wallpaper";
            #     builtin = "Catppuccin";
          };
          wallpaper = {
            enabled = true;
          };
          bar.main = {
            position = "top";
          };
          shell = {
            ui_scale = 1.0;
            clipboard_enabled = true;
          };
          # modules/features/aspects/noctalia/core.nix
          hooks = {
            # Everything compressed onto one single line so Noctalia's parser doesn't cut it off
            wallpaper_changed = ''
              ${pkgs.wallust}/bin/wallust run "$NOCTALIA_WALLPAPER_PATH"
                          if [ -f "$HOME/.cache/wallust/openrgb_static.sh" ]; then
                     bash "$HOME/.cache/wallust/openrgb_static.sh" &
                   fi
            '';
            started = ''
              logger -t noctalia-hooks "Noctalia started"
            '';
            session_locked = ''
              logger -t noctalia-hooks "Session locked"
            '';
            session_unlocked = ''
              logger -t noctalia-hooks "Session unlocked"
            '';
          };
        };
        systemd.enable = true;
      };
    };
}
