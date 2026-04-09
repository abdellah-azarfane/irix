# Irix Flake Architecture

This document explains how host configuration is assembled in this repository, focusing on:
- `modules/parts.nix`
- `modules/hosts/profiles/*`
- `modules/hosts/main/*`

## 1) `modules/parts.nix`

`modules/parts.nix` defines shared flake-parts options and helper functions used by the rest of the tree.

Key responsibilities:
- Defines reusable flake library options under `flake.lib.*`
  - `defaultSystems`
  - `theme` / `themeNoHash`
  - `nvimWrapper`
  - `mkWhichKeyExe`
  - `diskoConfigurations`
  - `wrapperModules`
  - `mkNixos`
- Sets `flake.lib.defaultSystems` to Linux-only systems from `lib.systems.flakeExposed`.
- Defines `flake.lib.mkNixos` as your standard wrapper around `inputs.nixpkgs.lib.nixosSystem`.
- Sets flake-parts `systems` from `flake.lib.defaultSystems`.

In short: this file is the shared foundation and helper layer.

## 2) Profiles Layer: `modules/hosts/profiles/*`

`modules/hosts/profiles/default.nix` is the profile index and imports:
- `home-manager.nix`
- `base.nix`
- `laptop.nix`
- `server.nix`
- `main-workstation.nix`

### `home-manager.nix`
Declares `flake.nixosModules.homeManager` and imports official Home Manager NixOS module:
- `inputs.home-manager.nixosModules.home-manager`

Also sets common HM defaults:
- `home-manager.useGlobalPkgs = true`
- `home-manager.useUserPackages = true`
- `home-manager.backupFileExtension = "backup"`

### `base.nix`
Declares `flake.nixosModules.hostProfileBase` and imports core base modules including `self.nixosModules.homeManager`.

This ensures Home Manager is available for all host profiles built on base.

### `main-workstation.nix`
Declares `flake.nixosModules.hostProfileMainWorkstation` and adds host-specific values such as:
- user account config
- monitor preferences
- `home-manager.users.${config.preferences.user.name}.home.stateVersion`

In short: profile files define reusable host role composition and shared defaults.

## 3) Main Host Layer: `modules/hosts/main/*`

### `modules/hosts/main/config.nix`
Defines:
- `flake.nixosModules.MainWorkstation`
- imports `self.nixosModules.hostProfileMainWorkstation`

This file turns a profile into a concrete NixOS module for the main machine.

### `modules/hosts/main/default.nix`
Defines:
- `flake.nixosConfigurations.main = self.lib.mkNixos { ... }`

It sets:
- `system = "x86_64-linux"`
- module list containing `self.nixosModules.MainWorkstation`

This is the final NixOS configuration output entrypoint for the host `main`.

## 4) Build Path Summary

Evaluation path for the main host is:
1. `flake.nixosConfigurations.main`
2. `self.nixosModules.MainWorkstation`
3. `self.nixosModules.hostProfileMainWorkstation`
4. `self.nixosModules.hostProfileBase`
5. `self.nixosModules.homeManager`
6. `inputs.home-manager.nixosModules.home-manager`

So HM is integrated through your profile stack, not standalone home configurations.

## 5) Home Manager Evaluation Checks

The following checks are valid in this repo:

```bash
nix eval path:$PWD#nixosConfigurations.main._type
nix eval path:$PWD#nixosConfigurations.main.config.home-manager.useGlobalPkgs
nix eval path:$PWD#nixosConfigurations.main.config.home-manager.useUserPackages
nix eval --raw path:$PWD#nixosConfigurations.main.config.home-manager.users.abosafiya.home.stateVersion
```

Expected values currently:
- `_type` -> `"configuration"`
- `useGlobalPkgs` -> `true`
- `useUserPackages` -> `true`
- `home.stateVersion` -> `26.05`
