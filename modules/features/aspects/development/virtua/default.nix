{ self, lib, ... }: {
  flake.nixosModules.virt = { pkgs, config, ... }: let
    user = config.preferences.user.name;in {
    system.Packages = with pkgs; [
      winbox
      winboat
    ];
  };

}
