{ inputs, ... }: {
  flake.nixosModules.core =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      imports = [ inputs.nix-index-database.nixosModules.nix-index ];

      time.timeZone = "Africa/Casablanca";

      i18n = {
        defaultLocale = "en_US.UTF-8";
        supportedLocales = [
          "en_US.UTF-8/UTF-8"
          "ar_MA.UTF-8/UTF-8"
          "fr_FR.UTF-8/UTF-8"
        ];
        extraLocaleSettings = {
          LC_ADDRESS = "ar_MA.UTF-8";
          LC_IDENTIFICATION = "ar_MA.UTF-8";
          LC_MEASUREMENT = "ar_MA.UTF-8";
          LC_MONETARY = "ar_MA.UTF-8";
          LC_NAME = "ar_MA.UTF-8";
          LC_NUMERIC = "ar_MA.UTF-8";
          LC_PAPER = "ar_MA.UTF-8";
          LC_TELEPHONE = "ar_MA.UTF-8";
          LC_TIME = "ar_MA.UTF-8";
        };
      };

      console.keyMap = "us";
      services.xserver.xkb.layout = "us";

      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        download-buffer-size = 134217728;
        substituters = [
          "https://cache.nixos.org"
          "https://niri.cachix.org"
          "https://noctalia.cachix.org"
        ];
        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "niri.cachix.org-1:Wv0OmO7PsuocCEzfP24EQoSweUkG9bHoIksv0yXWH9o="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

      users.users.abosafiya.extraGroups = [
        "video"
        "render"
      ];

      programs.nix-index-database.comma.enable = true;

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      programs.appimage = {
        enable = true;
        binfmt = true;
      };

      programs.kdeconnect = {
        enable = true;
        package = pkgs.kdePackages.kdeconnect-kde;
      };

      # Desktop portals
      # NOTE: Niri requires xdg-desktop-portal-gnome for screencasting (not wlr).
      # The programs.niri module already adds xdg-desktop-portal-gnome and niri-portals.conf.
      xdg.portal = {
        enable = true;
        # wlr.enable = true; # DISABLED: wlr portal doesn't work with Niri
        # CRITICAL: This allows Noctalia and GTK4 apps to communicate
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
          xdg-desktop-portal-termfilechooser # Portal for using TUIs as file pickers
        ];
        config.common.default = [ "gtk" ]; # Force 'gtk' portal for settings
        config.niri = {
          "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        };
      };

      environment.systemPackages =
        (with pkgs; [
          # --- Nix --
          nixd # Nix language server (newer)
          nixfmt # Official formatter
          statix # Nix linter
          manix # Nix manual in the terminal
          nix-inspect
          nix-du # Disk usage analyzer for nix store
          nix-melt # Ranger-like flake.lock viewer
          nix-output-monitor # Better nix build output
          nix-prefetch-github # Prefetch sources from github. Useful for computing commit hashes.
          nix-search # Search nix packages
          nix-tree # Explore nix store
          nix-update # Update nix package versions

          # --- Core System Utilities ---
          coreutils # Basic GNU tools
          util-linux # Includes lscpu

          # --- Version Control ---
          hwinfo # Hardware detection tool from openSUSE

          # --- Hardware Information Tools ---
          dmidecode # System hardware details
          inxi # My swiss army knife
          lshw # List hardware
          pciutils # lspci
          read-edid # EDID information
          smartmontools # S.M.A.R.T. monitoring
          upower # D-Bus service for power management
          usbutils # lsusb
          evtest # Live-test keyboards
          libinput # Handle inputs in Wayland

          # --- Audio Tools ---
          alsa-utils # ALSA utilities

          # --- Hardware Testing ---
          stress # Perform stress tests on CPU
        ])
        ++ lib.optionals (pkgs.stdenv.hostPlatform.system == "x86_64-linux") [
          pkgs.bs-manager
        ];
    };
}
