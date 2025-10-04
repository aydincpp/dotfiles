-- Diagnostic config
-- See :help vim.diagnostic.Opts

local diagnostic_icons = {
  [vim.diagnostic.severity.ERROR] = "󰅚",
  [vim.diagnostic.severity.WARN]  = "󰀪",
  [vim.diagnostic.severity.INFO]  = "󰋽",
  [vim.diagnostic.severity.HINT]  = "",
}

-- Display diagnostic icons in sign column
local show_sign_icons = false

-- Build signs table dynamically
local signs_text = {}
for sev, icon in pairs(diagnostic_icons) do
  signs_text[sev] = show_sign_icons and icon or ""
end

-- Helper function to get diagnostic text for virtual text or float
local function format_diagnostic(d)
  -- If signs are disabled, show icon inline; otherwise just message
  local icon = show_sign_icons and "" or diagnostic_icons[d.severity] .. " "
  return icon .. d.message
end

-- Helper function to get diagnostic highlight group
---@diagnostic disable-next-line
local function highlight_group(d)
  return
    d.severity == vim.diagnostic.severity.ERROR and "DiagnosticError" or
    d.severity == vim.diagnostic.severity.WARN  and "DiagnosticWarn" or
    d.severity == vim.diagnostic.severity.INFO  and "DiagnosticInfo" or
    d.severity == vim.diagnostic.severity.INFO  and "DiagnosticInfo" or
    "DiagnosticHint"
end

vim.diagnostic.config({
  signs = {
    text = signs_text
  },
  float = {
    border = "rounded",
    source = false,
    format = format_diagnostic,
    prefix = ""
  },
  underline = {
    severity = vim.diagnostic.severity.ERROR
  },
  virtual_text = {
    current_line = false,
    source = false,
    spacing = 2,
    prefix = "",
    format = format_diagnostic,
  },
  jump = {
    float = true;
    wrap = true;
  },
  update_in_insert = false
})
