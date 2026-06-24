{ inputs, ... }: {
  flake.nixosModules.persistence = { lib, config, ... }: let
    user = config.preferences.user.name;
    homeDir = config.home-manager.users.${user}.home.homeDirectory;
    cfg = config.persistence;
  in {
    imports = [ inputs.preservation.nixosModules.preservation ];

    options.persistence = {
      enable = lib.mkEnableOption "enable persistence";

      nukeRoot.enable = lib.mkEnableOption "Destroy /root on every boot";

      volumeGroup = lib.mkOption {
        default = "btrfs_vg";
        type = lib.types.str;
        description = "Btrfs volume group";
      };

      user = lib.mkOption {
        default = "username";
        type = lib.types.str;
        description = "Main user";
      };

      directories = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "Root directories to persist";
      };

      files = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "Root files to persist";
      };

      userDirectories = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "User directories to persist (relative to $HOME)";
      };

      userFiles = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "User files to persist (relative to $HOME)";
      };

      data.directories = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "Data directories to persist";
      };

      data.files = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "Data files to persist";
      };

      cache.directories = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "Cache directories to persist";
      };

      cache.files = lib.mkOption {
        default = [];
        type = lib.types.listOf lib.types.str;
        description = "Cache files to persist";
      };
    };

    config = lib.mkIf cfg.enable {
      preservation.preserveAt."/persist" = {
        inherit (cfg) directories files;

        users.${user} = {
          directories = cfg.userDirectories;
          files = cfg.userFiles;
        };
      };

      # Create /state directory if not on impermanence
      systemd.tmpfiles.settings."10-persist" = {
        "/persist".d = {
          user = "root";
          group = "root";
          mode = "0755";
        };
      };
    };
  };
}
