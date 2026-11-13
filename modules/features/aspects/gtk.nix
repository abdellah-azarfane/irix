{ self, ... }: {
  flake.nixosModules.gtk =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      theme-name = "adw-gtk3";
      theme-package = pkgs.adw-gtk3;
      icon-theme-name = "Papirus-Dark";
      icon-theme-package = pkgs.papirus-icon-theme;
      username = config.preferences.user.name;
    in
    {
      programs.dconf.enable = true;

      environment.variables = {
        GTK_THEME = "${theme-name}:dark";
        # Force Qt apps to use Wayland natively and respect qt5ct/qt6ct
        QT_QPA_PLATFORM = "wayland;xcb";
        #   QT_QPA_PLATFORMTHEME = "qt5ct";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      home-manager.users.${username} = { config, ... }: {
        xdg.enable = true;
        home.packages = with pkgs; [
          adw-gtk3
          nwg-look
          kdePackages.qt6ct
          kdePackages.qtstyleplugin-kvantum
          kdePackages.breeze-icons
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
          gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
          gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
        };
        qt = {
          enable = true;
          platformTheme.name = "qtct";
          style = {
            name = "kvantum";
            package = pkgs.kdePackages.breeze;
          };
          kvantum = {
            enable = true;
            settings.General.theme = "Breeze";
          };
        };

        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "${theme-name}-dark";
            icon-theme = icon-theme-name;
          };
        };
        # Qt theming (qt5ct/qt6ct color schemes) is now owned by Mandara, which
        # applies app themes live via `mandara msg icons apply` / Studio.
        home.file.".local/share/icons/Papirus-Dark".source =
          "${icon-theme-package}/share/icons/Papirus-Dark";
      };
    };
}
