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
  -- require('plugins.neo-tree'),
  {'nvim-tree/nvim-tree.lua'},
  require('plugins.telescope'),
  require('plugins.treesitter'),
  --color
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {'folke/tokyonight.nvim'},  -- Добавляем тему tokyonight  
  {'morhetz/gruvbox'},
  {'EdenEast/nightfox.nvim'},
})

-- Настройки плагинов
require('plugins.telescope')
require('plugins.nvim-tree')
require('plugins.colorshem')
-- Дополнительные настройки
require('settings.keymaps')
require('settings.options')

