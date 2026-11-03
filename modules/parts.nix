{
  lib,
  inputs,
  config,
  self,
  ...
}:
{
  options.flake = {
    mkWhichKeyExe = lib.mkOption {
      type = lib.types.raw;
      default = null;
      description = "Build a wlr-which-key executable from a menu tree.";
    };

    wrappersModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = { };
      description = "Wrapper-manager modules exported at flake.wrappersModules.";
    };

    lib = {
      defaultSystems = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "Default systems used for perSystem evaluation.";
      };
      theme = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = {
          bg = "#282828";
          fg = "#ebdbb2";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          purple = "#b16286";
          aqua = "#689d6a";
          orange = "#d65d0e";
        };
        description = "Shared color palette (Gruvbox-inspired).";
      };
      mkNiriBinds = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Helper to convert keymap preferences to Niri bind format.";
      };
      mkNiriOutputs = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Helper to convert monitor preferences to Niri output format.";
      };
      mkAutostartEntries = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Helper to convert autostart preferences to systemd service entries.";
      };
      mkShellAliases = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Shared shell alias builder exported by the flake.";
      };
      mkFishShellInit = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Shared fish shell initialization snippet exported by the flake.";
      };
      diskoConfigurations = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = { };
        description = "Disko configuration modules exported by this flake.";
      };
      wrapperModules = lib.mkOption {
        type = lib.types.lazyAttrsOf lib.types.raw;
        default = { };
        description = "Custom wrapper modules exported by this flake.";
      };
      mkNixos = lib.mkOption {
        type = lib.types.raw;
        default = null;
        description = "Helper to build NixOS hosts with consistent defaults.";
      };
    };
  };

  config = {
    flake.lib.defaultSystems = builtins.filter (lib.hasSuffix "-linux") lib.systems.flakeExposed;

    flake.lib.mkNixos =
      {
        system,
        modules,
        extraSpecialArgs ? { },
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs self;
        }
        // extraSpecialArgs;
        modules = modules ++ [
          {
            nixpkgs.hostPlatform = lib.mkDefault system;
          }
        ];
      };

    systems = lib.mkDefault config.flake.lib.defaultSystems;

    perSystem =
      { system, ... }:
      {
        checks = lib.mapAttrs' (
          name: cfg:
          lib.nameValuePair "nixos-${name}" cfg.config.system.build.toplevel
        ) (
          lib.filterAttrs (
            _: cfg: cfg.pkgs.stdenv.hostPlatform.system == system
          ) config.flake.nixosConfigurations
        );
      };
  };
}
