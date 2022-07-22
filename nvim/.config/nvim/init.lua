vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.textwidth = 80
vim.opt.formatoptions:remove({'t'})
vim.o.expandtab = true
vim.o.updatetime = 300
vim.o.signcolumn = 'number'
vim.o.timeoutlen = 300

require "theme"
require "keymap"
require "gitsigns".setup()
