{ self, inputs, ... }: {
  flake.nixosModules.dms = { inputs, pkgs, config, ... }: {
    imports = [
      inputs.dms.nixosModules.dank-material-shell
    ];
    programs.dank-material-shell = {
          enable = true;
          package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
          systemd = {
            enable = true;
            restartIfChanged = true;
          };
          dgop.package = inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default;
          enableSystemMonitoring = true;
          enableDynamicTheming = true;
          enableAudioWavelength = true;  # Maps to your audio-vis widget
        };

        environment.sessionVariables = {
          DMS_DANKBAR_LAYER = "top"; # Keep the bar on top like Noctalia
        };
  };
}
