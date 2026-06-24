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
            After = [ "graphical-session.target" ];
            PartOf = [ "graphical-session.target" ];
          };
          Service = {
            ExecStartPre = [
              "${pkgs.bash}/bin/bash -c 'T=\"${emacsConfigDir}\"; L=\"%h/.config/emacs\"; if [ ! -L \"$L\" ] || [ \"$(readlink \"$L\")\" != \"$T\" ]; then rm -rf \"$L\" 2>/dev/null; ln -sfn \"$T\" \"$L\"; fi'"
            ];
          };
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
