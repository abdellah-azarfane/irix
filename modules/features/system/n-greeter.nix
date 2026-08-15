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
      # Import the official module from the Noctalia Greeter flake
      imports = [ inputs.noctalia-greeter.nixosModules.default ];

      config = lib.mkIf config.preferences.optionalServices.noctalia-greeter {

        programs.noctalia-greeter = {
          enable = true;

          # Pass extra arguments to set your default Wayland session
          # We use niri-session to ensure your portals load properly
          greeter-args = "--session niri-session";

          # You can declaratively configure the greeter.toml file here
          settings = {
            keyboard = {
              layout = "us"; # Change this to match your physical keyboard
            };

            # Example: Configuring a custom cursor for the login screen
            # cursor = {
            #   theme = "Bibata-Modern-Ice";
            #   size = 24;
            #   path = "${pkgs.bibata-cursors}/share/icons";
            # };
          };
        };

        # Disable standard greetd to avoid any conflicts, as the Noctalia module automatically enables and configures its own greetd instance
        services.greetd.enable = lib.mkForce false;
      };
    };
}
