{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      services.udev = {
        enable = true; # Enable device manager
      };
    };
}
