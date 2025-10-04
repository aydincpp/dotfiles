-- nvim-surround provides easy operations to add, change, or delete
-- surrounding characters like (), {}, "", '', <>

return {
  "kylechui/nvim-surround",

  -- Load only when Neovim is idle to reduce startup time
  event = "VeryLazy",

  -- Use a specific version
  version = "^3.0.0",

  -- Setup with default options
  config = function()
    require("nvim-surround").setup({})
  end
}
