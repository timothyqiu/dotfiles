-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabstops
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,100"
vim.opt.cursorline = true

vim.opt.wildignore = {
    '*.a',
    '*.so',
    '*.o',
    '*.swp',
}

-- netrw
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 75
