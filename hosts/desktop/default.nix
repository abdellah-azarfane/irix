# Desktop host configuration
# Host-specific overrides and additions
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Import common configuration shared across all hosts
  imports = [
    ../common.nix
  ];

  diskBoot = {
    enable = true;
    profile = "desktop";
  };

  # Desktop-specific configuration
  # Add any desktop-specific overrides here

  # Example: Desktop-specific hardware settings
  # hardware.video.enable = true;
  # services.xserver.enable = true;
}

