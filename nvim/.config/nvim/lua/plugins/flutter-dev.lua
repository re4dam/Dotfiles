return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      require("lspconfig").dartls.setup({
        cmd = { "dart", "language-server", "--protocol=lsp" },
      })
    end,
  },
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
  },
}
