{
  flake.modules.nixos.base =
    { pkgs, ... }:
    {
      programs.nix-ld = {
        enable = true; # Enable execution of unpatched binaries
      };
    };
}
