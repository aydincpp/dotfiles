return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "1.*",
  build = "cargo build --release",

  init = function()
    local function apply_highlights()
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "Normal" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "Normal" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
    end

    apply_highlights()

    local group_prefix = require("constants.groups").group_prefix
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup(group_prefix .. "blink-cmp-highlights", { clear = true }),
      callback = function()
        apply_highlights()
      end
    })
  end,

  opts = {
    keymap = {
      preset = 'default',

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },

      ['<C-u>'] = { function(cmp) cmp.scroll_documentation_up(2) end },
      ['<C-d>'] = { function(cmp) cmp.scroll_documentation_down(2) end },
    },
    completion = {

      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = true }, },

      -- Don't select by default, auto insert on selection
      list = { selection = { preselect = false, auto_insert = true } },

      menu = {
        enabled = true,
        border = "rounded",
        winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
        scrolloff = 2,
        scrollbar = false,
        auto_show = true,
        auto_show_delay_ms = 0,

        draw = {
          align_to = "label",
          -- Use treesitter to highlight the label text for the given list of sources
          treesitter = { "lsp" },
        },

      },

      documentation = {
        auto_show = true,

        -- Delay before showing the documentation window
        auto_show_delay_ms = 500,

        -- Whether to use treesitter highlighting, disable if you run into performance issues
        treesitter_highlighting = true,

        window = {
          border = "rounded",
          winblend = 0,
          winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
        }
      },

      -- Display a preview of the selected item on the current line
      ghost_text = {
        enabled = true,
        -- Show the ghost text when an item has been selected
        show_with_selection = true,
        -- Show the ghost text when no item has been selected, defaulting to the first item
        show_without_selection = false,
        -- Show the ghost text when the menu is open
        show_with_menu = true,
        -- Show the ghost text when the menu is closed
        show_without_menu = false,
      },
    },

    fuzzy = {
      implementation = 'prefer_rust_with_warning',

      -- Frecency tracks the most recently/frequently used items and boosts the score of the item
      -- Note, this does not apply when using the Lua implementation.
      frecency = {
        -- Whether to enable the frecency feature
        enabled = true,
        -- Location of the frecency database
        path = vim.fn.stdpath('state') .. '/blink/cmp/frecency.dat',
      },
    },

    -- Experimental signature help support
    signature = {
      enabled = true,
      trigger = {
        -- Show the signature help automatically
        enabled = true,
        -- Show the signature help window when entering insert mode
        show_on_insert = true,
      },
      window = {
        border = "rounded",
        winblend = 0,
        winhighlight = 'Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder',
        -- Disable if you run into performance issues
        treesitter_highlighting = true,
        show_documentation = false,
      }
    },

    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),

      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',

      kind_icons = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",

        Field = "󰜢",
        Variable = "󰀫",
        Property = "󰜢",

        Class = "󰠱",
        Interface = "",
        Struct = "󰙅",
        Module = "",

        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        EnumMember = "",

        Keyword = "󰌋",
        Constant = "󰏿",

        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        Event = "",
        Operator = "󰆕",
        TypeParameter = '',
      },
    },

    cmdline = {
      enabled = true,
      -- use 'inherit' to inherit mappings from top level `keymap` config
      keymap = { preset = 'cmdline' },
      sources = { 'buffer', 'cmdline' },

      completion = {
        menu = {
          auto_show = true
        },
        list = {
          selection = {
            -- When `true`, will automatically select the first item in the completion list
            preselect = false,
            -- When `true`, inserts the completion item automatically when selecting it
            auto_insert = true,
          },
        },
      }
    },

    sources = {
      -- add lazydev to your completion providers
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
          fallbacks = { "lsp" }
        },
      },
    },
  },
}
