local group_prefix = require("constants.groups").group_prefix

-- General
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("augroup-highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- File type specific options
vim.api.nvim_create_autocmd("FileType", {
    desc = "Options for Lua files",
    group = vim.api.nvim_create_augroup(group_prefix .. "filetype-lua", { clear = true }),
    pattern = "lua",
    callback = function()
        vim.bo.tabstop = 2
        vim.bo.softtabstop = 2
        vim.bo.shiftwidth = 2
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    desc = "Options for C files",
    group = vim.api.nvim_create_augroup(group_prefix .. "filetype-c", { clear = true }),
    pattern = { "c", "h" },
    callback = function()
        vim.o.tabstop = 2
        vim.o.softtabstop = 2
        vim.o.shiftwidth = 2
    end
})
