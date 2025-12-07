# Laptop host configuration (barevalor)
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

  # Laptop-specific configuration
  # Add any laptop-specific overrides here

  # Example: Laptop-specific hardware settings
  # hardware.battery.enable = true;
  # hardware.bluetooth.enable = true;

  # Stylix configuration (commented out for now)
  /*
  stylix = {
    # You can set a base16 scheme, or use an image
    # base16Scheme = "${inputs.stylix}/base16/schemes/catppuccin-mocha.yaml";
    # Or use an image to extract colors from
    # image = ../../home/assets/wallpapers/your-wallpaper.jpg;
    
    # Enable theming for various applications
    targets = {
      nixos.enable = false;
    };
  };
  */
}
