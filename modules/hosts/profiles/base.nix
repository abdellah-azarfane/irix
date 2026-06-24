{ self, ... }:
{
  flake.nixosModules.hostProfileBase = {
    imports = [
      self.nixosModules.base
      self.nixosModules.homeManager
      self.nixosModules.core
      self.nixosModules.services
      self.nixosModules.greetd
      self.nixosModules.hardware
      self.nixosModules.nix-ld
      self.nixosModules.keymap
      self.nixosModules.monitors
      self.nixosModules.start
      self.nixosModules.persistence

      # autostart module — inlined due to import-tree not exposing it
      ({ lib, config, ... }: let
        user = config.preferences.user.name;
        acfg = config.preferences.autostart;
      in {
        config = lib.mkIf (acfg != []) {
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
            ) acfg);
          };
        };
      })

      # sudo module — inlined due to import-tree not exposing it
      ({ lib, config, ... }: {
        security.sudo = {
          enable = true;
          extraRules = [
            {
              groups = [ "wheel" ];
              commands = [
                {
                  command = "${config.systemd.package}/bin/systemctl";
                  options = [ "NOPASSWD" ];
                }
                {
                  command = "${config.nix.package}/bin/nixos-rebuild";
                  options = [ "NOPASSWD" ];
                }
                {
                  command = "${config.nix.package}/bin/nix";
                  options = [ "NOPASSWD" ];
                }
              ];
            }
          ];
        };
      })
    ];

    persistence.enable = false;

    system.stateVersion = "26.05";
  };
}
