vim.o.number = true
vim.o.relativenumber = false
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.termguicolors = true
vim.o.signcolumn = 'yes'
vim.o.clipboard = 'unnamedplus'


-- Установка и настройка lazy.nvim
local function ensure_lazy()
  local lazypath = vim.fn.stdpath('data')..'/site/pack/lazy/start/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--depth', '1',
      'https://github.com/folke/lazy.nvim',
      lazypath
    })
  end
  vim.opt.runtimepath:append(lazypath)
end

-- Установить lazy.nvim, если он не установлен
ensure_lazy()

-- Настройка lazy.nvim
require('lazy').setup({
	
  {'nvim-tree/nvim-tree.lua'},
------------------------------------------------------------------
-- Установка Telescope и его зависимости

{ 
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
------------------------------------------------------------------
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {'folke/tokyonight.nvim'},  -- Добавляем тему tokyonight  
  {'morhetz/gruvbox'},
  {'EdenEast/nightfox.nvim'},
})

-- Настройки плагинов
require('plugins.telescope')
require('plugins.nvim-tree')

-- Дополнительные настройки
require('settings.keymaps')
require('settings.options')


-- Настройка цветовой схемы capuchin
-- vim.cmd[[colorscheme catppuccin]]

-- vim.cmd('colorscheme gruvbox')
-- --Настройки для gruvbox
-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.g.gruvbox_invert_selection = 1
-- vim.g.gruvbox_transparent_bg = 1
-- vim.g.gruvbox_italic = 1
-- vim.g.gruvbox_bold = 1
-- vim.g.gruvbox_sign_column = 'bg0'
-- vim.g.gruvbox_sidebar = 'dark'


-- --Настройка темы tokyonight
-- require('tokyonight').setup({
--   style = 'night',  -- Можно выбрать 'storm' или 'day'
--   transparent = false,
--   terminal_colors = true,
--   styles = {
--     comments = { italic = true },
--     functions = { bold = true },
--   },
-- })
-- -- Активируем тему
-- vim.cmd('colorscheme tokyonight')


vim.cmd('colorscheme carbonfox') -- Используем Carbonfox из nightfox

-- vim.cmd('colorscheme terafox') -- Используем Terafox из nightfox-









-- Установите лидера
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Настройка перемещения по окнам
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Открыть папку с файлом в системе
-- vim.api.nvim_set_keymap('n', '<C-o>', ':lua vim.fn.system("xdg-open " .. vim.fn.expand("%:p:h"))<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<M-k>', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-j>', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-l>', ':vertical resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<M-h>', ':vertical resize -2<CR>', { noremap = true, silent = true })



-- Открытие новой вкладки
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })

-- Переключение на следующую вкладку
vim.api.nvim_set_keymap('n', '<leader>tl', ':tabnext<CR>', { noremap = true, silent = true })

-- Переключение на предыдущую вкладку
vim.api.nvim_set_keymap('n', '<leader>tr', ':tabprevious<CR>', { noremap = true, silent = true })

-- Закрытие текущей вкладки
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })

-- Показ списка всех вкладок
vim.api.nvim_set_keymap('n', '<leader>ts', ':tabs<CR>', { noremap = true, silent = true })

-- Горячая клавиша для закрытия текущего буфера
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true })
