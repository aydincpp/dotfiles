local M = {}

-- See :help map-modes
local valid_modes = {
    n = true, i = true, v = true, x = true,
    s = true, o = true, c = true, t = true,
    l = true, ["!"] = true
}

--- Check if a mode or list of modes is valid @param mode string|table Mode(s) to check
--- @return boolean True if all modes are valid
local function is_valid_mode(mode)
    local modes = type(mode) == "table" and mode or {mode}
    for _, m in ipairs(modes) do
        if not valid_modes[m] then return false end
    end
    return true
end

-- Default options for all keymaps
M.default_opts = { noremap = true, silent = true }

--- Set a keymap with default options.
--- This function merges the provided options with the current defaults (`M.default_opts`),
--- so you only need to specify options that differ from the defaults.
---
--- @param mode string|table The mode(s) in which the mapping applies ('n', 'i', 'v', etc.).
--- @param lhs string The left-hand side key sequence.
--- @param rhs string|function The right-hand side command or Lua function.
--- @param opts table? Optional keymap options that override the defaults.
--- @param safe boolean? If true, the function will not override existing keymaps. default is false.
function M.set(mode, lhs, rhs, opts, safe)
    if not is_valid_mode(mode) then
        vim.notify(
            string.format(
                "Invalid mode: %s",
                type(mode) == "table" and vim.inspect(mode) or mode
            ),
            vim.log.levels.ERROR
        )
        return
    end

    opts = vim.tbl_extend("force", M.default_opts, opts or {})
    safe = safe or false

    if safe and M.exists(mode, lhs) then
        return
    end

    vim.keymap.set(mode, lhs, rhs, opts)
end

--- Delete a keymap.
--- @param mode string|table The mode(s) in which the mapping was set
--- @param lhs string The key sequence to remove.
--- @param opts table? Optional. Additional options, e.g., { buffer = 0 } for buffer-local mappings.
---             If omitted, the keymap is deleted globally.
function M.del(mode, lhs, opts)
    if not is_valid_mode(mode) then
        vim.notify(
            string.format(
                "Invalid mode: %s",
                type(mode) == "table" and vim.inspect(mode) or mode
            ),
            vim.log.levels.ERROR
        )
        return
    end
    vim.keymap.del(mode, lhs, opts)
end

--- Temporarily modify default keymap options.
--- The previous defaults are saved internally.
--- WARN: Call reset_default_opts() after setting your keymaps
---       to restore the original default options.
function M.set_default_opts(new_opts)
    M._saved_opts = vim.tbl_extend("force", {}, M.default_opts)
    M.default_opts = vim.tbl_extend("force", M.default_opts, new_opts)
end

--- Restore the default keymap options to their previous state.
--- WARN: This must be called after temporarily modifying the defaults with
--- set_default_opts(). After calling this, M.default_opts will revert to what
--- it was before the last set_default_opts() call.
function M.reset_default_opts()
    M.default_opts = M._saved_opts
    M._saved_opts = nil
end

--- Check if a keymap exists.
--- Iterates over all keymaps in the given mode and returns true
--- if a mapping for the specified {lhs} is found.
---
--- @param mode string|string[] Single mode or a table of modes to check
--- @param lhs string The left-hand side key sequence to check
--- @return boolean True if the keymap exists, false otherwise
function M.exists(mode, lhs)
    local modes = type(mode) == "table" and mode or { mode }

    for _, m in ipairs(modes) do
        if not is_valid_mode(m) then
            vim.notify(string.format("%s is not a valid mode!", m), vim.log.levels.ERROR)
            return false
        end
        ---@diagnostic disable-next-line:param-type-mismatch
        local keymaps = vim.api.nvim_get_keymap(m)
        for _, km in ipairs(keymaps) do
            if km.lhs == lhs then return true end
        end
    end

    return false
end

---Register multiple keymaps at once.
---@param keymaps table list of keymap definitions
---@param safe boolean|nil when true, skip mappings that already exist
---@return nil
function M.batch(keymaps, safe)
    safe = safe or false
    for _, km in pairs(keymaps) do
        M.set(km.mode, km.lhs, km.rhs, km.opts, safe)
    end
end

return M
