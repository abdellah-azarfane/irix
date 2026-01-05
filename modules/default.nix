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

   ./disk-boot
   ./drivers
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
     ];
 }
