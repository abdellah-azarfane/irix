{...}: {
  flake.nixosModules.social = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        localsend
        weechat
        discordo
        vesktop
        tut
        zoom-us
        element-call
        element-desktop
        signal-desktop
        telegram-desktop
        discord
        thunderbird
        aerc
        protonmail-desktop
        protonmail-bridge
        protonmail-bridge-gui
      ];
    };
}
