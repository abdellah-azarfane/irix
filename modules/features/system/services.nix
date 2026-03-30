{ self, lib, ... }: {
  flake.nixosModules.services = { pkgs, ... }: {
    
    # Audio with Noise Canceling
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      extraConfig = {
        # cooler denoising
        pipewire."99-input-denoising" = {
          "context.modules" = [
            {
              "name" = "libpipewire-module-filter-chain";
              "args" = {
                "node.description" = "DeepFilter Noise Cancelling Source";
                "media.name" = "DeepFilter Noise Cancelling Source";
                "filter.graph" = {
                  "nodes" = [
                    {
                      "type" = "ladspa";
                      "name" = "DeepFilter Mono";
                      "plugin" = "${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so";
                      "label" = "deep_filter_mono";
                      # "control" = {
                      #   "Attenuation Limit (dB)" = cfg.source.attenuation;
                      # };
                    }
                  ];
                };
                "audio.rate" = 48000;
                "capture.props" = {
                  "node.name" = "deep_filter_mono_input";
                  "node.passive" = true;
                };
                "playback.props" = {
                  "node.name" = "deep_filter_mono_output";
                  "media.class" = "Audio/Source";
                };
              };
            }
          ];
        };
      };
    };

    preferences.keymap = {
      "SUPER + v".exec = ''${pkgs.alsa-utils}/bin/amixer sset Capture toggle'';
      "SUPER + d"."s".package = pkgs.pwvucontrol;
    };


    # Hardware Daemons
    systemd.services.supergfxd.path = [pkgs.pciutils pkgs.kmod];
    services.upower.enable = true;
    # Abstraction for enumerating power devices
    services.printing.enable = true; # CUPS
    services.udisks2.enable = true;
    services.blueman.enable = true;
    services.udev.enable = true; # Enable device manager
    services.flatpak.enable = true;
    services.hardware.openrgb = {enable = true;};
    services.asusd.enable = true;
    services.dbus.enable = true;
    # Required for niri wm
    services.dbus.packages = [ pkgs.nautilus ];
    # Required by xdg-desktop-portal-gnome for file chooser dialogs
    
    # AI Services
    services.ollama = {
      enable = true;
      package = pkgs.ollama-rocm;
      loadModels = [
          # "llama3.1"
          # "mistral"
        ];
    };
    # Flatpak app installation is not managed by the built-in NixOS flatpak module.
    # Keep remote setup below; install apps with `flatpak install` or a dedicated module.

    # Networking & Security
    networking.networkmanager.enable = true;
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

    # Increase memory lock limit for vmtouch browser preloading
    # Firefox + Brave = ~500-800MB of binaries to lock
    # Setting to 2GB to be safe (unlimited would also work)
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
    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target"];
      path = [pkgs.flatpak];
      script = ''flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo'';
    };

    environment.systemPackages = with pkgs; [ 
      # --- System Packages ---
      brightnessctl # Read & control device brightness
      ddcutil # Gamma & temperature set fallback for hardware control
      # gammastep # Gamma & temperature set for wayland # NOTE: Very flimsy
      # geoclue2 # Geolocation framework for gammastep
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
      pandoc # PDF manipulation
      poppler-utils # For PDF previews (pdftotext)
      tui-journal # Rust TUI for note-taking

      # --- Documentation ---
      # tldr # Simplified and community-driven man pages
      # tlrc # Official tldr client written in Rust (includes tlrd)
      tealdeer # Alternative fast Rust client
      wikiman # Offline search engine for Linux packages

      # --- Misc ---
      bc # CLI calculator
      binutils # Tools for manipulating binaries
      just # Handy way to save and run project-specific commands
      mask # CLI task runner defined by a simple markdown file
      mprocs # TUI tool to run multiple commands in parallel and show the output of each command separately
      presenterm # Terminal based slideshow tool
      hstr # Shell history suggest box (bound to <C-H> on Shell)
      ispell # Interactive spell checker (used by Doom Emacs)

      # --- disk ---
      duf # Yet another disk utility
    ];
  };
}