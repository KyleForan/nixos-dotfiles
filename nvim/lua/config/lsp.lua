vim.lsp.enable({ "lua_ls", "nil_ls", "pyright", "rust_analyzer", "ts_ls" })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local o = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, o)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, o)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, o)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, o)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, o)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, o)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, o)
    vim.keymap.set("n", "<C-s>", function()
      vim.lsp.buf.format({ async = true })
    end, o)
  end,
})
