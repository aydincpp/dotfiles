return {
  "neovim/nvim-lspconfig",
  config = function()
    local group_prefix = require("constants.groups").group_prefix

    -- Enable LSP clients for the given servers
    vim.lsp.enable({ "lua_ls", "clangd", "cmake" })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup(group_prefix .. "lsp-attach", { clear = true }),
      callback = function(ev_attach)
        require("lsp.diagnostics") -- enable diagnostics

        -- Keymap utility
        local map = require("utils.map")

        -- Set buffer option for all LSP keymaps
        map.set_default_opts({ buffer = ev_attach.buf })

        -- This function resolves differences between Neovim nightly (0.11) and stable (0.10)
        -- Certain LSP methods require different arguments depending on the Neovim version
        ---@param client vim.lsp.Client         -- LSP client object
        ---@param method vim.lsp.protocol.Method -- LSP method to check support for
        ---@param bufnr? integer                -- Optional buffer number, as some LSP methods are buffer-specific
        ---@return boolean                      -- Returns true if client supports the method
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            ---@diagnostic disable-next-line:param-type-mismatch
            return client:supports_method(method, bufnr)
          else
            ---@diagnostic disable-next-line:param-type-mismatch
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- Get the LSP client object that triggered the attach event
        local client = vim.lsp.get_client_by_id(ev_attach.data.client_id)

        -- Create autocmds to highlight the symbol under the cursor
        -- Triggered on CursorHold and CursorHoldI (normal and insert modes)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, ev_attach.buf) then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = ev_attach.buf,
            group = vim.api.nvim_create_augroup(group_prefix .. "lsp-highlight", { clear = false }),
            callback = vim.lsp.buf.document_highlight
          })

          -- Clear highlights when moving the cursor
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = ev_attach.buf,
            group = vim.api.nvim_create_augroup(group_prefix .. "lsp-highlight", { clear = false }),
            callback = vim.lsp.buf.clear_references
          })

          -- When the LSP detaches from the buffer, clear highlights and remove autocmds
          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup(group_prefix .. "lsp-detach", { clear = false }),
            callback = function(ev_detach)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = group_prefix .. "lsp-highlight", buffer = ev_detach.buf })
            end
          })
        end

        -- Toggle inlay hints
        -- NOTE: Snacks override this
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, ev_attach.buf) then
          map.set("n",
            "<leader>lh",
            function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev_attach.buf })
            end,
            { desc = "Toggle Inlay Hints" })
        end

        -- Code action
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_codeAction, ev_attach.buf) then
          map.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        end

        -- Format
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_formatting, ev_attach.buf) then
          map.set("n", "<leader>f", function()
            vim.lsp.buf.format { bufnr = ev_attach.buf }
          end, { desc = "Format buffer" })

          -- format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup(group_prefix .. "lsp-format-on-save", { clear = true }),
            callback = function()
              vim.lsp.buf.format { bufnr = ev_attach.buf }
            end,
          })
        end

        -- Rename
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_rename, ev_attach.buf) then
          map.set("n", "<leader>rn", function()
            if pcall(require, "inc_rename") then
              return ":IncRename " .. vim.fn.expand("<cword>")
            else
              return ":lua vim.lsp.buf.rename()<CR>"
            end
          end, { desc = "Rename Symbol", expr = true })
        end

        -- Switch source/header file
        map.set("n", "<leader>cs", function()
          if vim.fn.exists(":LspClangdSwitchSourceHeader") ~= 0 then
            vim.cmd("LspClangdSwitchSourceHeader")
          else
            print("Command :LspClangdSwitchSourceHeader not available in this buffer")
          end
        end, { desc = "Switch Source/Header File" })

        -- Reset default_opts to what it was before calling
        -- map.set_default_opts()
        map.reset_default_opts()
      end
    })
  end
}
