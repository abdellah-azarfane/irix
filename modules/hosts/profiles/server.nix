{ self, ... }:
{
  flake.nixosModules.hostProfileServer = {
    imports = [
      self.nixosModules.hostProfileBase
      self.nixosModules.networks
      self.nixosModules.monitoring
      self.nixosModules.servers
    ];
  };
}
