{
  flake.nixosModules.base = { lib, ... }: {
  options.preferences.monitors = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        primary = lib.mkOption { 
          type = lib.types.bool; 
          default = false; 
          };
        width = lib.mkOption { 
          type = lib.types.int; 
          example = 1920; 
          };
        height = lib.mkOption {
           type = lib.types.int; 
           example = 1080; 
           };
        refreshRate = lib.mkOption {
           type = lib.types.float; 
           default = 60.0; 
           };
        scale = lib.mkOption { 
          type = lib.types.float; 
          default = 1.0; 
          description = "Display scale factor (e.g., 1.0, 1.5, 2.0)";
        };
        x = lib.mkOption { type = lib.types.int; default = 0; };
        y = lib.mkOption { type = lib.types.int; default = 0; };
        enabled = lib.mkOption { type = lib.types.bool; default = true; };
      };
    });
    default = {};
  };
};
}
