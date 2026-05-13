{ self, ... }: {
  flake.nixosModules.gtk = { pkgs, config, lib, ... }:
  let
    theme-name = "adw-gtk3";
    theme-package = pkgs.adw-gtk3;
    icon-theme-name = "Papirus-Dark";
    icon-theme-package = pkgs.papirus-icon-theme;
    username = config.preferences.user.name;
  in {
    programs.dconf.enable = true;

    environment.variables = {
      GTK_THEME = "${theme-name}:dark";
      # Force Qt apps to use Wayland natively and respect qt5ct/qt6ct
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    home-manager.users.${username} = { config, ... }: {
      xdg.enable = true;
      home.packages = with pkgs; [
        adw-gtk3
        nwg-look
        kdePackages.qt6ct
        kdePackages.qtstyleplugin-kvantum
        kdePackages.breeze-icons # CRITICAL FOR DOLPHIN
        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum
      ];
      gtk = {
        enable = true;
        theme = {
          name = "${theme-name}-dark"; # Force -dark variant for GTK3 apps
          package = theme-package;
        };
        iconTheme = {
          name = icon-theme-name;
          package = icon-theme-package;
        };
        # Safety flags for legacy apps
        gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
        gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
      };
      qt = {
        enable = true;
        platformTheme.name = "qtct";
      };

     dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "${theme-name}-dark";
          icon-theme = icon-theme-name;
        };
      };
    # Lock qt5ct and qt6ct to the file Noctalia just generated via the IDs above.
    xdg.configFile."qt6ct/qt6ct.conf".text = ''
      [Appearance]
      color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
      custom_palette=true
      standard_dialogs=default
      style=kvantum
    '';

    xdg.configFile."qt5ct/qt5ct.conf".text = ''
      [Appearance]
      color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf
      custom_palette=true
      standard_dialogs=default
      style=kvantum
    '';
    home.file.".local/share/icons/Papirus-Dark".source =
        "${icon-theme-package}/share/icons/Papirus-Dark";
    };
  };
}
