-- Displays available keybindings in a popup as you type
-- Helps discover mappings and provides descriptions for leader/key sequences

return {
  "folke/which-key.nvim",

  -- Load when Neovim is idle to save startup time
  event = "VeryLazy",

  config = function()
    require("which-key").setup({
      -- Use a specific preset layout
      preset = "helix",

      -- Enable notifications when keybindings are missing
      notify = true,

      -- Enable/disable built-in helper plugins
      plugins = {
        marks = false,   -- Disable marks plugin
        spelling = {
          enabled = false,  -- Disable spelling suggestions popup
        },
      },
    })
  end,

  -- Define keymaps that trigger which-key manually
  keys = {
    {
      "<leader>?",  -- Press this to see buffer-local keymaps
      function()
        require("which-key").show({ global = false })  -- Only show buffer-local mappings
      end,
      desc = "Buffer local keymaps (which-key)"  -- Description shown in which-key popup
    }
  }
}
