-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.vscode then
  print("vscode do not need theme")
else
  vim.cmd.colorscheme("monokai-nightasty")
end
