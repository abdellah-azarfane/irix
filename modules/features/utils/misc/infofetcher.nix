{
  flake.modules.homeManager.utils =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        fastfetch # Faster disfetch
        via # GUI for adjusting RGB lighting
        cowsay # Generate ASCII pictures using a cow
        cmatrix # We all know what this is
        ascii # Interactive ASCII name and symbol chart
        trash-cli # Interact with trashcan
      ];
      xdg.configFile."fastfetch/config.jsonc" = {
        source = ./fastfetch/config.jsonc;
        force = true;
      };
    };
}
