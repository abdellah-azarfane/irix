{self, inputs, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.gtk
      self.nixosModules.wallpaper
      self.nixosModules.development
      self.nixosModules.files
      self.nixosModules.yazi
      self.nixosModules.media
      self.nixosModules.terminals
      self.nixosModules.monitoring
      self.nixosModules.browsers
      self.nixosModules.docs
      self.nixosModules.gaming
      self.nixosModules.virt
      self.nixosModules.networks
      self.nixosModules.dms
      self.nixosModules.office
      self.nixosModules.productivity
    ];

    programs.niri = {
        enable = true;
        package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
    # preferences.autostart = [selfpkgs.quickshellWrapped];

    environment.systemPackages = [
      pkgs.xwayland-satellite
      selfpkgs.terminal
      pkgs.bibata-cursors
    ];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      ubuntu-sans
      cm_unicode
      corefonts
      unifont
    ];

    fonts.fontconfig.defaultFonts = {
      serif = ["Ubuntu Sans"];
      sansSerif = ["Ubuntu Sans"];
      monospace = ["JetBrainsMono Nerd Font"];
    };

  };
}
