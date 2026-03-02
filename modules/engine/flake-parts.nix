{ inputs, ... }: 
{
  # Since both are standard laptops, we only need x86_64-linux
  systems = [ "x86_64-linux" ];

  flake.lib.mkNixos = hostName: 
    inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; }; 
      modules = [
        # This tells Nix to grab the module matching your hostname
        inputs.self.modules.nixos.${hostName}
      ];
    };
}
