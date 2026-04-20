{ ... }: {
  flake.nixosModules.browsers = { pkgs, inputs, ... }:
  let 
   system = pkgs.stdenv.hostPlatform.system;
  in
  {
    
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
