{self, inputs, ...}:
{
  flake.nixosModules.nc-greeter = {pkgs, inputs, config, lib, ...}:
  let
    user = config.preferences.user.name;
  in {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
    ];

    programs.noctalia-greeter = lib.mkIf config.preferences.noctalia-greeter {
      enable = true;
      package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # Optional configuration
      greeter-args = "";
      settings = {
        cursor = {
          theme = "Adwaita";
          size = 24;
        };
        keyboard = {
          layout = "us";
        };
      };
    };
  };
}
