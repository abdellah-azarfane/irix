{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: let
    selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    imports = [
      self.nixosModules.gtk
      self.nixosModules.wallpaper
      self.nixosModules.development
      self.nixosModules.files
      self.nixosModules.media
      self.nixosModules.terminals
      self.nixosModules.monitoring
      self.nixosModules.browsers
      self.nixosModules.docs
      self.nixosModules.gaming
      self.nixosModules.hyprlock
      self.nixosModules.networks
      self.nixosModules.office
      self.nixosModules.productivity
    ];

    programs.niri.enable = true;
    programs.niri.package = selfpkgs."niri";

    # preferences.autostart = [selfpkgs.quickshellWrapped];
    preferences.autostart = [selfpkgs.noctalia-shell];

    environment.systemPackages = [
      selfpkgs.terminal
      pkgs.pcmanfm
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
