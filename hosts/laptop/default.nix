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
     ../../modules/apps
     ../../modules/desktop
     ../common.nix
     ../../modules/utils
     ../../modules/virtualization
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
    asusKeyboardBacklight.enable = true;
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
