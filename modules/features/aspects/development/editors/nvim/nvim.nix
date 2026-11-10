{
  flake.nixosModules.nvim =
    {
      pkgs,
      config,
      inputs,
      ...
    }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    {

      environment.systemPackages = [
        pkgs.neovide
        inputs.my-neovim.packages.${pkgs.system}.default
      ];
    };
}
