 {
  flake.nixosModules.design = {pkgs, inputs, ...}: {
      environment.systemPackages = with pkgs; [
        figma-linux
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
