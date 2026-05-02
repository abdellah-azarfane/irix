{ ... }:
{
  flake.nixosModules.hardware = { pkgs, ... }:
    {
    # Bootloader & Kernel
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.supportedFilesystems = [ "ntfs" ];
    # Enable emulation so laptop can build for the Pi
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    # Hardware Support
    hardware.uinput.enable = true;
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.cpu.intel.updateMicrocode = true;
    /*
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
   };
  */
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        ControllerMode = "bredr";
        # Explicitly blacklist the LE Audio plugins crashing the connection
        DisablePlugins = "bap,bass,mcp,vcp,micp,ccp,csis";
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
