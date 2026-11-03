{ lib, ... }:
{
  flake.lib.mkNiriBinds =
    binds:
    lib.mapAttrs (
      _: action: if builtins.isString action then { action.spawn = lib.splitString " " action; } else action
    ) binds;

  flake.nixosModules.keymap =
    { config, ... }:
    let
      cfg = config.preferences.keymap;
    in
    {
      options.preferences.keymap = lib.mkOption {
        type = lib.types.submodule {
          freeformType = lib.types.attrsOf lib.types.anything;
          options = {
            layout = lib.mkOption {
              type = lib.types.str;
              default = "us";
              description = "XKB keyboard layout.";
            };
            variant = lib.mkOption {
              type = lib.types.str;
              default = "";
              description = "XKB keyboard variant.";
            };
            binds = lib.mkOption {
              type = lib.types.attrsOf lib.types.anything;
              default = { };
              description = "Keybindings mapped via flake.lib.mkNiriBinds.";
            };
          };
        };
        default = { };
        description = "Keyboard layout and freeform keybinding tree.";
      };

      config = {
        services.xserver.xkb = {
          inherit (cfg) layout variant;
        };
      };
    };
}
