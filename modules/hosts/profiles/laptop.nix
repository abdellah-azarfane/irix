{ self, ... }:
{
  flake.nixosModules.hostProfileLaptop = {
    imports = [
      self.nixosModules.hostProfileBase
      self.nixosModules.desktop
    ];

    services.logind = {
      lidSwitch = "ignore";
      lidSwitchExternalPower = "ignore";
      lidSwitchDocked = "ignore";
      powerKey = "suspend";
      powerKeyLongPress = "poweroff";
    };
  };
}
