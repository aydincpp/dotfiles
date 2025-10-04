-- Keymap utility
local map = require("utils.map")

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

-- general
map.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
map.set("n", "<leader>`", "<cmd>update<CR><cmd>source<CR>", { desc = "Save and reload config" })

-- better indenting
map.set("n", "<", "<<", { desc = "Indent line left" })
map.set("n", ">", ">>", { desc = "Indent line right" })
map.set("v", "<", "<gv", { desc = "Indent selection left and reselect" })
map.set("v", ">", ">gv", { desc = "Indent selection right and reselect" })

-- paste and indent
map.set("n", "p", "p`[v`]=`]", { desc = "Paste after cursor and indent" })
map.set("x", "p", "p`[v`]=`]", { desc = "Paste over selection and indent" })

-- motions
map.set("n", "H", "^", { desc = "Jump to line start" })
map.set("n", "L", "$", { desc = "Jump to line end" })
map.set("n", "n", "nzz", { desc = "Next search result centered" })
map.set("n", "N", "Nzz", { desc = "Previous search result centered" })

-- terminal
map.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- save & quit
map.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save buffer"})
map.set("n", "<leader>W", "<cmd>wall<CR>", { desc = "Save all buffer"})
map.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
map.set("n", "<leader>Q", "<cmd>qall<CR>", { desc = "Quit all windows" })
map.set("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit window" })
map.set("n", "<leader>X", "<cmd>xall<CR>", { desc = "Save and quit all windows" })

-- window split
map.set("n", "<leader>sj", "<cmd>split<CR>", { desc = "Horizontal split" })
map.set("n", "<leader>sl", "<cmd>vsplit<CR>", { desc = "Vertical split" })

-- window nav
map.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
map.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })

-- window move
map.set("n", "<A-h>", "<C-w>H", { desc = "Move window far left" })
map.set("n", "<A-l>", "<C-w>L", { desc = "Move window far right" })
map.set("n", "<A-j>", "<C-w>J", { desc = "Move window to bottom" })
map.set("n", "<A-k>", "<C-w>K", { desc = "Move window to top" })

-- window resize
map.set("n", "<C-Left>", function() resize_horizontal(-2) end, { desc = "Resize window narrower" })
map.set("n", "<C-Right>", function() resize_horizontal(2) end, { desc = "Resize window wider" })
map.set("n", "<C-Down>", function() resize_vertical(-2) end, { desc = "Resize window shorter" })
map.set("n", "<C-Up>", function() resize_vertical(2) end, { desc = "Resize window taller" })

-- buffer
map.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

map.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- tabs
map.set("n", "<leader>tn", "<cmd>tabnext<CR>", { desc = "Next tab" })
map.set("n", "<leader>tp", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
map.set("n", "<leader>te", "<cmd>tabe<CR>", { desc = "Open new tab" })
map.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })
