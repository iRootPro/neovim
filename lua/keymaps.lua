vim.keymap.set("n", "QQ", ":qa!<CR>", {})
vim.keymap.set("n", "<leader>qw", ":wqa!<CR>", {})
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", {})
vim.keymap.set("n", "<leader>sh", ":split<CR>", {})
vim.keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, {})

