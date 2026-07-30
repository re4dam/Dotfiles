-- Enable setting the window title
vim.o.title = true

-- Define the format for the window title
-- %{getpid()} gets the unique process ID
-- %t shows just the filename
-- %m shows a [+] if the file is modified
vim.o.titlestring = "Neovide [PID:%{getpid()}] - %t %m"

-- Creates a command that takes one argument (the name)
vim.api.nvim_create_user_command("NameTitle", function(opts)
  -- Sets the title to your argument, plus the filename and modified status
  vim.o.titlestring = opts.args .. " - %t %m"
end, { nargs = 1, desc = "Set a custom name for the Neovide window title" })

--  Creates a command that resets the title of a window
vim.api.nvim_create_user_command("ResetTitle", function()
  vim.o.titlestring = "Neovide [PID:%{getpid()}] - %t %m"
end, { nargs = 0, desc = "Reset the Neovide window title to the default" })
