-- leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- clipboard
vim.schedule(function()
      vim.o.clipboard = "unnamedplus"
end)

-- indentation & formatting
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.cindent = true
vim.o.textwidth = 80
vim.o.wrap = false

-- buffer
vim.o.hidden = true
vim.o.swapfile = true
vim.o.undofile = true

-- command line
vim.o.inccommand = "split"
vim.o.confirm = true
vim.o.showmode = false

-- completion
vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 10

-- window splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- timings
vim.o.timeoutlen = 300
vim.o.updatetime = 250

-- line number
vim.o.number = true
vim.o.relativenumber = true

-- sign column
vim.o.signcolumn = "yes"

-- mouse
vim.o.mouse = "a"

-- scrolling
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- ui
vim.o.cursorline = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.laststatus = 3

