{ inputs, ... }:
{
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  flake.modules.nixos."solace" = {

    imports = [
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager

      inputs.self.modules.nixos.base
      inputs.self.modules.nixos.fonts
      inputs.self.modules.nixos.lockscreen
      inputs.self.modules.nixos.main-user
      inputs.self.modules.nixos.utils
      inputs.self.modules.nixos.niri
      inputs.self.modules.nixos.noctalia
      inputs.self.modules.nixos.nvidia
      inputs.self.modules.nixos.games
      inputs.self.modules.nixos.containers

    ];
    home-manager.users.abosafiya = {
      imports = [
        inputs.self.modules.homeManager.hmv
        inputs.self.modules.homeManager.niri
        inputs.self.modules.homeManager.security
        inputs.self.modules.homeManager.swww
        inputs.self.modules.homeManager.utils
        inputs.self.modules.homeManager.noctalia
        inputs.self.modules.homeManager.quickshell
        inputs.self.modules.homeManager.editors
        inputs.self.modules.homeManager.neovim
        inputs.self.modules.homeManager.browsers
        inputs.self.modules.homeManager.docs
        inputs.self.modules.homeManager.networking
        inputs.self.modules.homeManager.media
        inputs.self.modules.homeManager.containers
        inputs.self.modules.homeManager.productivity
        inputs.self.modules.homeManager.files
        inputs.self.modules.homeManager.mails
        inputs.self.modules.homeManager.social
        inputs.self.modules.homeManager.terminals
        inputs.self.modules.homeManager.office
        inputs.self.modules.homeManager.design
        inputs.self.modules.homeManager.graphic

      ];
      home.stateVersion = "26.05";
    };
    networking.hostName = "solace";
    system.stateVersion = "26.05";
  };

  # Tell the flake to build this machine
  flake.nixosConfigurations."solace" = inputs.self.lib.mkNixos "solace";
}
