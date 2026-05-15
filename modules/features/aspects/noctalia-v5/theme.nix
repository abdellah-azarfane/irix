{
  flake.nixosModules.noctalia-theme = { config, lib, ... }: {

    irix.apps.noctalia.files."config.toml" = {

      # [theme] Configuration
      theme = {
        mode = "dark";                  # dark | light | auto
        source = "wallpaper";             # builtin | wallpaper | community | custom
       # builtin = "Noctalia";           # bundled palette name
        community_palette = "Oxocarbon";# community palette name when source = "community"
        custom_palette = "MyPalette";   # file name (without .json) when source = "custom"
        wallpaper_scheme = "m3-content";# generator used when source = "wallpaper"

        # [theme.templates]
        # Merged the documentation examples into a single configuration block
        templates = {
          enable_builtin_templates = true;
          enable_community_templates = true;

          # opt-in; run: noctalia theme --list-templates
          builtin_ids = [ "foot" "gtk3" "gtk4" "qt5" "qt6" ];

          # opt-in; fetched from api.noctalia.dev/templates
          community_ids = [ "kitty" "walker" "vscode" ];

          enable_user_templates = true;
          user_config = "~/.config/noctalia/user-templates.toml";
        };
      };

    };
  };
}
