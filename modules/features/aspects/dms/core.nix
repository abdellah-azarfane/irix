{ self, ... }: {
  flake.nixosModules.dms =
    {
      inputs,
      config,
      pkgs,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
      sys = pkgs.stdenv.hostPlatform.system;
    in
    {
      imports = [
        self.nixosModules.dms-plugins
      ];
      home-manager.users.${user} = {
        imports = [
          inputs.dms.homeModules.dank-material-shell
        ];
        programs.dank-material-shell = {
          enable = true;
          package = inputs.dms.packages.${sys}.default;
          enableSystemMonitoring = true;
          dgop.package = inputs.dgop.packages.${sys}.default;
        };
      };
    };
}
