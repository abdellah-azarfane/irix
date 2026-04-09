{ lib, inputs, config, ... }:
{
  options.flake.lib.defaultSystems = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Default systems used for perSystem evaluation.";
  };

  options.flake.lib.theme = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = "Theme color palette exported by this flake.";
  };

  options.flake.lib.themeNoHash = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = {};
    description = "Theme color palette without leading # exported by this flake.";
  };

  options.flake.lib.nvimWrapper = lib.mkOption {
    type = lib.types.raw;
    default = null;
    description = "Custom Neovim wrapper module exported by this flake.";
  };

  options.flake.lib.mkWhichKeyExe = lib.mkOption {
    type = lib.types.raw;
    default = null;
    description = "Helper function to build which-key wrapper executables.";
  };

  options.flake.lib.diskoConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Disko configuration modules exported by this flake.";
  };

  options.flake.lib.wrapperModules = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = {};
    description = "Custom wrapper modules exported by this flake.";
  };

  options.flake.lib.mkNixos = lib.mkOption {
    type = lib.types.raw;
    default = null;
    description = "Helper to build NixOS hosts with consistent defaults.";
  };

  config = {
    flake.lib.defaultSystems = builtins.filter (lib.hasSuffix "-linux") lib.systems.flakeExposed;

    flake.lib.mkNixos =
      {
        system,
        modules,
        extraSpecialArgs ? {},
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        } // extraSpecialArgs;
        modules = modules ++ [
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
          }
        ];
      };

    systems = lib.mkDefault config.flake.lib.defaultSystems;
  };
}
