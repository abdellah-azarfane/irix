{
  lib,
  inputs,
  self,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    # My whole desktop in one package, includes kityy terminal
    packages.desktop =
      (inputs."wrapper-modules".wrappers.niri.apply ({config, ...}: {
        inherit pkgs;
        env = {
          EDITOR = "zeditor";
        };
      })).wrapper;

    # My primary flake shell with all of it's packages
    packages.environment = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      extraPackages = [

        pkgs.sshfs
        # wrapped
        self'.packages.lf
        self'.packages.jujutsu
        self'.packages.jjui
        self'.packages.nix-check-bin
      ];
    };

    packages.nix-check-bin = pkgs.writeShellApplication {
      name = "nix-check-bin";
      text = ''
        $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
      '';
    };
  };
}
