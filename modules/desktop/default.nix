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
    ./wm/hyprland # TODO: Chose you're wm
  ];
}
