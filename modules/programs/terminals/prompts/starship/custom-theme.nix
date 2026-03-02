{
  flake.modules.homeManager.terminals =
    { pkgs, ... }:
    let
      c = {
        # Normal
        color0 = "#0d0c0c";
        color1 = "#d46229ff";
        color2 = "#649508ff";
        color3 = "#c48f1dff";
        color4 = "#0e81b7ff";
        color5 = "#95129eff";
        color6 = "#14a296ff";
        color7 = "#b18305ff";
        # Bright
        color8 = "#73b0b7ff";
        color9 = "#ee223aff";
        color10 = "#8def25ff";
        color11 = "#eba728ff";
        color12 = "#29afe9ff";
        color13 = "#6d3becff";
        color14 = "#32edc7ff";
        color15 = "#61efa8ff";
        # Extended
        color16 = "#e1671aff";
        color17 = "#a86145ff";
        color18 = "#0b2a43ff";
        color19 = "#0b3189ff";
        color20 = "#19977dff";
      };

      i = {
        icon01 = "◆";
      };
    in
    let
      viaColor = c.color18;
      colors = c;
    in
    {
      programs.starship.settings = {
        custom.theme = {
          disabled = true;
          command = "echo 'Ix'";
          when = "true";
          format = "[$output]($style) ${i.icon01} ";
          style = "#A4A7A4";
        };
      };
    };
}
