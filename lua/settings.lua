local cmd = vim.cmd
local exec = vim.api.nvim_exec
local g = vim.g
local opt = vim.opt

g.translate_source = 'ru'
g.translate_target = 'en'

opt.number = true
opt.relativenumber = true

opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 2        -- shift 4 spaces when tab
opt.tabstop = 2           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
opt.termguicolors = true
opt.swapfile = false
opt.hlsearch = false

cmd([[
filetype indent plugin on
syntax enable
]])

cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
-- Подсвечивает на доли секунды скопированную часть текста
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)

vim.api.nvim_set_keymap(
  "n",
  "<F2>",
  "<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
  {noremap = true}
)

vim.api.nvim_set_keymap(
  "n",
  "<C-F2>",
  "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd = vim.fn.expand('%:p:h') })<CR>",
  {noremap = true}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":e %:h/",
  {noremap = true}
)

-- "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd = vim.fn.expand('%:p:h') })<CR>",

