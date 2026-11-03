{ inputs, ... }:
{
  flake.nixosModules.greetd =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
      system = pkgs.stdenv.hostPlatform.system;
      wm = config.preferences.apps.wm;
      primaryOutputs = lib.attrNames (
        lib.filterAttrs (_: mon: mon.primary or false) config.preferences.monitors
      );
    in
    {
      imports = [ inputs.noctalia-greeter.nixosModules.default ];

      config = lib.mkIf config.features.optionalServices.greetd {
        services.displayManager.noctalia-greeter = {
          enable = true;
          package = inputs.noctalia-greeter.packages.${system}.default;
          settings = {
            user.default = user;
            session.default = wm;
            keyboard.layout = config.preferences.keymap.layout;
            clock = {
              enabled = true;
              position = "above-panel";
            };
            output = lib.mkIf (primaryOutputs != [ ]) {
              name = lib.head primaryOutputs;
            };
          };
        };

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
