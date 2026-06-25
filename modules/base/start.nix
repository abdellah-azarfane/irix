{ self, lib, ... }: {
  flake.nixosModules.start = { lib, ... }: {
    options.preferences = {
      apps = lib.mkOption {
        type = lib.types.submodule {
          options = {
            browser = lib.mkOption {
              type = lib.types.str;
              default = "librewolf";
              description = "Default browser command used by session variables.";
            };

            editor = lib.mkOption {
              type = lib.types.str;
              default = "emacsclient -c";
              description = "Default editor command used by EDITOR/VISUAL.";
            };

            terminal = lib.mkOption {
              type = lib.types.str;
              default = "ghostty";
              description = "Default terminal command.";
            };

            imageViewer = lib.mkOption {
              type = lib.types.str;
              default = "imv";
              description = "Default image viewer command.";
            };

            videoPlayer = lib.mkOption {
              type = lib.types.str;
              default = "mpv";
              description = "Default video player command.";
            };

            audioPlayer = lib.mkOption {
              type = lib.types.str;
              default = "mpv";
              description = "Default audio player command.";
            };

            pdfViewer = lib.mkOption {
              type = lib.types.str;
              default = "zathura";
              description = "Default PDF viewer command.";
            };


            wm = lib.mkOption {
              type = lib.types.str;
              default = "niri";
              description = "Window manager/compositor identifier.";
            };

            pager = lib.mkOption {
              type = lib.types.str;
              default = "most";
              description = "Default pager command.";
            };
          };
        };
        default = {};
        description = "Central app preferences consumed by environment modules.";
      };

      theme = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        description = "Theme palette shared across host profiles.";
      };

      autostart = lib.mkOption {
        type = lib.types.listOf (lib.types.either lib.types.str lib.types.package);
        default = [];
        description = "List of programs/commands to autostart with the desktop session.";
      };
    };
  };

  flake.lib.mkAutostartEntries = autostartList:
    map (entry:
      if lib.isString entry
      then [ (lib.getBin entry) ]
      else [ (lib.getExe entry) ]
    ) autostartList;
}
