{ ... }: {
  flake.nixosModules.browsers =
    { pkgs, inputs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {
      nixpkgs.overlays = [
        inputs.helium-flake.overlays.default
      ];
      environment.systemPackages = with pkgs; [
        librewolf
        helium
      ];
    };
}
