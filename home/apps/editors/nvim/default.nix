{ inputs, pkgs, ... }:
let
  nvimPkg = import ./package.nix { inherit inputs pkgs; };
in
{
  programs.neovim = {
    enable = true;
    package = nvimPkg;
    extraPackages = with pkgs; [
      neovim-remote
    ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
