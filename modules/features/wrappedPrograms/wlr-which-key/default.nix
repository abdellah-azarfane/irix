{
  inputs,
  self,
  lib,
  ...
}:
let
  mkWhichKey =
    pkgs: menu:
    (self.lib.wrapperModules.which-key.apply {
      inherit pkgs;
      settings = {
        inherit menu;

        font = "JetBrainsMono Nerd Font 12";

        # --- Stylish & Transparent Fallback ---
        # Using #RRGGBBAA hex codes (cc = ~80% opacity)
        background = "#1a1b26cc";
        color = "#c0caf5";
        border = "#7aa2f7";

        separator = " ➜ ";
        border_width = 2;
        corner_r = 12;
        padding = 20;
        rows_per_column = 5;
        column_padding = 25;

        anchor = "bottom-right";
        margin_right = 15;
        margin_bottom = 15;
        margin_left = 15;
        margin_top = 0;
      };
    }).wrapper;
in
{
  flake.mkWhichKeyExe = pkgs: menu: lib.getExe (mkWhichKey pkgs menu);

  flake.lib.wrapperModules.which-key = inputs."wrapper-modules".lib.wrapModule (
    {
      config,
      lib,
      ...
    }:
    let
      yamlFormat = config.pkgs.formats.yaml { };
    in
    {
      options = {
        settings = lib.mkOption {
          type = yamlFormat.type;
        };
      };

      config = {
        package = config.pkgs.wlr-which-key;

        addFlag = [
          (toString (yamlFormat.generate "config.yaml" config.settings))
        ];
      };
    }
  );
}
