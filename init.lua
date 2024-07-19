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
  
-- цветовой схемы 
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {'folke/tokyonight.nvim'},  -- Добавляем тему tokyonight  
  {'morhetz/gruvbox'},
  {'EdenEast/nightfox.nvim'},
})

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
-------------------------------------------------------------------

  -- Настройка nvim-tree
require('nvim-tree').setup({
  view = {
    width = 30,
    side = 'left',
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
})

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Настройка перемещения по окнам
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Открыть папку с файлом в системе
vim.api.nvim_set_keymap('n', '<C-o>', ':lua vim.fn.system("xdg-open " .. vim.fn.expand("%:p:h"))<CR>', { noremap = true, silent = true })

