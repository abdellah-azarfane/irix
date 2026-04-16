return {
    "nvim-treesitter",
    after = function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if ok then
            configs.setup({
              ensure_installed = {},
              auto_install = false,
              highlight = { enable = true },
              indent = { enable = true },
            })
        end
        
        -- ✅ Tell Tree-sitter to use the 'go-template' parser for Hugo template files
        -- vim.treesitter.language.register("gotmpl", "gohtmltmpl")

    end
}
