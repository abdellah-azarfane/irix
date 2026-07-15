{
  flake.nixosModules.base = { lib, config, pkgs, ... }:
  { lib, config, pkgs, ... }:
  let
    tomlFormat = pkgs.formats.toml { };

    appConfigSubmodule = lib.types.submodule ({ name, config, ... }: {
      options = {
        enable = lib.mkEnableOption "Enable configuration for ${name}";

        # NEW: Define an optional package to install
        package = lib.mkOption {
          type = lib.types.nullOr lib.types.package;
          default = null;
          description = "The package to install alongside this configuration.";
        };

        files = lib.mkOption {
          type = lib.types.attrsOf tomlFormat.type;
          default = { };
          description = "Dictionary of TOML files to generate.";
        };

        homeConfigDir = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Target directory in $HOME relative to .config/ to symlink the files.";
        };
      };
    });
  in {
    options.irix.apps = lib.mkOption {
      type = lib.types.attrsOf appConfigSubmodule;
      default = { };
    };

    config =
      let
        user = config.preferences.user.name;
        enabledApps = lib.filterAttrs (_: appCfg: appCfg.enable && appCfg.homeConfigDir != null) config.irix.apps;

        mkAppFiles = _name: appCfg:
          let
            relConfigPath =
              if lib.hasPrefix ".config/" appCfg.homeConfigDir
              then lib.removePrefix ".config/" appCfg.homeConfigDir
              else appCfg.homeConfigDir;
          in
            lib.mapAttrs' (fileName: fileSettings:
              lib.nameValuePair "${relConfigPath}/${fileName}" {
                source = tomlFormat.generate fileName fileSettings;
              }
            ) appCfg.files;

        generatedFiles = lib.foldlAttrs (acc: name: appCfg: acc // (mkAppFiles name appCfg)) { } enabledApps;

        # NEW: Extract the packages from all enabled apps that have a package defined
        appPackages = lib.filter (p: p != null) (lib.mapAttrsToList (_: appCfg: appCfg.package) enabledApps);
      in
        lib.mkIf (enabledApps != { }) {
          # 1. Route the generated TOML files to Hjem
          hjem.users.${user}.xdg.config.files = generatedFiles;

          # 2. Route the extracted binaries to the native NixOS user profile
          users.users.${user}.packages = appPackages;
        };
  };
}
