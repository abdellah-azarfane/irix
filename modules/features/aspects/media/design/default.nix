 {
  flake.nixosModules.design = {pkgs, inputs, ...}: {
      nixpkgs.overlays = [ inputs.affinity-nix.overlays.default ];
      environment.systemPackages = with pkgs; [
        figma-linux
     #   affinity-v3
        inkscape
        gimp3-with-plugins
        blender
      ];
      programs.obs-studio = {
       enable = true;
       plugins = with pkgs.obs-studio-plugins; [
        wlrobs           # For Wayland screen capture
       ];
    };
  };
}
