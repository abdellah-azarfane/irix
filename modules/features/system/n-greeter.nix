{ self, inputs, ... }:
{
  flake.nixosModules.noctalia-greeter =
    {
      pkgs,
      config,
      lib,
      inputs,
      ...
    }:
    {
      imports = [ inputs.noctalia-greeter.nixosModules.default ];

      config = lib.mkIf config.preferences.optionalServices.noctalia-greeter {

        programs.noctalia-greeter = {
          enable = true;
          greeter-args = "--session niri-session";
          settings = {
            keyboard = {
              layout = "us";
            };

            # PIN THE GREETER TO YOUR LAPTOP SCREEN TO FIX THE INPUT BUG
            output = {
              name = "eDP-1";
            };
          };
        };

        # Explicitly define the greetd user so the imported module evaluates
        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              user = "greeter";
            };
          };
        };

        # Keep the hardware permissions just to be safe
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
