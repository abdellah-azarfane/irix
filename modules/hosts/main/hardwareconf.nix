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
    let
      facterReport = builtins.fromJSON (builtins.readFile ./facter.json);
      hasFacterReport = facterReport != { };
    in {
      # Keep scanner fallback until facter.json contains real detected data.
      imports = lib.optional (!hasFacterReport) (modulesPath + "/installer/scan/not-detected.nix");

      # Enable nix-facter by pointing to a host-local report file.
      # Replace this placeholder JSON with real output from nixos-facter.
      hardware.facter.reportPath = ./facter.json;

      # Keep these as defaults so facter can override with higher-priority values.
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
      ];
      boot.kernelModules = lib.mkDefault [
        "binder_linux"
        "ashmem_linux"
        "kvm-intel"
        "asus-nb-wmi"
        "asus_armoury"
      ];
      boot.extraModprobeConfig = ''
        options binder_linux
        options ashmem_linux
      '';
      boot.extraModulePackages = [ ];
      networking.useDHCP = lib.mkDefault true;
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
  }
