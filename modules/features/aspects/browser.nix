{ ... }: {
  flake.nixosModules.browsers = { pkgs, inputs, ... }:
  let
   system = pkgs.stdenv.hostPlatform.system;
  in
  {
    #programs.ladybird.enable = true;
    environment.systemPackages = with pkgs; [
      librewolf
    ];
  };
}
