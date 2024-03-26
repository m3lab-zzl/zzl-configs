-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- disable mouse to enable mouse copy over ssh
vim.opt.mouse = ""

if vim.g.vscode then
  print("vscode do not need theme")
else
  vim.cmd.colorscheme("monokai-nightasty")
end
