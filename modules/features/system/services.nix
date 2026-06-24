{ self, lib, ... }: {
  flake.nixosModules.services =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.features.optionalServices;
    in
    {
      options.features.optionalServices = {
        greetd = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable greetd login manager service";
        };

        xserver = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable X server service";
        };

        pipewire = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable PipeWire audio stack";
        };

        upower = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable UPower daemon";
        };
        ppd = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable Power Profiles Daemon";
        };

        tuned = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable Tuned";
        };

        printing = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable printing via CUPS";
        };

        udisks2 = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable UDisks2 device management";
        };

        blueman = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable Blueman Bluetooth manager service";
        };

        flatpak = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable Flatpak and auto-configure Flathub remote";
        };

        openrgb = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable OpenRGB hardware control service";
        };

        asusd = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable ASUS daemon";
        };

        ollama = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Enable Ollama service";
        };
      };

      config = {
        # Audio with Noise Canceling
        security.rtkit.enable = true;
        services.pipewire = {
          enable = cfg.pipewire;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };

        # Hardware Daemons
        systemd.services.supergfxd.path = [
          pkgs.pciutils
          pkgs.kmod
        ];
        services.upower.enable = lib.mkDefault cfg.upower;
        services.power-profiles-daemon.enable = lib.mkDefault cfg.ppd;
        services.tuned.enable = lib.mkDefault cfg.tuned;

        # Abstraction for enumerating power devices
        services.printing.enable = cfg.printing; # CUPS
        services.udisks2.enable = cfg.udisks2;
        services.blueman.enable = cfg.blueman;

        # 3. Prevent the Kernel from "autosuspending" your Bluetooth USB controller
        boot.kernelParams = [ "btusb.enable_autosuspend=n" ];

        services.pipewire = {
          wireplumber = {
            enable = true;
            # Tell WirePlumber to only use A2DP (Stereo Audio) and ignore HFP/HSP (Microphone)
            extraConfig = {
              "10-bluez-disable-hfp" = {
                "monitor.bluez.properties" = {
                  "bluez5.roles" = [
                    "a2dp_sink"
                    "a2dp_source"
                  ];
                };
              };
            };
          };
        };
        services.udev.enable = true; # Enable device manager
        services.flatpak.enable = cfg.flatpak;
        services.hardware.openrgb = {
          enable = cfg.openrgb;
        };
        services.asusd.enable = cfg.asusd;
        services.dbus.enable = true;
        services.dbus.implementation = "broker";
        # Required for niri wm
        services.dbus.packages = [ pkgs.nautilus ];
        # AI Services
        services.ollama = {
          enable = cfg.ollama;
          package = pkgs.ollama-cuda;
          loadModels = [
            # "llama3.1"
            # "mistral"
          ];
        };
        systemd.services.ollama.serviceConfig = {
          MemorySwapMax = "0";
          MemoryMax = "6G";
          OOMScoreAdjust = 500;
        };

        # Networking & Security
        networking.networkmanager.enable = true;
        services.xserver.enable = cfg.xserver;
        networking.firewall = {
          enable = false;
          checkReversePath = "loose";
        };
        security.polkit.enable = true;

        security.pam.services = {
          login.enableGnomeKeyring = true;
          # Enable Gnome keyring on login # FIX: This is flimsy. Sometimes it unlocks, sometimes it does not.
          hyprlock.enableGnomeKeyring = true; # Enable unlocking keyring on unlock lockscreen
        };

        security.pam.loginLimits = [
          {
            domain = "*";
            type = "soft";
            item = "memlock";
            value = "2097152"; # 2GB in KB
          }
          {
            domain = "*";
            type = "hard";
            item = "memlock";
            value = "2097152"; # 2GB in KB
          }
        ];

        # Flatpak Auto-Config
        systemd.services.flatpak-repo = lib.mkIf cfg.flatpak {
          wantedBy = [ "multi-user.target" ];
          path = [ pkgs.flatpak ];
          script = "flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo";
        };
        # --- Location Configuration (Dynamic) ---
        location.provider = "geoclue2";
        services.geoclue2 = {
          enable = true;
          # Allow specific apps like gammastep to access location
          appConfig.gammastep = {
            isAllowed = true;
            isSystem = false;
          };
        };

        environment.systemPackages = with pkgs; [
          # --- System Packages ---
          brightnessctl # Read & control device brightness
          ddcutil # Gamma & temperature set fallback for hardware control
          gammastep # Gamma & temperature set for wayland # NOTE: Very flimsy
          geoclue2 # Geolocation framework for gammastep
          wdisplays # GUI for exploring and setting monitor options
          wlsunset # Gamma & temperature set for wayland supporting wlr-gamma-control-unstable-v1
          pamixer # Pulseaudio command line mixer
          pavucontrol # GUI audio control
          playerctl # Media player control
          wireplumber # Session manager for pipewire

          # --- Screenshot And Image Tools ---
          # flameshot # Screenshot utility
          grim # Screenshot utility for Wayland
          gtk3 # Includes gtk-launch
          satty
          slurp # Interactive area selection
          swappy # Screenshot annotation tool
          tesseract # OCR Engine

          # --- Clipboard Utilities ---
          clipman # Clipboard manager for Wayland
          wl-clipboard # Wayland clipboard utilities

          # --- Utils ---
          comma # Runs programs without installing them
          fontforge # For font previews
          ghostscript # Postscript interpreter
          mermaid-cli # Generation of mermaid diagrams in text
          poppler-utils # For PDF previews (pdftotext)
          tui-journal # Rust TUI for note-taking

          # --- Documentation ---
          # tldr # Simplified and community-driven man pages
          # tlrc # Official tldr client written in Rust (includes tlrd)
          tealdeer # Alternative fast Rust client
          wikiman # Offline search engine for Linux packages

          # --- Misc ---
          binutils # Tools for manipulating binaries
          presenterm # Terminal based slideshow tool
          hstr # Shell history suggest box (bound to <C-H> on Shell)
          ispell # Interactive spell checker (used by Doom Emacs)

          # --- disk ---
          duf # Yet another disk utility
        ];
      };
    };
}
