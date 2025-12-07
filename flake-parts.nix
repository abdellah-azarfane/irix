{
  config,
  self,
  inputs,
  ...
}: let
  inherit (self) outputs;
  mkHost = import ./lib/mkHost.nix;
in {
  flake = {
    # NixOS configurations using mkHost
    nixosConfigurations = {
      # Laptop host (barevalor)
      barevalor = mkHost {
        hostName = "barevalor";
        modules = [
          ./hosts/laptop
        ];
      } { inherit inputs outputs; };

      # Desktop host (unused for now, but ready to use)
      desktop = mkHost {
        hostName = "desktop";
        modules = [
          ./hosts/desktop
        ];
      } { inherit inputs outputs; };
    };
  };

  perSystem = { pkgs, ... }: {
    # Devshells
    devShells = {
      default = import ./devshells/nixos.nix { inherit pkgs; };
      nixos = import ./devshells/nixos.nix { inherit pkgs; };
    };
  };
}

