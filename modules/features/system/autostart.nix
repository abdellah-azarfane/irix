{ self, ... }: {
  flake.nixosModules.autostart = { lib, config, ... }: let
    user = config.preferences.user.name;
    cfg = config.preferences.autostart;
  in {
    config = lib.mkIf (cfg != []) {
      home-manager.users.${user} = {
        systemd.user.services = lib.listToAttrs (map (entry:
          let
            exec = if lib.isString entry then entry else lib.getExe entry;
            name = "autostart-" + (builtins.hashString "sha256" exec);
          in
          lib.nameValuePair name {
            Unit = {
              Description = "Autostart: ${exec}";
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              Type = "simple";
              ExecStart = exec;
              Restart = "on-failure";
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
          }
        ) cfg);
      };
    };
  };
}