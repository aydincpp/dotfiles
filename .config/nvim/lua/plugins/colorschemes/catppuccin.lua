return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {     -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      float = {
        transparent = true,           -- enable transparent floating windows
        solid = false,                -- use solid styling for floating windows, see |winborder|
      },
      show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
      term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false,              -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15,            -- percentage of the shade to apply to the inactive window
      },
      no_italic = false,              -- Force no italic
      no_bold = true,                 -- Force no bold
      no_underline = false,           -- Force no underline
      styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments     = { "italic" },
        conditionals = { "bold" },
        loops        = { "bold" },
        functions    = { "italic" },
        keywords     = { "bold" },
        strings      = { "italic" },
        variables    = {},
        numbers      = {},
        booleans     = { "bold" },
        properties   = { "italic" },
        types        = { "bold", "italic" },
        operators    = {},
      },
      lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
        virtual_text = {
          errors      = { "bold", "italic" },
          warnings    = { "italic", "bold" },
          information = { "italic" },
          hints       = { "italic" },
          ok          = { "italic" },
        },
        underlines = {
          errors      = { "undercurl" },
          warnings    = { "undercurl" },
          information = { "underline" },
          hints       = { "underline" },
          ok          = { "underline" },
        },
        inlay_hints = {
          background = false, -- cleaner, less distracting
          italic     = true,
        },
      },
      color_overrides = {},
      custom_highlights = {},
      highlight_overrides = {
        mocha = function(mocha)
          return {
            WinSeparator = { fg = mocha.surface0, bg = mocha.none },
          }
        end,
        macchiato = function(macchiato)
          return {
            WinSeparator = { fg = macchiato.surface0, bg = macchiato.none },
          }
        end,
        latte = function(latte)
          return {
            WinSeparator = { fg = latte.surface0, bg = latte.none },
          }
        end,
        frappe = function(frappe)
          return {
            WinSeparator = { fg = frappe.surface0, bg = frappe.none },
          }
        end
      },
      default_integrations = true,
      auto_integrations = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    })

    vim.cmd.colorscheme "catppuccin"
  end
}
