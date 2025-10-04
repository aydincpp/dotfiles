return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  init = function()
    local function apply_highlights()
      vim.api.nvim_set_hl(0, "TabLineFill", { link = "Normal" })
      vim.api.nvim_set_hl(0, "BufferLineFill", { link = "Normal" })
      vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { link = "WinSeparator" })
    end

    apply_highlights()

    local group_prefix = require("constants.groups").group_prefix
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup(group_prefix .. "buffer-line-highlights", { clear = true }),
      callback = function()
        apply_highlights()
      end
    })
  end,
  config = function()
    require("bufferline").setup({
      options = {
        themable = true,
        numbers = "none",
        close_command = "bdelete %d",
        indicator = {
          icon = "▎",
          style = "icon"
        },
        offsets = {
          {
            filetype = "snacks_layout_box",
            text = "󱥰 Explorer",
            text_align = "left",
            separator = true,
          }
        },
        color_icons = true,
        get_element_icon = function(element)
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
          return icon, hl
        end,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        separator_style = "none",
        always_show_bufferline = true,
        auto_toggle_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
      },
    })

    local offset_sep_hl = vim.api.nvim_get_hl(0, { name = "BufferLineOffsetSeparator", link = false })
    vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = offset_sep_hl.fg, bg = "NONE" })
  end
}
