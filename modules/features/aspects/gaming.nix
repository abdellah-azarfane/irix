{ self, inputs, ... }: {
  flake.nixosModules.gaming =
    {
      pkgs,
      lib,
      ...
    }:
    {

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

        mangohud

        r2modman

        er-patcher
        lsfg-vk
        lsfg-vk-ui
      ];

    };
}
