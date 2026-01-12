return {
  'xvzc/chezmoi.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  keys = {
    {
      '<leader>cz',
      function()
        require('chezmoi.pick').snacks()
      end,
      desc = 'ChezMoi managed files',
    },
  },
}
