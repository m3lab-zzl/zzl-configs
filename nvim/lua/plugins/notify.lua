return {
  "rcarriga/nvim-notify",
  keys = {
    -- add a keymap to browse plugin files
    {
      "<leader>sn",
      function()
        require("telescope").extensions.notify.notify()
      end,
      desc = "search notification",
    },
  },
}
