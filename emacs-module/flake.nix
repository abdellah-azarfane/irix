{
  description = "Irix Standalone Emacs Module";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules.default =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        programs.emacs = {
          enable = true;
          package = pkgs.emacs-pgtk; # Native Wayland support
          extraPackages = epkgs: [ epkgs.vterm ]; # Pre-compile vterm module for faster builds
        };

        services.emacs = {
          enable = true;
          client.enable = true;
          #    defaultEditor = true;
          #   startWithUserSession = "graphical"; # Wait for Wayland to start before launching
        };

        home.packages = with pkgs; [
          # Required by Doom's core functionality
          git
          ripgrep
          fd
          findutils
        ];

        xdg.configFile."emacs".source =
          config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dev/irix/emacs-module/config";

      };
  };
}
