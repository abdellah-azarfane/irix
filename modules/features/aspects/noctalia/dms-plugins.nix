{
  flake.nixosModules.noctalia-plugins =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    let
      user = config.preferences.user.name;
      sys = pkgs.stdenv.hostPlatform.system;
    in
    {
      home-manager.users.${user} = {
        programs.noctalia = {
          settings = {
            hooks = {
              # Run wallust when wallpaper changes via Noctalia's built-in hooks
              wallpaper_changed = ''
                ${pkgs.wallust}/bin/wallust run "$NOCTALIA_WALLPAPER_PATH"
              '';
              # Track shell lifecycle
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
        };
      };
    };
}
