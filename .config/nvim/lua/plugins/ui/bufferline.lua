return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
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
        separator_style = "slant",
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
