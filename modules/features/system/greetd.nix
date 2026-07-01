{ self, inputs, ... }:
{
  flake.nixosModules.greetd = { pkgs, config, inputs, lib, ... }:
    let
      noctaliaEnabled = config.preferences.optionalServices.noctalia-greeter;
    in
    {
      imports = lib.optional noctaliaEnabled inputs.noctalia-greeter.nixosModules.default;

      services.greetd = lib.mkIf (config.preferences.optionalServices.greetd && !noctaliaEnabled) {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri";
            user = "greeter";
          };
        };
      };

      programs.noctalia-greeter = lib.mkIf noctaliaEnabled {
        enable = true;
        package = inputs.noctalia-greeter.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
}
