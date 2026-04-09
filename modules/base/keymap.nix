{
  flake.nixosModules.base = { lib, pkgs, ... }: {
    options.preferences = {
      keymap = lib.mkOption {
        type = lib.types.lazyAttrsOf (lib.types.either lib.types.attrs lib.types.package);
        default = {};
        description = "Define keybindings and keychords for the system.";
        example = {
          # MERGED: super + d keychords
          "SUPER + d" = {
            "f" = { exec = "firefox"; };
          };
          
          # super + a -> b -> c keychord
          "SUPER + a" = {
            "b"."c" = {
              exec = "pcmanfm";
            };
          };
       
          # You can only map "a" to one action. 
          # You must choose either a package OR an exec string.
          "a" = { 
            package = pkgs.firefox; 
          };
        };
      };
    };
  };
}