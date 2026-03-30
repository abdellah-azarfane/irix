{
  flake.nixosModules.base = {lib, ...}: {
    options.preferences = {
      theme = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Theme palette shared across host profiles.";
      };

      autostart = lib.mkOption {
        type = lib.types.listOf (lib.types.either lib.types.str lib.types.package);
        default = [];
      };
    };
  };
}
