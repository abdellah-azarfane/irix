{ lib, ... }: {
  flake.nixosModules.browsers = { pkgs, ... }: {
    
    programs.firefox.enable = true;

    preferences.keymap = {
      "SUPER + d"."f".package = pkgs.firefox;
    };
       preferences.keymap = {
      "SUPER + d"."p".package = pkgs.brave;
    };

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