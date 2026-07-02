{ self, inputs, ... }: {
  flake.nixosModules.desktop =
    { pkgs, ... }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
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
        self.nixosModules.networks
        self.nixosModules.wallust
        self.nixosModules.noctalia
        self.nixosModules.office
        self.nixosModules.productivity
      ];

      programs.niri = {
        enable = true;
        package = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };

      environment.systemPackages = [
        pkgs.xwayland-satellite
        selfpkgs.terminal
        pkgs.bibata-cursors
      ];

      fonts.packages = with pkgs; [
        # --- UI & Code Fonts ---
        nerd-fonts.jetbrains-mono
        inter

        # --- Windows Compatibility ---
        liberation_ttf
      ];

      fonts.fontconfig.defaultFonts = {
        serif = [ "Inter" "Liberation Serif" ];
        sansSerif = [ "Inter" "Liberation Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };

    };
}
