{ self, ... }:
{
  flake.nixosModules.preferences = { pkgs, lib, ... }: {
    preferences = {
      user.name = "abosafiya";
      theme = self.lib.theme;

      apps = {
        browser = "brave";
        editor = "nvim";
        terminal = "kitty";
        imageViewer = "imv";
        videoPlayer = "mpv";
        audioPlayer = "mpv";
        pdfViewer = "zathura";
        wm = "niri";
        pager = "most";
      };

      autostart = [
        ''
          ${pkgs.bash}/bin/bash ${../wallpaper/rotate-wallpaper.sh} "$HOME/wallpapers" "$HOME/.cache/irix/current-wallpaper"
        ''
      ];

      keymap = {
        "SUPER + v".exec = ''${pkgs.alsa-utils}/bin/amixer sset Capture toggle'';
        "SUPER + d"."s".package = pkgs.pwvucontrol;
        "SUPER + d"."f".package = pkgs.firefox;
        "SUPER + d"."p".package = pkgs.brave;
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
        "HDMI-A-1" = {
          primary = false;
          width = 1920;
          height = 1080;
          scale = 1.0;
          refreshRate = 60.0;
          x = 2560;
          y = 0;
        };
      };
    };
  };
}