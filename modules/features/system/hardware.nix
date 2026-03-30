{ ... }:
{
  flake.nixosModules.hardware = { pkgs, ... }:
    {
    # Bootloader & Kernel
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_zen;

    # Hardware Support
    hardware.uinput.enable = true;
    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;
    hardware.cpu.intel.updateMicrocode = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = true; # NOTE: Adds solaar
    };

    # Power & Thermal Management
    services.auto-cpufreq.enable = true;
    services.auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
    powerManagement.powertop.enable = true;
    services.tlp.enable = true;
    };
}
