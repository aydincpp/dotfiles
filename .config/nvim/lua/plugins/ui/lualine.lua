-- Lualine statusline configuration
-- Sections layout reference:
-- +-------------------------------------------------+
-- | A | B | C                             X | Y | Z |
-- +-------------------------------------------------+

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto",

        -- Component separators (between items inside sections)
        -- Examples:
        -- { left = "", right = "" }
        -- { left = "", right = "" }
        component_separators = { left = "", right = "" },

        -- Section separators (between A|B|C and X|Y|Z blocks)
        -- Examples:
        -- { left = "", right = "" }
        -- { left = "", right = "" }
        section_separators = { left = "", right = "" },
      },

      -- Active window sections
      sections = {
        lualine_a = { "mode" },                               -- Current mode (NORMAL, INSERT…)
        lualine_b = { "branch", "diff", "diagnostics" },      -- Git branch, changes, diagnostics
        lualine_c = { "filename" },                           -- Current file name
        lualine_x = { "encoding", "fileformat", "filetype" }, -- File info
        lualine_y = { "progress" },                           -- Progress through file (%)
        lualine_z = { "location" },                           -- Cursor location (line,col)
      },

      -- Inactive window sections (simpler statusline)
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" }, -- Only show filename
        lualine_x = { "location" }, -- And cursor location
        lualine_y = {},
        lualine_z = {},
      },
    })
  end
}
