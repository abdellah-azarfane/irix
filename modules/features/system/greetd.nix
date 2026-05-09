{ ... }:
{
  flake.nixosModules.greetd = {
    pkgs,
    config,
    lib,
    ...
  }: let
    niriPackage = lib.attrByPath [ "programs" "niri" "package" ] pkgs.niri config;
    tuigreetExe = lib.getExe pkgs.tuigreet;
    niriSessionExe = lib.getExe' niriPackage "niri-session";
  in {
    services.greetd = {
      enable = lib.mkDefault (config.preferences.optionalServices.greetd or true);
      settings = {
        default_session = {
          command = "${tuigreetExe} --time --cmd ${niriSessionExe}";
          user = "greeter";
        };
      };
    };
  };
}
