-- lua/plugins/neo-tree.lua

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- рекомендуется, но не обязательно
    'MunifTanjim/nui.nvim',
    -- '3rd/image.nvim', -- Опционально для поддержки изображений
  },
  config = function()
    require('neo-tree').setup({
      sources = { 'filesystem', 'git_status' },
      window = {
        width = 30,
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['<cr>'] = 'open',
          ['<c-v>'] = 'open_vsplit',
          ['<c-x>'] = 'open_split',
          ['<c-t>'] = 'open_tabnew',
          ['<c-f>'] = 'filter_on_cwd',
          ['<c-n>'] = 'create',
          ['<c-d>'] = 'remove',
          ['<c-r>'] = 'rename',
          ['<c-y>'] = 'copy_to_clipboard',
          ['<c-p>'] = 'paste_from_clipboard',
          ['<c-s>'] = 'search',
          ['<c-e>'] = 'edit',
        },
      },
      filesystem = {
        follow_current_file = true,
        hijack_netrw = true,
        use_libuv_file_watcher = true,
      },
      git_status = {
        window = {
          position = 'float',
        },
      },
      buffers = {
        show_unloaded = true,
      },
    })

    -- Настройка горячих клавиш
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = '[E]xplore filesystem' })
    vim.keymap.set('n', '<leader>f', ':Neotree focus<CR>', { desc = '[F]ocus on filesystem' })
  end,
}

