{...}: {
  flake.nixosModules.social = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        localsend
        weechat
        vesktop
        aerc
      ];
    };
}
