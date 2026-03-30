{
  flake.nixosModules.info = { pkgs, config, ... }:
   let
    user = config.preferences.user.name;

    logoDir = ../fastfetch/logos;
      random-fastfetch = pkgs.writeShellScriptBin "fastfetch" ''
        LOGO_DIR="${logoDir}"
        RANDOM_LOGO=$(${pkgs.findutils}/bin/find "$LOGO_DIR" -type f \( \
          -iname "*.svg" -o \
          -iname "*.png" -o \
          -iname "*.jpg" -o \
          -iname "*.jpeg" -o \
          -iname "*.webp" -o \
          -iname "*.gif" -o \
          -iname "*.bmp" \
        \) | ${pkgs.coreutils}/bin/shuf -n 1)
        if [ -n "$RANDOM_LOGO" ]; then
          exec ${pkgs.fastfetch}/bin/fastfetch --logo "$RANDOM_LOGO" --logo-height 15 "$@"
        else
          exec ${pkgs.fastfetch}/bin/fastfetch "$@"
        fi
      '';
    in
    {
    home-manager.users.${user} = {
      home.packages = with pkgs; [
        random-fastfetch
        via # GUI for adjusting RGB lighting
        cowsay # Generate ASCII pictures using a cow
        cmatrix # We all know what this is
        ascii # Interactive ASCII name and symbol chart
        trash-cli # Interact with trashcan
      ];
      xdg.configFile."fastfetch/config.jsonc" = {
        source = ../fastfetch/config.jsonc;
        force = true;
      };
    };
  };
}
