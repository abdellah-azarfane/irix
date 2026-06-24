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

        # Wrap the daemon to ensure config symlink is ready before Emacs starts,
        # and pass flags so it loads the right init directory from the start.
        # This avoids the race between home-manager activation and service start.
       systemd.user.services.emacs = {
        Unit = {
        Description = "Emacs daemon";
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
        Requires = [ "graphical-session.target" ];
          };
       Service = {
        Type = "notify";
        ExecStart = "${config.programs.emacs.finalPackage}/bin/emacs --fg-daemon";
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
    Install.WantedBy = [ "graphical-session.target" ];
  };       
        home.packages = with pkgs; [
          git
          ripgrep
          fd
          findutils
        ];

        xdg.configFile."emacs".source =
          config.lib.file.mkOutOfStoreSymlink emacsConfigDir;

      };
  };
}
