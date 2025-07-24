-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
opt.expandtab = true -- Use spaces instead of tabs

-- require("onedark").setup({
--   style = "dark",
-- })
-- require("onedark").load()

vim.opt.autoindent = false
vim.opt.smartindent = false
vim.opt.cindent = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dart",
  callback = function()
    vim.bo.shiftwidth = 4 -- Controls auto-indent width
    vim.bo.tabstop = 4 -- Sets tab width to 4 spaces
    vim.bo.softtabstop = 4 -- Makes <Tab> insert 4 spaces
    vim.bo.expandtab = true -- Converts tabs to spaces
  end,
})

vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_python_ruff = "ruff"

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_theme = "auto"
end

-- Enable setting the window title
vim.o.title = true

-- Define the format for the window title
-- %{getpid()} gets the unique process ID
-- %t shows just the filename
-- %m shows a [+] if the file is modified
vim.o.titlestring = "Neovide [PID:%{getpid()}] - %t %m"

-- Creates a command that takes one argument (the name)
vim.api.nvim_create_user_command("NameWindow", function(opts)
  -- Sets the title to your argument, plus the filename and modified status
  vim.o.titlestring = opts.args .. " - %t %m"
end, { nargs = 1, desc = "Set a custom name for the Neovide window title" })

vim.api.nvim_create_user_command("ResetTitle", function()
  vim.o.titlestring = "Neovide [PID:%{getpid()}] - %t %m"
end, { nargs = 0, desc = "Reset the Neovide window title to the default" })
