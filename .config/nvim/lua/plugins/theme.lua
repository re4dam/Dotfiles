return {
  -- add onedark
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "dark",
      })
      require("onedark").load()
    end,
  },
  {
    "EdenEast/nightfox.nvim",
  }, -- lazy

  -- Configure LazyVim to load onedark
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
  -- vim.cmd("colorscheme nordfox"),
  -- vim.cmd("colorscheme onedark"),
}
