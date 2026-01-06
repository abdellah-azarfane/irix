require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  indent = { enable = true },
})
