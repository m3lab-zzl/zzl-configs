-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- bind <space>fl to trigger fortran highlighting setting
-- :let b:fortran_fixed_source=0
-- :set syntax=fortran
vim.api.nvim_set_keymap('n', '<leader>fl', ':let b:fortran_fixed_source=0<CR>:set syntax=fortran<CR>', {noremap = true})
