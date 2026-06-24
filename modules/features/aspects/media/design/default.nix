{
  flake.nixosModules.design = { pkgs, inputs, ... }: {
    environment.systemPackages = with pkgs; [
      figma-linux
      inkscape
      gimp3-with-plugins
      blender
    ];
  };
}
