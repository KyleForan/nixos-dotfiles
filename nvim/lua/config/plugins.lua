vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      -- If the plugin isn't active in the current session yet, load it first
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      -- Trigger the tree-sitter parser update command
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/folke/flash.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.cmp" },
  { src = "https://github.com/nvimtools/none-ls.nvim" },
  { src = "https://github.com/catppuccin/nvim",                            name = "catppuccin" },
  { src = "https://github.com/kylechui/nvim-surround",                     version = vim.version.range("4.x") },
  { src = "https://github.com/folke/ts-comments.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/SmiteshP/nvim-navic" },
  { src = "https://github.com/utilyre/barbecue.nvim",                      name = "barbecue.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/Djancyp/better-comments.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" }

})

-- ColorScheme
require('catppuccin').setup({
    flavor = "mocha",
    transparent_background = true,
    float = {
        transparent = true,
        solid = true,
    },
})
vim.cmd.colorscheme("catppuccin-mocha")
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.cmd.packadd("nvim-autopairs")
    require("nvim-autopairs").setup({})
  end,
})

local bbq = require("barbecue")
bbq.setup({
  attach_mavic = true
})

local ts = require("nvim-treesitter")

ts.install({ "lua", "vim", "bash", "c", "python", "markdown", "json", "rust", "nix" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "vim", "sh", "c", "python", "markdown", "json", "rust", "nix" },
  callback = function(ev)
    vim.treesitter.start(ev.buf)
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("fidget").setup({})
require("oil").setup()
require('better-comment').Setup()
require("flash").setup({})
require("lualine").setup({ options = { theme = "ayu_mirage" } })

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.black,
  },
})

local cmp = require("blink.cmp")
cmp.build():pwait()
cmp.setup({
  keymap = { preset = "super-tab" },
  sources = { default = { "lsp", "path", "snippets", "buffer" } },
})

vim.keymap.set("n", "<Leader>g", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "zk", function()
  flash.jump()
end, { desc = "Flash" })

vim.keymap.set({ "n", "x", "o" }, "Zk", function()
  flash.treesitter()
end, { desc = "Flash Treesitter" })

vim.keymap.set("o", "r", function()
  flash.remote()
end, { desc = "Remote Flash" })

vim.keymap.set({ "o", "x" }, "R", function()
  flash.treesitter_search()
end, { desc = "Treesitter Search" })

vim.keymap.set({ "c" }, "<c-s>", function()
  flash.toggle()
end, { desc = "Toggle Flash Search" })

vim.keymap.set("n", "<Leader>g", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
