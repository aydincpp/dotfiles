return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,

  config = function()
    require("tokyonight").setup {
      style = "moon",
      styles = {
        comments = { italic = false }, -- italic comments
      }
    }

    -- vim.cmd[[colorscheme tokyonight]]
  end
}
