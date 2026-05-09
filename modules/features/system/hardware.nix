{ ... }:
{
  flake.nixosModules.hardware = { pkgs, config,... }:
    {
    # Bootloader & Kernel
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
    '';
    boot.supportedFilesystems = [ "ntfs" ];
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    # Hardware Support
    hardware.uinput.enable = true;
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.cpu.intel.updateMicrocode = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true; # Needed for modern headset battery/mic features
          Enable = "Source,Sink,Media,Socket";
          ControllerMode = "bredr"; # CRITICAL: Allows both BR/EDR and LE
          FastConnectable = true;
        };
      };
    };

   hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true; # NOTE: Adds solaar
    };

    # Power & Thermal Management
    powerManagement.powertop.enable = true;
    };
}
