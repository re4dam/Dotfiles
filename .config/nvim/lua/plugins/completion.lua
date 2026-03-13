require("lspconfig").ruff.setup({})
require("lspconfig").pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff", "black" },
    lua = { "stylua" },
    sh = { "shfmt" },
    blade = { "blade-formatter" },
  },
})
require("lspconfig").qmlls.setup({})
require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.blade = {
--   install_info = {
--     url = "https://github.com/EmranMR/tree-sitter-blade",
--     files = { "src/parser.c" },
--     branch = "main",
--   },
--   filetype = "blade",
-- }

vim.lsp.enable("bashls")

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
        "latex",
        "python",
        "c",
        "cpp",
        "php",
        "java",
        "toml",
        "jsonc",
        "dart",
        "rust",
        "css",
      },
    },
    vim.filetype.add({ pattern = {
      ["*.blade.php"] = "blade",
    } }),
  },

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
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

  -- this plugins features the blade filetype for php blade files
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
  "seblyng/roslyn.nvim",
  ---@module 'roslyn.config'
  ---@type RoslynNvimConfig
  opts = {
    -- your configuration comes here; leave empty for default settings
  },
}
