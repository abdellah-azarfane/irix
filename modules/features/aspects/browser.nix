{ ... }: {
  flake.nixosModules.browsers = { pkgs, inputs, ... }:
  let
   system = pkgs.stdenv.hostPlatform.system;
  in
  {
    environment.systemPackages = with pkgs; [
      librewolf
    ];
  };
}
