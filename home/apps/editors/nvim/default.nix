{ ... }:
{
  imports = [
    ./modules
  ];

  programs.neovim.enable = true;

  xdg.configFile = {
    # Lua modules
    "nvim/lua/filters.lua".source = ./filters.lua;
    "nvim/lua/functions.lua".source = ./functions.lua;
    "nvim/lua/main.lua".source = ./main.lua;
    "nvim/lua/keybinds.lua".source = ./keybinds.lua;
    "nvim/lua/ftdetect.lua".source = ./ftdetect.lua;

    # Extra lua helpers
    "nvim/lua/functions" = {
      source = ./functions;
      recursive = true;
      force = true;
    };

    # Filetype plugins
    "nvim/ftplugin" = {
      source = ./ftplugin;
      recursive = true;
      force = true;
    };

    # init.lua
    "nvim/init.lua".text = ''
      require('filters')
      require('functions')
      require('main')
      require('keybinds')
      require('ftdetect')
    '';
  };
}
