-- init.lua

-----------------------------------------------------------
--- Leader keys
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------------
--- Sane defaults
-----------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true

-----------------------------------------------------------
--- Set indentation to 2 spaces globally
-----------------------------------------------------------
vim.opt.tabstop = 2       -- number of spaces a <Tab> counts for
vim.opt.shiftwidth = 2    -- number of spaces for each indentation step
vim.opt.expandtab = true  -- convert tabs to spaces

-----------------------------------------------------------
--- Basic keymaps
-----------------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-----------------------------------------------------------
--- Bootstrap lazy.nvim plugin manager
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
--- Plugins
-----------------------------------------------------------
require("lazy").setup({
  ---------------------------------------------------------
  --- Telescope: fuzzy finder
  ---------------------------------------------------------
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },

  ---------------------------------------------------------
  --- Statusline: lualine
  ---------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  ---------------------------------------------------------
  --- Colorscheme: tokyonight
  ---------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm", -- storm, night, day, moon
      transparent = false,
    },
  },

  ---------------------------------------------------------
  --- File explorer: nvim-tree
  ---------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sort_by = "case_sensitive",
      view = {
        width = 30,
        side = "left",
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
      },
    },
  },

  ---------------------------------------------------------
  --- Show keybindings: which-key
  ---------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = { enabled = true }, -- shows spelling suggestions
      },
      window = {
        border = "rounded", -- nice rounded borders
      },
      layout = {
        align = "center",
      },
    },
  },

  ---------------------------------------------------------
  --- Syntax highlighting: treesitter
  ---------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- auto-update parsers
    opts = {
      ensure_installed = { "c_sharp", "json", "bash", "lua", "vim", "vimdoc", "c", "cpp", "python", "javascript", "html", "css" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
}, {
  ui = { border = "rounded" },
  checker = { enabled = true },
})

-----------------------------------------------------------
--- Colorscheme activation
-----------------------------------------------------------
vim.cmd.colorscheme("tokyonight")

-----------------------------------------------------------
--- Telescope keymaps
-----------------------------------------------------------
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep,  { desc = "Search text (ripgrep)" })
map("n", "<leader>fb", builtin.buffers,    { desc = "List buffers" })
map("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })

-----------------------------------------------------------
--- Toggle nvim-tree
-----------------------------------------------------------
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus file explorer" })

-----------------------------------------------------------
--- Setup which-key
-----------------------------------------------------------
local wk = require("which-key")

wk.register({
  ["<leader>f"] = { name = "+file/find" },
  ["<leader>w"] = { name = "+write" },
  ["<leader>q"] = { name = "+quit" },
  ["<leader>h"] = { name = "+highlight" },
  ["<leader>e"] = { name = "+explorer" },
}, { prefix = "<leader>" })

