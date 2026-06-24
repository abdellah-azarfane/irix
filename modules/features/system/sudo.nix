{ self, ... }: {
  flake.nixosModules.sudo = { lib, config, ... }: {
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
  };
}