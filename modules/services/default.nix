{ ... }:
{
  imports = [
    ./asus-backlight.nix
    ./laptop-lid.nix
    # ./keychron.nix
    ./asus.nix
    ./waydroid.nix
  ];
  asus.enable = true;
}
