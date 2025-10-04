return {
  -- Plugin for interactive LSP renaming
  "smjonas/inc-rename.nvim",

  -- Load when Neovim startup is done
  event = "VimEnter",

  config = function()
    require("inc_rename").setup({
      -- The name of the command
      cmd_name = "IncRename",

      -- The highlight group used for highlighting the identifier's new name
      hl_group = "Substitute",

      -- Whether an empty new name should be previewed; if false the command preview will be cancelled instead
      preview_empty_name = false,

      -- Whether to display a `Renamed m instances in n files` message after a rename operation
      show_message = true,

      -- Whether to save the "IncRename" command in the commandline history (set to false to prevent issues with
      -- navigating to older entries that may arise due to the behavior of command preview)
      save_in_cmdline_history = false,

      -- The type of the external input buffer to use (currently supports "dressing" or "snacks")
      input_buffer_type = nil,

      -- Callback to run after renaming, receives the result table (from LSP handler) as an argument
      post_hook = nil,
    })
  end,
}
