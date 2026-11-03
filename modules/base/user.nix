{ lib, ... }:
{
  flake.nixosModules.user =
    { config, pkgs, ... }:
    let
      cfg = config.preferences.user;
    in
    {
      options.preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "abosafiya";
          description = "Primary username.";
        };
        fullName = lib.mkOption {
          type = lib.types.str;
          default = "Abdellah Azarfane";
          description = "Primary user's full name.";
        };
        email = lib.mkOption {
          type = lib.types.str;
          default = "abdellahazarfane@proton.me";
          description = "Primary user's email.";
        };
        initialHashedPassword = lib.mkOption {
          type = lib.types.str;
          default = "$6$mhUXobPRIxAenNMe$EjE8vQ2kbr5Ia1W1g/vltxOo.fz1wwsDVPMvsiG1gvC/mGFms92ZdDuwhLiqbadOW/k2x8gGOSx/kQtK5FLZ3/";
          description = "SHA-512 hashed initial password.";
        };
        extraGroups = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [
            "wheel"
            "networkmanager"
            "video"
            "audio"
            "input"
          ];
          description = "Extra groups for the primary user.";
        };
      };

      config = {
        programs.fish.enable = true;
        users.users.${cfg.name} = {
          isNormalUser = true;
          description = cfg.fullName;
          inherit (cfg) initialHashedPassword extraGroups;
          shell = pkgs.fish;
        };
      };
    };
}
