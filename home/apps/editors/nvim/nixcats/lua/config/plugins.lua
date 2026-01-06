-- Starter config keeps plugins optional.
-- If you add plugins via nixCats categories, configure them here.

-- Example: Treesitter (only runs if installed)
local ok_ts, ts = pcall(require, "nvim-treesitter.configs")
if ok_ts then
  ts.setup({
    highlight = { enable = true },
  })
end

-- Example: LSP (only runs if installed)
local ok_lsp, lspconfig = pcall(require, "lspconfig")
if ok_lsp then
  lspconfig.lua_ls.setup({})
end
