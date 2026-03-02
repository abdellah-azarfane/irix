{
  flake.modules.homeManager.graphic =
    { pkgs, config, ... }:
    {
      home.packages = with pkgs; [
        oculante # Portable image viewer and editor written in Rust
      ];

      home.file."${config.home.homeDirectory}/.local/share/oculante/config.json" = {
        source = ./config.json;
      };
    };
}
