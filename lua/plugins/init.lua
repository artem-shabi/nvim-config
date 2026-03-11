return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "l", api.node.open.edit, { buffer = bufnr, desc = "nvimtree open" })
      end,
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- загрузка перед сохранением для работы автоформата
    opts = require "configs.conform",
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      require("go").setup(opts)
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require("go.format").goimports()
        end,
        group = format_sync_grp,
      })
      return {
        -- lsp_keymaps = false,
        -- other options
      }
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          require("nvim-tree.api").tree.close()
          require("persistence").save()
        end,
      })
      -- auto-restore session when nvim opened with no args
      if vim.fn.argc() == 0 then
        vim.api.nvim_create_autocmd("VimEnter", {
          nested = true,
          once = true,
          callback = function()
            require("persistence").load()
            require("nvim-tree.api").tree.open()
          end,
        })
      end
    end,
  },

  -- {
  --   "milanglacier/minuet-ai.nvim",
  --   lazy = false,
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     require("minuet").setup {
  --       provider = "openai_compatible",
  --       n_completions = 1,
  --       context_window = 512,
  --       provider_options = {
  --         openai_compatible = {
  --           model = "GLM-4.7-flash",
  --           api_key = "Z_AI_API_KEY",
  --           end_point = "https://api.z.ai/api/coding/paas/v4/chat/completions",
  --           name = "ZAI",
  --           optional = {
  --             max_tokens = 256,
  --             top_p = 0.9,
  --           },
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if cmp.is_visible() then
              return cmp.select_next()
            end
            --return require("minuet").make_blink_map()
          end,
          "fallback",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- providers = {
        --   minuet = {
        --     name = "minuet",
        --     module = "minuet.blink",
        --     score_offset = 8,
        --   },
        -- },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "go",
      },
    },
  },
}
