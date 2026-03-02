# modules/features/neovim/module.nix

# 1. It takes inputs from your flake
inputs:

# 2. It opens the standard module arguments
{
  config,
  wlib,
  lib,
  pkgs,
  ...
}:

# 3. It opens the configuration block
{
  # You define your options and plugins directly in here!

  config.settings.colorscheme = "onedark_dark";

  config.specs.general = {
    lazy = true;
    extraPackages = with pkgs; [
      lazygit
      ripgrep
    ];
    data = with pkgs.vimPlugins; [
      vim-sleuth
      opencode-nvim
      snacks-nvim
      nvim-lspconfig
      kdePackages.qtdeclarative
    ];
  };
}
