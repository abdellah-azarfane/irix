{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    kernelPackages =
      if pkgs ? linuxPackages_cachyos then pkgs.linuxPackages_cachyos
      else if pkgs ? linuxPackages_cachy then pkgs.linuxPackages_cachy
      else pkgs.linuxPackages_zen;
  };
}
