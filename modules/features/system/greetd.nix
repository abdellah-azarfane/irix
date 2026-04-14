{ ... }:
{
  flake.nixosModules.greetd = { pkgs, config, ... }: {
        services.greetd = {
          enable = config.features.optionalServices.greetd;
          settings = {
            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${pkgs.niri}/bin/niri-session";
              user = "greeter";
            };
          };
        };
      };
    }
