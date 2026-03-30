{self, ...}: {
  flake.nixosModules.gtk = {
    pkgs,
    config,
    lib,
    ...
  }: let
    #  Define your custom Gruvbox overrides
    theme-name = "Gruvbox-Green-Dark-Medium";
    theme-package = pkgs.gruvbox-gtk-theme.override {
      colorVariants = ["dark"];
      sizeVariants = ["standard"];
      themeVariants = ["green"];
      tweakVariants = ["medium" "macos"];
    };

    icon-theme-name = "Gruvbox-Plus-Dark";
    icon-theme-package = pkgs.gruvbox-plus-icons;
  in {
    # dconf MUST be enabled at the system level for Home Manager to interact with it
    programs.dconf.enable = true;

    # Setting the global environment variable
    environment.variables = {
      GTK_THEME = theme-name;
    };
    home-manager.users.${config.preferences.user.name} = {
      gtk = {
        enable = true;
        theme = {
          name = theme-name;
          package = theme-package;
        };

        iconTheme = {
          name = icon-theme-name;
          package = icon-theme-package;
        };

        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      };

      # Set the system color scheme preference in dconf
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };
  };
}
