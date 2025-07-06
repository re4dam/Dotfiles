require("lspconfig").ruff.setup({})
require("lspconfig").pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})

return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
        -- clangd SHOULD be automatically installed
        clangd = {},
        -- ruff SHOULD be automatically installed
        ruff = {},
        jdtls = {},
        intelephense = { settings = { intelephense = { format = { enable = true } } } },
      },
    },
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "python",
        "c",
        "cpp",
        "php",
        "java",
        "toml",
        "jsonc",
        "dart",
        "markdown",
        "rust",
      },
    },
  },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "clangd",
        "ruff",
        "pyright",
        "intelephense",
      },
    },
  },
  {
    "jwalton512/vim-blade",
    config = function()
      -- Optional: Add custom configurations if needed
      vim.cmd([[autocmd BufNewFile,BufRead *.blade.php set filetype=blade]])
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
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
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- UI for debugging
      "mfussenegger/nvim-dap-python", -- Python-specific adapter
      "nvim-telescope/telescope-dap.nvim", -- Telescope integration
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-python").setup("python") -- Ensure `debugpy` is installed in your Python environment

      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          console = "integratedTerminal",
        },
      }

      -- Setup UI
      dapui.setup()
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    end,
  },
  -- {
  --   "haydenkz/nvim-wingman",
  --   lazy = false, -- Load immediately (recommended for real-time suggestions)
  --   dependencies = { "nvim-lua/plenary.nvim" }, -- Required for HTTP requests
  --   config = function()
  --     require("wingman").setup({
  --       api_key = "your-grok-api-key", -- Replace with your xAI Grok API key
  --       useOllama = false, -- Set to true to use Ollama instead of Grok
  --       model = "grok-2-latest", -- Specify the model to use
  --       ollama_url = "http://localhost:11434", -- Ollama API endpoint
  --       grok_url = "https://api.x.ai/v1/chat/completions", -- Grok API endpoint
  --     })
  --   end,
  -- },
}
