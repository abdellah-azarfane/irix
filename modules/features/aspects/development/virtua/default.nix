{
  flake.nixosModules.virt = { pkgs, config, ... }:
  let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = with pkgs; [
      winbox
      winboat
      docker-compose
    ];
    virtualisation.docker = {
        enable = true;
        autoPrune.enable = true;
        enableOnBoot = true;
      };
  };

}
