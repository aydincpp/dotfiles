-- NOTE: For the sake of simplicity,
-- I don't use this file anymore

local M = {}

--- Convenience function to define a keymap entry.
--- Reduces repetition by packaging mode, lhs, rhs, and desc
--- into a table with consistent field names.
---
--- @param mode string|table Mode(s) in which the mapping applies ('n', 'i', 'v', etc.)
--- @param lhs string The left-hand side key sequence
--- @param rhs string|function The right-hand side command or Lua function
--- @param desc string Description of the keymap (used by which-key)
--- @return table A keymap definition { mode=..., lhs=..., rhs=..., opts=... }
local km = function(mode, lhs, rhs, desc, opts)
  opts = opts or {}
  if desc then
    opts.desc = desc
  end
  return { mode = mode, lhs = lhs, rhs = rhs, opts = opts }
end

-- Window Utility
-- Provides helper functions for window management
local win_utils = require("utils.window")

--- Function to resize windows horizontally
-- @usage resize_horizontal(amount)
-- @param amount number Indicates which key was pressed:
--   negative = <Left> key, positive = <Right> key
-- The function calculates whether to grow or shrink the window based on its position
local resize_horizontal = win_utils.resize_horizontal

--- Function to resize windows vertically
-- @usage resize_vertical(amount)
-- @param amount number Indicates which key was pressed:
--   negative = <Down> key, positive = <Up> key
-- The function calculates whether to grow or shrink the window based on its position
local resize_vertical = win_utils.resize_vertical

-- Table storing all keymap constants organized by category.
-- Each keymap includes mode, lhs, rhs, and a desc used when setting the mapping.
M.keymap = {
  general = {
    clear_highlight = km("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlights"),
    reload_config   = km("n", "<leader>`", "<cmd>update<CR><cmd>source<CR>", "Save and reload config"),
  },

  editing = {
    indent_left_normal  = km("n", "<", "<<", "Indent line left"),
    indent_right_normal = km("n", ">", ">>", "Indent line right"),
    indent_left_visual  = km("v", "<", "<gv", "Indent selection left"),
    indent_right_visual = km("v", ">", ">gv", "Indent selection right"),
    paste_indent        = km("x", "p", "p`[v`]=`]", "Paste and indent"),
    paste_indent_normal = km("n", "p", "p`[v`]=`]", "Paste after cursor and indent"),
  },

  motion = {
    jump_start  = km("n", "H", "^", "Start of line"),
    jump_end    = km("n", "L", "$", "End of line"),
    search_next = km("n", "n", "nzz", "Next search result"),
    search_prev = km("n", "N", "Nzz", "Previous search result"),
  },

  terminal = {
    exit_terminal = km("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode"),
  },

  window = {
    quit_window      = km("n", "<leader>q", "<cmd>q<CR>", "Quit window"),
    quit_all_windows = km("n", "<leader>Q", "<cmd>qall<CR>", "Quit all windows"),
    split_below      = km("n", "<leader>sj", "<cmd>split<CR>", "Split window below"),
    split_right      = km("n", "<leader>sl", "<cmd>vsplit<CR>", "Split window right"),
    move_left        = km("n", "<C-h>", "<C-w>h", "Go to left window"),
    move_right       = km("n", "<C-l>", "<C-w>l", "Go to right window"),
    move_down        = km("n", "<C-j>", "<C-w>j", "Go to lower window"),
    move_up          = km("n", "<C-k>", "<C-w>k", "Go to upper window"),
    resize_left      = km("n", "<C-Left>", function() resize_horizontal(-2) end, "Resize window narrower"),
    resize_right     = km("n", "<C-Right>", function() resize_horizontal(2) end, "Resize window wider"),
    resize_down      = km("n", "<C-Down>", function() resize_vertical(-2) end, "Resize window shorter"),
    resize_up        = km("n", "<C-Up>", function() resize_vertical(2) end, "Resize window taller"),
    move_far_left    = km("n", "<A-h>", "<C-w>H", "Move window far left"),
    move_far_right   = km("n", "<A-l>", "<C-w>L", "Move window far right"),
    move_far_bottom  = km("n", "<A-j>", "<C-w>J", "Move window to bottom"),
    move_far_top     = km("n", "<A-k>", "<C-w>K", "Move window to top"),
  },

  buffer = {
    save_buffer      = km("n", "<leader>w", "<cmd>write<CR>", "Save buffer"),
    save_all_buffers = km("n", "<leader>W", "<cmd>wall<CR>", "Save all"),
    next_buffer      = km("n", "<Tab>", "<cmd>bnext<CR>", "Next buffer"),
    prev_buffer      = km("n", "<S-Tab>", "<cmd>bprevious<CR>", "Previous buffer"),
  },

  tabs = {
    new_tab      = km("n", "<leader>te", "<cmd>tabedit<CR>", "New tab"),
    close_tab    = km("n", "<leader>tc", "<cmd>tabclose<CR>", "Close tab"),
    prev_tab     = km("n", "<S-h>", "<cmd>tabprevious<CR>", "Previous tab"),
    next_tab     = km("n", "<S-l>", "<cmd>tabnext<CR>", "Next tab"),
    next_tab_alt = km("n", "<C-Tab>", "<cmd>tabnext<CR>", "Next tab"),
    prev_tab_alt = km("n", "<C-S-Tab>", "<cmd>tabprevious<CR>", "Previous tab"),
  },

  lsp = {
    rename            = km("n", "<leader>rn", function()
      local ok, _ = pcall(require, "inc_rename")
      if ok then
        return ":IncRename " .. vim.fn.expand("<cword>")
      else
        vim.lsp.buf.rename()
      end
    end, "LSP: Rename symbol", { expr = true }),

    references        = km("n", "gr", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.lsp_references({ position_encoding = "utf-16" }) else vim.lsp.buf.references() end
    end, "LSP: References"),

    definition        = km("n", "gd", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.lsp_definitions() else vim.lsp.buf.definition() end
    end, "LSP: Definition"),

    type_definition   = km("n", "gt", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.lsp_type_definitions() else vim.lsp.buf.type_definition() end
    end, "LSP: Type definition"),

    implementation    = km("n", "gi", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.lsp_implementations() else vim.lsp.buf.implementation() end
    end, "LSP: Implementation"),

    document_symbols  = km("n", "<leader>ls", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.lsp_document_symbols() else vim.lsp.buf.document_symbol() end
    end, "LSP: Document symbols"),

    workspace_symbols = km("n", "<leader>lw", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.lsp_workspace_symbols() else vim.lsp.buf.workspace_symbol() end
    end, "LSP: Workspace symbols"),

    diagnostics       = km("n", "<leader>ld", function()
      local ok, tb = pcall(require, "telescope.builtin")
      if ok then tb.diagnostics() else vim.diagnostic.open_float() end
    end, "LSP: Diagnostics"),

    code_action       = km("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code actions"),
    format            = km("n", "<leader>f", vim.lsp.buf.format, "LSP: Format buffer"),
    -- hover           = km("n", "K", vim.lsp.buf.hover, "LSP: Hover info"),
    declaration       = km("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration"),
  },

  diagnostic = {
    prev = km("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true, wrap = true })
    end, "LSP: Previous diagnostic"),

    next = km("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true, wrap = true })
    end, "LSP: Next diagnostic"),
  },

  telescope = {
    -- Search pickers
    find_files = km("n", "<leader>sf", function() require("telescope.builtin").find_files() end,
      "Telescope: Search files"),
    grep_string = km("n", "<leader>sw", function() require("telescope.builtin").grep_string() end,
      "Telescope: Search word (grep_string)"),
    buffers = km("n", "<leader>sb", function() require("telescope.builtin").buffers() end, "Telescope: Search buffers"),
    oldfiles = km("n", "<leader>sr", function() require("telescope.builtin").oldfiles() end,
      "Telescope: Search recent files (oldfiles)"),
    live_grep = km("n", "<leader>sg", function() require("telescope.builtin").live_grep() end, "Telescope: Live grep"),
    commands = km("n", "<leader>sc", function() require("telescope.builtin").commands() end, "Telescope: Search commands"),
    help_tags = km("n", "<leader>sh", function() require("telescope.builtin").help_tags() end,
      "Telescope: Search help tags"),
    registers = km("n", "<leader>s\"", function() require("telescope.builtin").registers() end,
      "Telescope: Search registers"),
    keymaps = km("n", "<leader>sk", function() require("telescope.builtin").keymaps() end, "Telescope: Search keymaps"),
    current_buffer_fuzzy_find = km("n", "<leader>s/",
      function() require("telescope.builtin").current_buffer_fuzzy_find() end, "Telescope: Search current buffer"),

    -- Git pickers
    git_commits = km("n", "<leader>gc", function() require("telescope.builtin").git_commits() end,
      "Telescope: Git commits"),
    git_bcommits = km("n", "<leader>gC", function() require("telescope.builtin").git_bcommits() end,
      "Telescope: Git buffer commits"),
    git_bcommits_range = km("n", "<leader>gR", function() require("telescope.builtin").git_bcommits_range() end,
      "Telescope: Git buffer commits range"),
    git_branches = km("n", "<leader>gb", function() require("telescope.builtin").git_branches() end,
      "Telescope: Git branches"),
    git_status = km("n", "<leader>gs", function() require("telescope.builtin").git_status() end, "Telescope: Git status"),
    git_stash = km("n", "<leader>gS", function() require("telescope.builtin").git_stash() end, "Telescope: Git stash"),
  }
}

return M
