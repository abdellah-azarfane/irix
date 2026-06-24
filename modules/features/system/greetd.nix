{ ... }:
{
  flake.nixosModules.greetd =
    {
      pkgs,
      config,
      inputs,
      lib,
      ...
    }:
    let
      user = config.preferences.user.name;
      niriPackage = lib.attrByPath [ "programs" "niri" "package" ] pkgs.niri config;
      tuigreetExe = lib.getExe pkgs.tuigreet;
      niriSessionExe = lib.getExe' niriPackage "niri-session";
    in
    {
      imports = [
        inputs.dms.nixosModules.greeter
      ];

      # ----------------------------------------------------------------------

      services.greetd = lib.mkIf config.preferences.optionalServices.greetd {
        enable = true;
        settings = {
          default_session = {
            command = "${tuigreetExe} --time --cmd ${niriSessionExe}";
            user = "greeter";
          };
        };
      };

      # ----------------------------------------------------------------------

      services.displayManager.dms-greeter = lib.mkIf config.preferences.optionalServices.dmsgreetd {
        enable = true;
        compositor = {
          name = "niri"; # Required. Can be also "hyprland" or "sway"
          customConfig = ''
            # Optional custom compositor configuration
          '';
        };

        # Sync your user's DankMaterialShell theme with the greeter.
        configHome = "/home/${user}";

        # Custom config files for non-standard config locations
        configFiles = [
          "/home/${user}/.config/DankMaterialShell/settings.json"
        ];

        # Save the logs to a file
        logs = {
          save = true;
          path = "/tmp/dms-greeter.log";
        };

        # Custom Quickshell Package
        quickshell.package = pkgs.quickshell;
      };
    };
}
