{
  config,
  lib,
  pkgs,
  ...
}:

{
  config.specs.editor = {
    after = [ "general" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      snacks-nvim
      nvim-surround
      gitsigns-nvim
      which-key-nvim
    ];
  };
}
