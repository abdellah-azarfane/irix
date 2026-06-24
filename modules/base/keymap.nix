{ self, lib, ... }: {
  flake.nixosModules.keymap = { lib, ... }: {
    options.preferences.keymap = lib.mkOption {
      type = lib.types.lazyAttrsOf (lib.types.either lib.types.attrs lib.types.package);
      default = {};
      description = "Define keybindings and keychords for the system.";
      example = {
        "SUPER + d" = {
          "s" = { };
          "p" = { };
          "y" = { };
        };
      };
    };
  };

  flake.lib.mkNiriBinds = keymap:
    lib.mapAttrs' (key: _: lib.nameValuePair key { }) keymap;
}
