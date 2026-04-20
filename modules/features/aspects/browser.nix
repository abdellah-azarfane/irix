{ lib, inputs, ... }: {
  flake.nixosModules.browsers = { pkgs, inputs, ... }: {
    
    programs.firefox.enable = true;

    environment.systemPackages = with pkgs; [
      inputs.helium.packages.${system}.default
      librewolf
      brave
      ungoogled-chromium 
      tor
      w3m
    ];
  };
}
