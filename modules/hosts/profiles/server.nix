{ self, lib, ... }:
{
  flake.nixosModules.hostProfileServer = {
    imports = [
      self.nixosModules.hostProfileBase
      self.nixosModules.networks
      self.nixosModules.monitoring
      self.nixosModules.servers
    ];

    features.optionalServices = {
      greetd = false;
      xserver = false;
      pipewire = true;
      upower = false;
      printing = true;
      udisks2 = true;
      blueman = false;
      flatpak = false;
      openrgb = false;
      asusd = false;
      ollama = false;
    };

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "prohibit-password";
        KbdInteractiveAuthentication = false;
      };
    };

    services.journald.extraConfig = ''
      SystemMaxUse=200M
      MaxFileSec=7day
    '';
  };
}
