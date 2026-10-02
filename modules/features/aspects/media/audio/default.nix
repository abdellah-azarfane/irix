{
  flake.nixosModules.audio = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      audacious
      audacious-plugins
      ncmpcpp
      ncspot
      easyeffects
      crosspipe
    ];
  };
}
