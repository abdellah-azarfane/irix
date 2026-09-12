{ self, inputs, ... }: {
  flake.nixosModules.gaming =
    {
      pkgs,
      lib,
      ...
    }:
    {
      hardware.steam-hardware.enable = true;
      programs = {
        gamemode.enable = true;
        gamescope.enable = true;
        steam = {

          enable = true;

          protontricks.enable = true;
        };
      };

      environment.systemPackages = with pkgs; [
        steam-run
        dxvk
        gamescope

        heroic
        mangohud

        r2modman

        er-patcher
        lsfg-vk
        lsfg-vk-ui
      ];

    };
}
