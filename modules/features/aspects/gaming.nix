{ self, lib, ... }: {
  
  flake.nixosModules.gaming = { pkgs, config, ... }: {

    # Ensure graphics drivers are actually enabled
    hardware.graphics.enable = lib.mkDefault true;

    programs = {
      gamemode.enable = true;
      
      # Superior gamescope arguments
      gamescope = {
        enable = true;
        capSysNice = true;
        args = ["--rt" "--expose-wayland"];
      };

      steam = {
        enable = true;
        
        # Allows Monado/WiVRn to be used
        package = pkgs.steam.override {
          extraProfile = ''
            unset TZ
            export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
          '';
        };

        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        extraPackages = with pkgs; [ SDL2 gamescope er-patcher ];
        protontricks.enable = true;
      };
    };

    services.zerotierone.enable = true;

    environment.systemPackages = with pkgs; [
      steam-run
      gamescope
      lutris
      wine
      winetricks
      gamemode
      dxvk
      wineWow64Packages.staging
      heroic
      mangohud
      protonup-qt
      protonup-ng
      r2modman
      er-patcher
      bottles
      steamtinkerlaunch
      prismlauncher
      lsfg-vk
      lsfg-vk-ui
      
      # Custom WoW Launcher
      self.packages.${pkgs.stdenv.hostPlatform.system}.wow-launcher
    ];
  };

  # Custom WoW Launcher Definition
  perSystem = { pkgs, ... }: {
    packages.wow-launcher = pkgs.writeShellApplication {
      name = "wow-launcher";
      runtimeInputs = with pkgs; [
        (wineWow64Packages.full.override {
          wineRelease = "staging";
          mingwSupport = true;
        })
        winetricks
        vulkan-loader
        dxvk
      ];
      text = ''
        export WINEPREFIX="$HOME/Games/Wow"
        export WINEARCH=win64
        export WINEDEBUG="-all"
        export DRI_PRIME=1
        export DXVK_HUD=1
        export DXVK_DEVICE_SELECT=1

        BNET_EXE="$WINEPREFIX/drive_c/Program Files (x86)/Battle.net/Battle.net.exe"
        WOW_EXE="$WINEPREFIX/drive_c/Program Files (x86)/World of Warcraft/_retail_/Wow.exe"
        INSTALLER="Battle.net-Setup.exe"

        if [ ! -d "$WINEPREFIX" ]; then
          echo "Initializing new Wine prefix..."
          mkdir -p "$WINEPREFIX"
          wineboot -u
        fi

        if [ -f "$WOW_EXE" ]; then
          echo "Launching WoW via DXVK..."
          wine "$WOW_EXE"
          exit 0
        fi

        if [ ! -f "$BNET_EXE" ]; then
          if [ -f "$INSTALLER" ]; then
            wine "$INSTALLER"
          else
            echo "Installer not found. Please download Battle.net-Setup.exe"
            exit 1
          fi
        else
          wine "$BNET_EXE"
        fi
      '';
    };
  };
}