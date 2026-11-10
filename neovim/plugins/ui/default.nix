{
  config,
  lib,
  pkgs,
  ...
}:

{
  config.specs.ui = {
    after = [ "general" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      colorful-menu-nvim
      lualine-nvim
      fidget-nvim
    ];
  };
}
