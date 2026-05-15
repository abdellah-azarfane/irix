{
  flake.nixosModules.base = { lib, config, pkgs, ... }:
  let
    tomlFormat = pkgs.formats.toml { };

    appConfigSubmodule = lib.types.submodule ({ name, config, ... }: {
      options = {
        enable = lib.mkEnableOption "Enable configuration for ${name}";

        files = lib.mkOption {
          type = lib.types.attrsOf tomlFormat.type;
          default = { };
          description = "Dictionary of TOML files to generate.";
        };

        homeConfigDir = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Target directory in $HOME to symlink the aggregated files.";
        };

        generatedDir = lib.mkOption {
          type = lib.types.path;
          readOnly = true;
          default = pkgs.runCommand "${name}-config-dir" {} ''
            mkdir -p $out
            ${lib.concatStringsSep "\n" (lib.mapAttrsToList (fileName: fileSettings: ''
              ln -s ${tomlFormat.generate fileName fileSettings} $out/${fileName}
            '') config.files)}
          '';
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
            homeDir = appCfg.homeConfigDir;
            relConfigPath =
              if lib.hasPrefix ".config/" homeDir
              then lib.removePrefix ".config/" homeDir
              else homeDir;
          in
            lib.mapAttrs' (fileName: _:
              lib.nameValuePair "${relConfigPath}/${fileName}" {
                source = "${appCfg.generatedDir}/${fileName}";
              }
            ) appCfg.files;
        generatedFiles = lib.foldlAttrs (acc: name: appCfg: acc // (mkAppFiles name appCfg)) { } enabledApps;
      in
        lib.mkIf (enabledApps != { }) {
          hjem.users.${user}.xdg.config.files = generatedFiles;
        };
  };
}
