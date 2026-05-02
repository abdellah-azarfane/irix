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
        extraCompatPackages = with pkgs; [ proton-ge-bin ];
        extraPackages = with pkgs; [ gamescope er-patcher ];
        protontricks.enable = true;
      };
    };

    services.zerotierone.enable = true;

    environment.systemPackages = with pkgs; [
      steam-run
      gamescope
     # lutris
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
      steamtinkerlaunch
      prismlauncher
      lsfg-vk
      lsfg-vk-ui
    ];
  };


}
