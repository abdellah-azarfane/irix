{ inputs, ... }:
{
  perSystem = { pkgs, ... }:
    let
      nvim = import ../home/apps/editors/nvim/package.nix { inherit inputs pkgs; };
    in
    {
      packages = {
        nvim = nvim;
        nixcats-nvim = nvim;
      };

      devShells.nvim = pkgs.mkShell {
        buildInputs = [ nvim ];
      };
    };
}
