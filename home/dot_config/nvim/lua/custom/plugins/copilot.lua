return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = false },
    },
    config = function(_, opts)
      require('copilot').setup(opts)

      vim.api.nvim_create_autocmd('User', {
        pattern = 'BlinkCmpMenuClose',
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })
    end,
  },
  {
    'AndreM222/copilot-lualine',
    opt = {},
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- Performance and async settings
      auto_insert_mode = true, -- Automatically enter insert mode
      show_help = false, -- Disable help message on startup

      -- Window configuration for better performance
      window = {
        layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
        width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
        height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
        -- Options below only apply to floating windows
        relative = 'editor', -- 'editor', 'win', 'cursor', 'mouse'
        border = 'single', -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        row = nil, -- row position of the window, default is centered
        col = nil, -- column position of the window, default is centered
        title = 'Copilot Chat', -- title of chat window
        footer = nil, -- footer of chat window
        zindex = 1, -- determines if window is on top or below other floating windows
      },

      -- Selection settings for better UX
      selection = function(source)
        local select = require 'CopilotChat.select'
        return select.unnamed(source) -- Use unnamed register for selection
      end,

      -- Prompts configuration (optimized for speed)
      prompts = {
        Explain = {
          prompt = '/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').line(source)
          end,
        },
        Review = {
          prompt = '/COPILOT_REVIEW Review the selected code.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Fix = {
          prompt = '/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Optimize = {
          prompt = '/COPILOT_GENERATE Optimize the selected code to improve performance and readability.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Docs = {
          prompt = '/COPILOT_GENERATE Please add documentation comment for the selection.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
        Tests = {
          prompt = '/COPILOT_GENERATE Please generate tests for my code.',
          selection = function(source)
            return require('CopilotChat.select').visual(source) or require('CopilotChat.select').buffer(source)
          end,
        },
      },
    },

    -- Optional: Add some convenient keymaps
    keys = {
      { '<leader>cc', '<cmd>CopilotChat<cr>', desc = 'CopilotChat' },
      { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>ct', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate tests' },
      { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - Fix code' },
      { '<leader>co', '<cmd>CopilotChatOptimize<cr>', desc = 'CopilotChat - Optimize code' },
      { '<leader>cd', '<cmd>CopilotChatDocs<cr>', desc = 'CopilotChat - Generate docs' },
    },
  },
}
