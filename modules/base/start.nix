{ lib, ... }:
{
  flake.lib.mkAutostartEntries =
    commands:
    builtins.listToAttrs (
      lib.imap0 (i: cmd: {
        name = "autostart-${toString i}";
        value = {
          description = "Autostart entry: ${cmd}";
          wantedBy = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          serviceConfig = {
            ExecStart = cmd;
            Restart = "on-failure";
          };
        };
      }) commands
    );

  flake.nixosModules.start = {
    options.preferences = {
      theme = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Shared color palette.";
      };

      autostart = lib.mkOption {
        type = lib.types.listOf lib.types.anything;
        default = [ ];
        description = "Commands or packages to autostart in a graphical session.";
      };

      sops.sshKeyPaths = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ "/home/abosafiya/.ssh/keys/id_ed25519" ];
        description = "SSH key paths used by sops-nix age decryption.";
      };

      apps = {
        browser = lib.mkOption {
          type = lib.types.str;
          default = "helium";
        };
        editor = lib.mkOption {
          type = lib.types.str;
          default = "zeditor";
        };
        terminal = lib.mkOption {
          type = lib.types.str;
          default = "ghostty";
        };
        imageViewer = lib.mkOption {
          type = lib.types.str;
          default = "imv";
        };
        videoPlayer = lib.mkOption {
          type = lib.types.str;
          default = "mpv";
        };
        audioPlayer = lib.mkOption {
          type = lib.types.str;
          default = "mpv";
        };
        pdfViewer = lib.mkOption {
          type = lib.types.str;
          default = "zathura";
        };
        wm = lib.mkOption {
          type = lib.types.str;
          default = "niri";
        };
        pager = lib.mkOption {
          type = lib.types.str;
          default = "less";
        };
      };
    };
  };
}
