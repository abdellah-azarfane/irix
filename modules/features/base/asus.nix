{
  flake.modules.nixos.base =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      # ----Asusctl----
      services.asusd = {
        enable = true;
        enableUserService = true;
      };
      #----- Base services-----
      # Network

      environment.systemPackages = with pkgs; [
        asusctl
        supergfxctl
      ];

      # openrgb
      services.hardware.openrgb.enable = true;
    };
}
