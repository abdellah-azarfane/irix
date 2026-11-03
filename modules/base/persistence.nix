{ lib, inputs, ... }:
{
  flake.nixosModules.persistence =
    { config, ... }:
    let
      cfg = config.preferences.persistence;
      userCfg = config.preferences.user;
    in
    {
      imports = [
        inputs.preservation.nixosModules.default
      ];

      options.preferences.persistence = {
        enable = lib.mkEnableOption "impermanence state preservation via preservation flake";
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
          description = "System directories to persist.";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
          description = "System files to persist.";
        };
        userDirectories = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
          description = "User home directories to persist.";
        };
        userFiles = lib.mkOption {
          type = lib.types.listOf lib.types.anything;
          default = [ ];
          description = "User home files to persist.";
        };
      };

      config = lib.mkIf cfg.enable {
        preservation.enable = true;
        preservation.preserveAt."/persist" = {
          directories = cfg.directories;
          files = cfg.files;
          users.${userCfg.name} = {
            directories = cfg.userDirectories;
            files = cfg.userFiles;
          };
        };
      };
    };
}
