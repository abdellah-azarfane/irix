
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
      let
        emacsConfigDir = "${config.home.homeDirectory}/dev/irix/emacs-module/doom-config";
        emacsPkg = pkgs.emacs-pgtk;
      in
      {
        programs.emacs = {
          enable = true;
          package = emacsPkg; # Native Wayland support
          extraPackages = epkgs: [ epkgs.vterm ]; # Pre-compile vterm module for faster builds
        };

        services.emacs = {
          enable = true;
          client.enable = true;
          startWithUserSession = "graphical"; # Wait for Wayland to start before launching
        };

        home.packages = with pkgs; [
          # Required by Doom's core functionality
          git
          ripgrep
          fd
          findutils
        ];

        xdg.configFile."doom".source =
          config.lib.file.mkOutOfStoreSymlink emacsConfigDir;

        home.activation.installDoomEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          export EMACSDIR="${config.home.homeDirectory}/.config/emacs"

          # Clean up corrupted or empty engine folders
          if [ -d "$EMACSDIR" ] && [ ! -f "$EMACSDIR/bin/doom" ]; then
            rm -rf "$EMACSDIR"
          fi

          # Clone the pristine Doom framework
          if [ ! -d "$EMACSDIR" ]; then
            echo "🚀 Bootstrapping Doom Emacs engine..."
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs "$EMACSDIR"
            echo "✅ Doom Emacs downloaded. Remember to run 'doom install' or 'doom sync' manually."
          fi
        '';
      };
  };
}
