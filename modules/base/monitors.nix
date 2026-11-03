{ lib, ... }:
{
  flake.lib.mkNiriOutputs =
    monitors:
    lib.mapAttrs (
      _: mon:
      let
        mode =
          if mon.mode != null then
            mon.mode
          else
            "${toString mon.width}x${toString mon.height}@${toString mon.refreshRate}";
      in
      {
        mode = lib.mkIf (mon.width != null || mon.mode != null) mode;
        scale = mon.scale;
        position = {
          x = mon.x;
          y = mon.y;
        };
      }
    ) monitors;

  flake.nixosModules.monitors =
    { config, ... }:
    {
      options.preferences.monitors = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              primary = lib.mkOption {
                type = lib.types.bool;
                default = false;
              };
              width = lib.mkOption {
                type = lib.types.nullOr lib.types.int;
                default = null;
              };
              height = lib.mkOption {
                type = lib.types.nullOr lib.types.int;
                default = null;
              };
              refreshRate = lib.mkOption {
                type = lib.types.float;
                default = 60.0;
              };
              mode = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Optional explicit Niri mode string; otherwise derived from width/height/refreshRate.";
              };
              scale = lib.mkOption {
                type = lib.types.float;
                default = 1.0;
              };
              x = lib.mkOption {
                type = lib.types.int;
                default = 0;
              };
              y = lib.mkOption {
                type = lib.types.int;
                default = 0;
              };
            };
          }
        );
        default = { };
        description = "Monitor configurations.";
      };
    };
}
