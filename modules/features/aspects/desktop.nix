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
        self.nixosModules.gaming
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
       # --- UI & Reading Fonts ---
        inter
        merriweather              # A highly legible, beautiful serif for academic reading/PDFs

        # --- Code & Terminal Fonts ---
        nerd-fonts.jetbrains-mono
        iosevka                   # Required for the Emacs variable-pitch configuration
        julia-mono                # Flawless rendering for pure mathematics and informatics notation

        # --- Fallbacks & Compatibility ---
        symbola
        liberation_ttf
        ];

      fonts.fontconfig.defaultFonts = {
        serif = [
          "Merriweather"      # Prioritize modern elegance for documents
          "Liberation Serif"  # Fallback for strict Microsoft Times New Roman requirements
            ];
        sansSerif = [
          "Inter"             # Prioritize modern UI scaling
          "Liberation Sans"   # Fallback for Arial requirements
            ];
        monospace = [
          "JetBrainsMono Nerd Font"
          "JuliaMono"         # Secondary fallback to catch advanced mathematical operators
            ];
          };
    };
}
