return {
    "harpoon",
    after = function()
        local ok, harpoon = pcall(require, "harpoon")
        if not ok then
          return
        end

        -- Harpoon legacy API expects setup(config) (function-style, not method-style).
        -- Using :setup(...) can pass module functions into config and break JSON persistence.
        if type(harpoon.setup) == "function" then
          local opts = {
            global_settings = {
              save_on_toggle = false,
              save_on_change = false,
              mark_branch = false,
            },
          }

          pcall(harpoon.setup, opts)
        end

    end
}
