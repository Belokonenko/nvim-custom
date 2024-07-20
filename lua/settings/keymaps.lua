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
