-- todo-comments highlights and searches for TODO, FIXME, etc. in comments

return {
  "folke/todo-comments.nvim",

  -- Dependency required for utility functions
  dependencies = { "nvim-lua/plenary.nvim" },

  -- Load after Neovim startup
  event = "VimEnter",

  -- Plugin options
  opts = {
    signs = false,  -- Disable gutter signs; only highlight keywords in text
  },
}
