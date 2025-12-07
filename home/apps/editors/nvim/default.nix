{ ... }:
{
  imports = [
    ./modules
  ];

  programs.neovim = {
    enable = true;
  };

  xdg.configFile = {
    # init.lua
    "nvim/lua/filters.lua".source = ./filters.lua;
    "nvim/lua/functions.lua".source = ./functions.lua;
    "nvim/lua/main.lua".source = ./main.lua;
    "nvim/lua/keybinds.lua".source = ./keybinds.lua;
    "nvim/lua/ftdetect.lua".source = ./ftdetect.lua;

    "nvim/init.lua".text = ''
      require('filters')
      require('functions')
      require('main')
      require('keybinds')
      require('ftdetect')
    '';
  };
}
