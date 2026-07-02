{ self, inputs,... }:
{
  flake.nixosModules.greetd = { pkgs, config, inputs, lib, ...}:
    let
      user = config.preferences.user.name;
      in
    {
      # ----------------------------------------------------------------------

      services.greetd = lib.mkIf config.preferences.optionalServices.greetd {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri";
            user = "greeter";
          };
        };
      };
    };
}
