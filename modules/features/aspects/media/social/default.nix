{...}: {
  flake.nixosModules.social = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        weechat
        discordo
        vesktop
        tut
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
