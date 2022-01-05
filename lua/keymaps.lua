local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('n', 'C-t', ':tabnew <CR>', default_opts)
map('n', 'F1', ':Prettier<CR>', default_opts)

map('n', '<leader>f', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<cr>', default_opts)
map('n', '<C-p>', ':lua require("telescope.builtin").git_files()<cr>', default_opts)
map('n', '<space>', ':lua require("telescope.builtin").buffers()<cr>', default_opts)

