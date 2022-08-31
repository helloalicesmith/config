local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

map("n", "<F1>", ":LspFormatting<CR>", default_opts)

-- map('n', '<leader>f', ':lua require("telescope.builtin").grep_string({ search = vim.fn.input("Grep For > ")})<cr>', default_opts)
map("n", "<C-_>", ":Telescope current_buffer_fuzzy_find prompt_position=top<cr>", default_opts)

map("n", "<leader>r", ":Telescope lsp_references<cr>", default_opts)

map(
	"n",
	"<leader>g",
	':lua require("telescope.builtin").grep_string(require("telescope.themes").get_ivy({search = vim.fn.input("Grep For > ")}))<cr>',
	default_opts
)

map(
	"n",
	"<leader>l",
	':lua require"telescope.builtin".live_grep(require("telescope.themes").get_ivy({}))<cr>',
	default_opts
)
map("n", "<leader>b", ':lua require("telescope.builtin").buffers()<cr>', default_opts)
map(
	"n",
	"<leader>o",
	':lua require("telescope").extensions.frecency.frecency(require("telescope.themes").get_ivy({}))<cr>',
	default_opts
)

map("n", "<leader>p", ':lua require("my_config.telescope").project_files()<cr>', default_opts)

map("n", "<F2>", "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>", default_opts)
map(
	"n",
	"<leader><F2>",
	"<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd = vim.fn.expand('%:p:h') })<CR>",
	default_opts
)
map("n", "~", "<cmd>lua require 'telescope.builtin'.marks()<CR>", default_opts)
map("n", "<leader>e", ":e %:h/", {
	noremap = true,
})

map("n", "<Up>", ":resize -2<CR>", default_opts)
map("n", "<Down>", ":resize +2<CR>", default_opts)
map("n", "<Left>", ":vertical resize -2<CR>", default_opts)
map("n", "<Right>", ":vertical resize +2<CR>", default_opts)

-- Navigate buffers
map("n", "<S-l>", ":BufferLineCycleNext<CR>", default_opts)
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", default_opts)

-- Move buffers
map("n", "<C-h>", ":BufferLineMovePrev<CR>", default_opts)
map("n", "<C-l>", ":BufferLineMoveNext<CR>", default_opts)

map("n", "<C-c>", ":lua require('bufdelete').bufdelete(bufnum, true)<CR>", default_opts)

map("n", "<F4>", ":lua require'telescope'.extensions.project.project{}<CR>", default_opts)

map("i", "<c-v>", "<ESC>:set paste<CR>gi<C-R>+<ESC>:set nopaste<CR>gi", default_opts)

-- quickfix list
map("n", "<leader>q", ":copen <CR>", default_opts)
map("n", "<c-j>", ":cnext <CR>", default_opts)
map("n", "<c-k>", ":cprev <CR>", default_opts)

vim.cmd("command! Gb Gitsigns toggle_current_line_blame")

map("n", "gqr", ":cdo s/// | update", default_opts)
