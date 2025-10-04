-- The goal of nvim-treesitter is both to provide a simple and easy way to use
-- the interface for tree-sitter in Neovim and to provide some basic
-- functionality such as highlighting based on it.

return {
  "nvim-treesitter/nvim-treesitter",

  -- Install from the 'master' branch
  branch = "master",

  -- Run :TSUpdate after installing/updating to ensure parsers are up-to-date
  build = ":TSUpdate",

  -- Always load at startup
  lazy = false,

  config = function()
    require("nvim-treesitter.configs").setup({
      -- List of parsers to install and keep updated
      ensure_installed = {
        "lua", "c", "cpp", "html", "css", "doxygen", "python", "typescript",
        "javascript", "bash", "json", "yaml", "toml", "vim", "vimdoc", "query",
        "markdown", "markdown_inline"
      },

      -- Don't block startup for parser installation
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- Enable syntax highlighting using Tree-sitter
      highlight = {
        enable = true,
        -- Use Vim regex highlighting in addition to Tree-sitter
        additional_vim_regex_highlighting = false,
      },

      -- Enable Tree-sitter based indentation
      indent = {
        enable = true,
      },

      -- Incremental selection allows expanding/shrinking selection by syntax nodes
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",     -- Start selection
          node_incremental = "<CR>",   -- Expand to next node
          node_decremental = "<BS>",   -- Shrink selection
          scope_incremental = "<TAB>", -- Expand to scope
        },
      },
    })
  end,
}
