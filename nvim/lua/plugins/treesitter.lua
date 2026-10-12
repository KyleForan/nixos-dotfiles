return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        -- Tell tree-sitter where to write the compiled parsers
        vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

        require('nvim-treesitter').setup({
            -- Use ensure_installed instead of an install function
            ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "c" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
        })
    end,
}

-- {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	branch = "main",
-- 	lazy = false,
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		require("nvim-treesitter").setup({})
-- 		require("nvim-treesitter").install({ "lua", "vim", "vimdoc", "query", "python", "c" })
-- 	end,
-- }
