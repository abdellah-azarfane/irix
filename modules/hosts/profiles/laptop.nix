{ self, ... }:
{
  flake.nixosModules.hostProfileLaptop = {
    imports = [
      self.nixosModules.hostProfileBase
      self.nixosModules.desktop
    ];

    services.logind.settings.Login = {
      HandleLidSwitch = "ignore";
      HandleLidSwitchExternalPower = "ignore";
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "suspend";
      HandlePowerKeyLongPress = "poweroff";
    };
  };
}
