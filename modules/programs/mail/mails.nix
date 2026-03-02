{
  flake.modules.homeManager.mails =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        thunderbird
        aerc # Modern terminal email client
        protonmail-desktop
        protonmail-bridge
        protonmail-bridge-gui
      ];
    };
}
