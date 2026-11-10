{
  config,
  lib,
  pkgs,
  ...
}:

{
  config.specs.lsp = {
    after = [ "general" ];
    lazy = true;
    data = with pkgs.vimPlugins; [
      nvim-lspconfig
      blink-cmp
      blink-compat
      cmp-cmdline
      nvim-lint
      conform-nvim
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
    ];
  };
}
