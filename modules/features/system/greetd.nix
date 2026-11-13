{ inputs, ... }:
{
  flake.nixosModules.greetd =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      config = lib.mkIf config.features.optionalServices.greetd {
        services.greetd = {
          enable = true;
          settings.default_session.user = "greeter";
        };

        users.users.greeter = {
          isSystemUser = true;
          group = "greeter";
          extraGroups = [
            "input"
            "video"
          ];
        };
        users.groups.greeter = { };
      };
    };
}
