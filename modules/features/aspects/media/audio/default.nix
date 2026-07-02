 {
  flake.nixosModules.audio = {pkgs, ...}: {
      environment.systemPackages = with pkgs; [
        ncmpcpp
        ncspot
        easyeffects
        crosspipe
      ];
  };
}
