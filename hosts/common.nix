# Common configuration shared across all hosts
# Inspired by patterns from rhodium, misterio77, and mic92
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Import common system modules
  imports = [
    ../modules
  ];

  stylix = {
    enable = true;
    base16Scheme = "${inputs.stylix}/base16/schemes/catppuccin-mocha.yaml";
  };

  # Common Home Manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs outputs; };
    users."zayron" = {
      imports = [
       # inputs.stylix.homeModules.stylix
        ../user
      ];
      # Note: nixpkgs options are disabled when useGlobalPkgs is enabled
      # The system nixpkgs config (from modules/utils/nix.nix) will be used automatically
    };
  };
}

