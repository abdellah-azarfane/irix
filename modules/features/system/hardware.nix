{ ... }:
{
  flake.nixosModules.hardware =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      # Bootloader & Kernel
      # Bootloader & Kernel
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.kernelPackages = pkgs.linuxPackages_zen;
      boot.consoleLogLevel = 4;
      boot.supportedFilesystems = [ "ntfs" ];
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
      # Initrd (Hardware specific)
      boot.initrd.availableKernelModules = lib.mkDefault [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      # Kernel Parameters
      boot.kernelParams = [
        "intel_pstate=active"
        "nvidia-drm.fbdev=1"
        "vt.global_cursor_default=0"
        "nowatchdog"
      ];
      # Merged Kernel Modules
      boot.kernelModules = [
        "v4l2loopback"
        "kvm-intel"
        "asus-nb-wmi"
        "asus_armoury"
      ];
      # Merged Extra Module Packages
      boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      # Extra Modprobe Config
      boot.extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Virtual Camera" exclusive_caps=1
      '';
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
      };
      programs.solaar.enable = true;

      # Power & Thermal Management
      powerManagement.powertop.enable = true;
    };
}
