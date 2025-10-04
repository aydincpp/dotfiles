local M = {}

--- Resize the current window horizontally
-- @param amount number Positive for right, negative for left
function M.resize_horizontal(amount)
    local win = vim.api.nvim_get_current_win()
    local col = vim.api.nvim_win_get_position(win)[2]
    local width = vim.api.nvim_win_get_width(win)

    local total_cols = vim.o.columns

    -- Window is at the left of the screen
    if col == 0 then
        if amount > 0 then
            vim.cmd(math.abs(amount) .. "wincmd>")
        else
            vim.cmd(math.abs(amount) .. "wincmd<")
        end


        -- Window is at the rigth of the screen
    elseif col + width == total_cols then
        if amount > 0 then
            vim.cmd(math.abs(amount) .. "wincmd<")
        else
            vim.cmd(math.abs(amount) .. "wincmd>")
        end


        -- Window is somewhere in the middle (has neighbors left and right)
    else
        local cur_win = vim.fn.win_getid()

        -- Get the left neighbor (if any)
        local left_nr = vim.fn.winnr("h")
        if left_nr == 0 then return end -- no left neighbor

        local left_win = vim.fn.win_getid(left_nr)

        -- Resize relative to the left neighbor
        if amount > 0 then
            vim.api.nvim_set_current_win(left_win)
            vim.cmd(math.abs(amount) .. "wincmd>")
            vim.api.nvim_set_current_win(cur_win)
        else
            vim.api.nvim_set_current_win(left_win)
            vim.cmd(math.abs(amount) .. "wincmd<")
            vim.api.nvim_set_current_win(cur_win)
        end
    end
end


--- Resize the current window vertically
-- @param amount number Positive for up, negative for down
function M.resize_vertical(amount)
    local win = vim.api.nvim_get_current_win()
    local row = vim.api.nvim_win_get_position(win)[1]
    local height = vim.api.nvim_win_get_height(win)

    local total_rows = vim.o.lines

    -- Window is at the top of the screen
    if row == 0 then
        if amount > 0 then
            vim.cmd(math.abs(amount) .. "wincmd-")
        else
            vim.cmd(math.abs(amount) .. "wincmd+")
        end


        -- Window is at the bottom of the screen
    elseif row + height == total_rows then
        if amount > 0 then
            vim.cmd(math.abs(amount) .. "wincmd+")
        else
            vim.cmd(math.abs(amount) .. "wincmd-")
        end


        -- Window is somewhere in the middle (has neighbors above and below)
    else
        local cur_win = vim.api.nvim_get_current_win()

        local bottom_nr = vim.fn.winnr("j")
        if bottom_nr == 0 then return end

        local bottom_win = vim.fn.win_getid(bottom_nr)

        -- Resize relative to the bottom neighbor
        if amount > 0 then
            vim.api.nvim_set_current_win(bottom_win)
            vim.cmd(math.abs(amount) .. "wincmd+")
            vim.api.nvim_set_current_win(cur_win)
        else
            vim.api.nvim_set_current_win(bottom_win)
            vim.cmd(math.abs(amount) .. "wincmd-")
            vim.api.nvim_set_current_win(cur_win)
        end
    end
end

return M
