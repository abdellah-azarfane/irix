set shell := ["zsh", "-cu"]

# Format Nix
fmt:
  nix fmt

# Flake checks (won't write flake.lock)
check:
  nix flake check --no-write-lock-file

# Switch hosts
switch-laptop:
  sudo nixos-rebuild switch --flake .#laptop

switch-desktop:
  sudo nixos-rebuild switch --flake .#desktop

switch-khadim:
  sudo nixos-rebuild switch --flake .#khadim
