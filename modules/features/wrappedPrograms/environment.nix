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
          EDITOR = lib.getExe self'.packages.neovim;
        };
      })).wrapper;

    # My primary flake shell with all of it's packages
    packages.environment = inputs."wrapper-modules".lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      extraPackages = [

        pkgs.sshfs
        pkgs.tree-sitter
        pkgs.yt-dlp

        # wrapped
        self'.packages.neovimDynamic
        self'.packages.qalc
        self'.packages.lf
        pkgs.git
        self'.packages.jujutsu
        self'.packages.jjui
        self'.packages.nix-check-bin
      ];
      env = {
        EDITOR = lib.getExe self'.packages.neovimDynamic;
      };
    };

    packages.nix-check-bin = pkgs.writeShellApplication {
      name = "nix-check-bin";
      text = ''
        $EDITOR "$(nix build "$1" --no-link --print-out-paths)/bin"
      '';
    };
  };
}
