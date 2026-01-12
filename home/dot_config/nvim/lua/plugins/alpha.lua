return {
  'goolord/alpha-nvim',
  -- dependencies = { 'nvim-mini/mini.icons' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  enabled = false,
  config = function()
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      '                                                     ',
      '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
      '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
      '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
      '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
      '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
      '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
      '                                                     ',
    }

    dashboard.section.buttons.val = {
      dashboard.button('e', '  > New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('b', '  > Browse files', ':Oil<CR>'),
      dashboard.button('z', '  > Browse Directories', '<cmd>lua require("snacks").picker.zoxide()<CR>'),
      dashboard.button('f', '󰈞  > Find file', '<cmd>lua require("snacks").picker.files()<CR>'),
      dashboard.button('r', '  > Recent', '<cmd>lua require("snacks").picker.recent()<CR>'),
    }

    dashboard.opts.opts.noautocmd = true
    require('alpha').setup(dashboard.config)
  end,
}
