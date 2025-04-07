vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80,100"
vim.opt.cursorline = true

vim.opt.listchars="tab:→ ,trail:␣"
vim.opt.list = true

vim.opt.wildignore = {
    '*.a',
    '*.so',
    '*.o',
    '*.swp',
}

require('keymaps')
require('plugins')
