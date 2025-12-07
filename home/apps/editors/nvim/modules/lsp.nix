{
  pkgs,
  sourceLuaFile,
}:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # LSP
      {
        plugin = nvim-lspconfig; # LSP
        config = sourceLuaFile "nvim-lspconfig.lua";
      }

      SchemaStore-nvim # JSON parsing


      # Loading animations
      fidget-nvim

      # Diagnostics
      {
        plugin = trouble-nvim;
        config = sourceLuaFile "trouble-nvim.lua";
      }

      # Formatting
      {
        plugin = conform-nvim;
        config = sourceLuaFile "conform-nvim.lua";
      }
    ];
  };
}
