{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    dms.url = "github:AvengeMedia/DankMaterialShell";
    dms.inputs.nixpkgs.follows = "nixpkgs";

    dms-plugin-registry.url = "github:AvengeMedia/dms-plugin-registry";
    dms-plugin-registry.inputs.nixpkgs.follows = "nixpkgs";

    dgop.url = "github:AvengeMedia/dgop";
    dgop.inputs.nixpkgs.follows = "nixpkgs";

    my-emacs.url = "./emacs-module";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    wallpapers.url = "github:abdellah-azarfane/wallpapers";

    helium.url = "github:schembriaiden/helium-browser-nix-flake";
    helium.inputs.nixpkgs.follows = "nixpkgs";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    hermes-agent.url = "github:NousResearch/hermes-agent";
    preservation.url = "github:nix-community/preservation";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    zed.url = "github:zed-industries/zed";

    hjem.url = "github:feel-co/hjem";
    hjem.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
