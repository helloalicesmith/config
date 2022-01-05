local cmd = vim.cmd

cmd([[
if has('termguicolors')
  set termguicolors
endif
]])

cmd([[
 set background=dark
 let g:gruvbox_material_background = 'hard'
]])

vim.cmd('colorscheme gruvbox-material')

require'lualine'.setup {
  options = {
    theme = 'gruvbox-material'
  }
}
