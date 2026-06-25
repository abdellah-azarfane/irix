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
        emacsConfigDir = "${config.home.homeDirectory}/dev/irix/emacs-module/config";
        emacsPkg = pkgs.emacs-pgtk;
      in
      {
        programs.emacs = {
          enable = true;
          package = emacsPkg;
          extraPackages = epkgs: [ epkgs.vterm ];
        };

        services.emacs = {
          enable = true;
          client.enable = true;
          defaultEditor = false;
          startWithUserSession = "graphical";
        };

        # Wrap the daemon to pass flags so it loads the right init directory from the start.
                # We use lib.mkForce on the entire service definition to override the defaults.
                systemd.user.services.emacs = lib.mkForce {
                  Unit = {
                    Description = "Emacs daemon";
                    After = [ "graphical-session.target" ];
                    PartOf = [ "graphical-session.target" ];
                    Requires = [ "graphical-session.target" ];
                  };
                  Service = {
                    Type = "notify";
                    ExecStart = "${config.programs.emacs.finalPackage}/bin/emacs --fg-daemon --init-directory=${emacsConfigDir}";
                    ExecStop = "${config.programs.emacs.finalPackage}/bin/emacsclient --eval '(kill-emacs)'";
                    Restart = "on-failure";
                    PassEnvironment = [
                      "WAYLAND_DISPLAY"
                      "XDG_RUNTIME_DIR"
                      "DISPLAY"
                    ];
                    Environment = [
                      "PATH=${config.home.profileDirectory}/bin:/run/current-system/sw/bin"
                      "GDK_BACKEND=wayland"
                    ];
                  };
                  Install = {
                    WantedBy = [ "graphical-session.target" ];
                  };
                };
        home.packages = with pkgs; [
          git
          ripgrep
          fd
          findutils
        ];
        # Bootstrap Activation Script
              # Clones the engine only if it is missing.
              # Strictly avoids running 'doom sync' to prevent Home Manager activation crashes.
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
        xdg.configFile."doom".source =
          config.lib.file.mkOutOfStoreSymlink emacsConfigDir;

      };
  };
}
