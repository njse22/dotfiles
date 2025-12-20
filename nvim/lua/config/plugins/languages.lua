return {
  -- ------------------------------
  -- LaTeX
  -- ------------------------------
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_mappings_enabled = 1
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        options = {
          '-pdf',
          '-shell-escape',
          '-verbose',
          '-file-line-error',
          '-synctex=1',
          '-interaction=nonstopmode',
        },
      }
      vim.g.vimtex_quickfix_mode = 0
    end,
  },

  -- ------------------------------
  -- Markdown
  -- ------------------------------
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " } },
    },
    ft = { "markdown" },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function() vim.g.table_mode_corner = "|" end,
  },

  -- ------------------------------
  -- Java / Springboot
  -- ------------------------------
  "javiorfo/nvim-popcorn",
  "javiorfo/nvim-spinetta",
  "javiorfo/nvim-springtime",
  {
    "oclay1st/gradle.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" }
  }
}
