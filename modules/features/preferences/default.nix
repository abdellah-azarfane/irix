{ self, ... }:
{
  flake.nixosModules.preferences = { pkgs, lib, ... }: {
    preferences = {
      user.name = "abosafiya";
      theme = self.lib.theme;

      apps = {
        browser = "helium";
        editor = "zeditor";
        terminal = "kitty";
        imageViewer = "imv";
        videoPlayer = "mpv";
        audioPlayer = "mpv";
        pdfViewer = "zathura";
        wm = "niri";
        pager = "most";
      };

      autostart = [
        # SCripts
      ];

      keymap = {
        "SUPER + v".exec = "${pkgs.alsa-utils}/bin/amixer sset Capture toggle";
        "SUPER + d"."s".package = pkgs.pwvucontrol;
        "SUPER + d"."p".package = pkgs.librewolf;
        "SUPER + d"."y".package = pkgs.yazi;
      };

      optionalServices = {
        greetd = true;
        dmsgreetd = false; # issues
      };

      monitors = {
        "eDP-1" = {
          primary = true;
          width = 1980;
          height = 1080;
          refreshRate = 144.0;
          scale = 1.0;
          x = 0;
          y = 0;
        };
        "DP-1" = {
          primary = false;
          width = 1600;
          height = 900;
          scale = 1.0;
          refreshRate = 75.0;
          x = 1920;
          y = 0;
        };
        "HDMI-A-1" = {
          primary = false;
          width = 1920;
          height = 1080;
          scale = 1.0;
          refreshRate = 60.0;
          x = 3520;
          y = 0;
        };
      };
    };
  };
}
