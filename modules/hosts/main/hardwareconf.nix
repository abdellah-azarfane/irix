{ ... }:
{
  flake.nixosModules.MainWorkstationHardwareConfig =
     {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix") ];

      boot.initrd.availableKernelModules = lib.mkDefault [
        "xhci_pci"
        "thunderbolt"
        "vmd"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      boot.kernelParams = [
        "quiet"
        "splash"
        "intel_pstate=active" # Modern Intel scaling for Zen
        "nvidia-drm.fbdev=1"
      ];
      boot.kernelModules = [
        "kvm-intel"
        "asus-nb-wmi"
        "asus_armoury"
      ];
      boot.extraModulePackages = [ ];
      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  }
