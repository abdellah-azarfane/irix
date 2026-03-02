{
  flake.modules.homeManager.terminals =
    { pkgs, ... }:
    {
      programs.kitty = {
        settings = {
          background_opacity = 1.0; # NOTE: This goes on top of the compositor's transparency
          background = "#0d0401ec";
          foreground = "#C5C9C7";
          selection_background = "#75a168ff";
          selection_foreground = "#C5C9C7";
          url_color = "#72A7BC";
          cursor = "#C5C9C7";
          cursor_text_color = "#200e01ff";
          # Tabs
          active_tab_background = "#090E13";
          active_tab_foreground = "#C5C9C7";
          inactive_tab_background = "#0d0d0dff";
          inactive_tab_foreground = "#A4A7A4";
          # Normal
          color0 = "#301702ff";
          color1 = "#c4746e";
          color2 = "#8a9a7b";
          color3 = "#c4b28a";
          color4 = "#8ba4b0";
          color5 = "#a292a3";
          color6 = "#8ea4a2";
          color7 = "#C8C093";
          # Bright
          color8 = "#A4A7A4";
          color9 = "#E46876";
          color10 = "#87a987";
          color11 = "#E6C384";
          color12 = "#7FB4CA";
          color13 = "#938AA9";
          color14 = "#7AA89F";
          color15 = "#C5C9C7";
          # Extended
          color16 = "#b6927b";
          color17 = "#b98d7b";
        };
      };
    };
}
