local cmd = vim.cmd
local exec = vim.api.nvim_exec
local g = vim.g
local opt = vim.opt

g.translate_source = "en"
g.translate_target = "en"
g.mapleader = " "

opt.number = true
opt.relativenumber = true

opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 2 -- shift 4 spaces when tab
opt.tabstop = 2 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines
opt.termguicolors = true
opt.swapfile = false
opt.hlsearch = false
opt.mouse = "a"

opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.splitright = true
opt.splitbelow = true

-- cmd([[
-- filetype indent plugin on
-- syntax enable
-- ]])

cmd([[
autocmd Filetype python setlocal makeprg=flake8
]])

cmd([[
autocmd BufEnter * set formatoptions-=cro
]])

cmd([[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
-- Подсвечивает на доли секунды скопированную часть текста
exec(
	[[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]],
	false
)
cmd([[
" trigger `autoread` when files changes on disk
  set autoread
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
]])

-- "<cmd>lua require 'telescope'.extensions.file_browser.file_browser({ cwd = vim.fn.expand('%:p:h') })<CR>",
