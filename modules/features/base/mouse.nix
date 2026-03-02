{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      hardware.logitech.wireless = {
        enable = true;
        enableGraphical = true; # NOTE: Adds solaar
      };
    };
}
