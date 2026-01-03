{
  pkgs,
  sourceLuaFile,
}:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # --- Color Utilities ---
      {
        plugin = nvim-colorizer-lua;
        config = sourceLuaFile "nvim-colorizer-lua.lua";
      }
      # --- Themes ---
      {
        plugin = tokyonight-nvim;
        config = sourceLuaFile "tokyonight-nvim.lua";
      }
    ];
  };
}
