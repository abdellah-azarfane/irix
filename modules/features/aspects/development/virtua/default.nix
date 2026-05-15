{ self, lib, ... }: {
  flake.nixosModules.virt = { pkgs, config, ... }: let
    user = config.preferences.user.name;in {
    environment.systemPackages = with pkgs; [
      winbox
      winboat
    ];
  };

}
