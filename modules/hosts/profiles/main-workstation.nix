{ self, inputs, ... }:
{
  flake.nixosModules.hostProfileMainWorkstation =
    { pkgs, config, ... }:
    let
      selfpkgs = inputs.self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.fish.enable = true;

      imports = [
        self.nixosModules.hostProfileLaptop
        self.nixosModules.MainWorkstationHardwareConfig
        self.nixosModules.nvidia
        self.nixosModules.vr
        self.lib.diskoConfigurations.MainWorkstation
      ];

      users.users.${config.preferences.user.name} = {
        isNormalUser = true;
        description = "${config.preferences.user.name}'s account";
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.fish;
        initialPassword = "12345";
      };

      home-manager.users.${config.preferences.user.name} = {
        home.stateVersion = "26.05";
      };

      preferences.autostart = [ selfpkgs.noctalia-shell ];
      preferences.monitors = {
        "eDP-1" = {
          primary = true;
          width = 1980;
          height = 1080;
          refreshRate = 144.0;
          scale = 1.0;
          x = 0;
          y = 0;
        };
        "HDMI-A-1" = {
          primary = false;
          width = 1920;
          height = 1080;
          scale = 1.0;
          refreshRate = 60.0;
          x = 2560;
          y = 0;
        };
      };
    };
}
