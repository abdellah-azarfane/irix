# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
   ./apps
   ./desktop
   ./disk-boot
   ./hardware
   ./integration
   ./maintenance
   ./manager
   ./network
   ./rules
   ./security
   ./services
   ./shell
   ./users
   ./utils
   ./virtualization
     ];

  # Modules
  # ---------------------------------
  # Display Manager
  manager = {
    gdm.enable = false;
    sddm.enable = true;
  };

  # Extra Services
  extraServices = {
#    asusKeyboardBacklight.enable = true;
    laptopLid.enable = true;
  };

  # Extra rules
  extraRules = {
    keychronUdev.enable = true;
    hdmiAutoSwitch.enable = true;
  };
  # Garbage override
  maintenance.nhClean = {
    enable = true;
    schedule = "daily";       # ou weekly
    deleteOlderThan = "7d";   # supprime les vieilles générations
  };

}
