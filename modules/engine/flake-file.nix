{ inputs, ... }:
{
  #  Import the flake-file module
  imports = [
    inputs.flake-file.flakeModules.default
  ];

  # Tell flake-file what the absolute core inputs are
  flake-file.inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-file.url = "github:vic/flake-file";
    import-tree.url = "github:vic/import-tree";
  };

  # Tell flake-file exactly what to write in the outputs section of flake.nix
  flake-file.outputs = ''
    inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules)
  '';
}
