{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./bar
   # ./de/kde
    ./files
    ./fonts
    ./games
    ./notifications
    ./wm/hyprland/intel.nix # TODO: This needs to be dealt with here as well declaratively based on hardware
  ];
}
