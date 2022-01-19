local cmd = vim.cmd
local exec = vim.api.nvim_exec
local g = vim.g
local opt = vim.opt

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

g.translate_source = 'ru'
g.translate_target = 'en'
g.mapleader = ' '

opt.number = true
opt.relativenumber = true

opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 2        -- shift 4 spaces when tab
opt.tabstop = 2           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines
opt.termguicolors = true
opt.swapfile = false
opt.hlsearch = false
opt.mouse = 'a'

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

-- "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd = vim.fn.expand('%:p:h') })<CR>",

