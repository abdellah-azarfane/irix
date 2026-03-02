{
  flake.modules.nixos.base =
    { ... }:
    {
      services.printing = {
        enable = true; # CUPS
      };
    };
}
