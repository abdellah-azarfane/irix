{ lib, ... }: {
  flake.nixosModules.browsers = { pkgs, ... }: {
    
    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      librewolf
      brave
      ungoogled-chromium 
      tor
      w3m
      lynx
      browsh
    ];
  };
}