{ self, inputs, ... }:
{
  flake.nixosModules.hostProfileMainWorkstation =
    { pkgs, config, ... }:
    {
      programs.fish.enable = true;

      imports = [
        self.nixosModules.hostProfileLaptop
        self.nixosModules.preferences
        self.nixosModules.MainWorkstationHardwareConfig
        self.nixosModules.nvidia
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
   
        # Removed duplicate autostart entry for noctalia-shell
    };
}
