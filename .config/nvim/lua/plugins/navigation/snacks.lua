-- keymap utility
local map = require("utils.map")

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    -- Create some toggle mappings
    map.set("n", "<leader>us", function() Snacks.toggle.option("spell", { name = "Spelling" }):toggle() end,
      { desc = "Toggle Spelling" })
    map.set("n", "<leader>uw", function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end,
      { desc = "Toggle Wrap" })
    map.set("n", "<leader>uL",
      function() Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle() end,
      { desc = "Toggle Relative Number" })
    map.set("n", "<leader>ud", function() Snacks.toggle.diagnostics():toggle() end, { desc = "Toggle Diagnostics" })
    map.set("n", "<leader>ul", function() Snacks.toggle.line_number():toggle() end, { desc = "Toggle Line Number" })
    map.set("n", "<leader>uc",
      function()
        Snacks.toggle.option("conceallevel",
          { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):toggle()
      end,
      { desc = "Toggle Conceal Level" })
    map.set("n", "<leader>uT", function() Snacks.toggle.treesitter():toggle() end, { desc = "Toggle Treesitter" })
    map.set("n", "<leader>ub",
      function() Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle() end,
      { desc = "Toggle Dark Background" })
    map.set("n", "<leader>uh", function() Snacks.toggle.inlay_hints():toggle() end, { desc = "Toggle Inlay Hints" })
    map.set("n", "<leader>ug", function() Snacks.toggle.indent():toggle() end, { desc = "Toggle Indent Guides" })
    map.set("n", "<leader>uD", function() Snacks.toggle.dim():toggle() end, { desc = "Toggle Dim" })
  end,
  config = function()
    require("snacks").setup({
      dashboard = {
        enabled = true,
        preset = {
          header = require("constants.ascii").doom
        },
        sections = {
          { section = "header" },
          { section = "keys",   gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
      indent = {
        enabled = true,
        animate = {
          duration = {
            step = 20,
            total = 300,
          },
        }
      },
      input = {
        enabled = true
      },
      notifier = {
        enabled = true,
        timeout = 5000,
      },
      explorer = {
        enabled = true,
      },
      picker = {
        layout = {
          layout = {
            backdrop = 100,
          }
        },
        sources = {
          explorer = {
            auto_close = false,
            layout = {
              layout = {
                border = false,
                width = 32,
                mouse = true,
                minimal = true,
              }
            }
          }
        }
      },
      terminal = {
        win = {
          wo = {
            winbar = "",
          }
        },
      }
    })

    -- Top pickers & Explorer
    map.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart Find Files" })
    map.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "Notification History" })
    map.set("n", "<leader>e", function() Snacks.picker.explorer() end, { desc = "File Explorer" })

    -- Find
    map.set("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
    map.set("n", "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,
      { desc = "Find Config File" })
    map.set("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
    map.set("n", "<leader>fg", function() Snacks.picker.git_files() end, { desc = "Find Git Files" })
    map.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Projects" })
    map.set("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent" })

    -- Git
    map.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
    map.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
    map.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
    map.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
    map.set("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })
    map.set("n", "<leader>gd", function() Snacks.picker.git_diff() end, { desc = "Git Diff (Hunks)" })
    map.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Log File" })

    -- Search
    map.set("n", '<leader>s"', function() Snacks.picker.registers() end, { desc = "Registers" })
    map.set("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "History" })
    map.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
    map.set("n", "<leader>sb", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
    map.set("n", "<leader>sB", function() Snacks.picker.grep_buffers() end, { desc = "Open Buffers" })
    map.set("n", "<leader>sg", function() Snacks.picker.grep() end, { desc = "Grep" })
    map.set("n", "<leader>sc", function() Snacks.picker.command_history() end, { desc = "Command History" })
    map.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Commands" })
    map.set("n", "<leader>sd", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
    map.set("n", "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
    map.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help Pages" })
    map.set("n", "<leader>sH", function() Snacks.picker.highlights() end, { desc = "Highlights" })
    map.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })
    -- map.set("n", "<leader>sj", function() Snacks.picker.jumps() end, { desc = "Jumps" })
    map.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })
    -- map.set("n", "<leader>sl", function() Snacks.picker.loclist() end, { desc = "Location List" })
    map.set("n", "<leader>sm", function() Snacks.picker.marks() end, { desc = "Marks" })
    map.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Man Pages" })
    map.set("n", "<leader>sp", function() Snacks.picker.lazy() end, { desc = "Plugin Spec" })
    map.set("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
    map.set("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })
    ---@diagnostic disable-next-line
    map.set("n", "<leader>st", function() Snacks.picker.todo_comments() end, { desc = "Todo" })
    ---@diagnostic disable-next-line
    map.set("n", "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,
      { desc = "Todo/Fix/Fixme" })
    map.set("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo History" })
    map.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

    -- LSP
    map.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
    map.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
    map.set("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
    map.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
    map.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
    map.set("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
    map.set("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })

    -- Other
    map.set("n", "<leader>.", function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" })
    map.set("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
    map.set("n", "<leader>rf", function() Snacks.rename.rename_file() end, { desc = "Rename File" })
    map.set("n", "<c-/>", function() Snacks.terminal() end, { desc = "Toggle Terminal" })
  end
}
