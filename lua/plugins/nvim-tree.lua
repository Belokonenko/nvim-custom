require('nvim-tree').setup({
  view = {
    width = 30, -- Ширина окна дерева
    side = 'right', -- Размещение дерева слева
  },
  filters = {
    dotfiles = true, -- Показ скрытых файлов
  },
  git = {
    enable = true, -- Включить интеграцию с git
  },
  actions = {
    open_file = {
      quit_on_open = true, -- Закрыть дерево при открытии файла
    },
  },
  renderer = {
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = true,
      }
    }
  },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Настройка горячих клавиш
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Открыть'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Открыть'))
    vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Открыть'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Открыть: Вертикальное разделение'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Открыть: Горизонтальное разделение'))
    vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Открыть: Новая вкладка'))
    vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Родительская директория'))
    vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Закрыть директорию'))
    vim.keymap.set('n', '<S-CR>', api.node.navigate.parent_close, opts('Закрыть директорию'))
    vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Предпросмотр'))
    vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('Первый сосед'))
    vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Последний сосед'))
    vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Переключить игнорирование git'))
    vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Переключить скрытые файлы'))
    vim.keymap.set('n', 'R', api.tree.reload, opts('Обновить'))
    vim.keymap.set('n', 'a', api.fs.create, opts('Создать'))
    vim.keymap.set('n', 'd', api.fs.remove, opts('Удалить'))
    vim.keymap.set('n', 'r', api.fs.rename, opts('Переименовать'))
    vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Переименовать: Без имени файла'))
    vim.keymap.set('n', 'x', api.fs.cut, opts('Вырезать'))
    vim.keymap.set('n', 'c', api.fs.copy.node, opts('Копировать'))
    vim.keymap.set('n', 'p', api.fs.paste, opts('Вставить'))
    vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Копировать имя'))
    vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Копировать относительный путь'))
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Копировать абсолютный путь'))
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Предыдущий git'))
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Следующий git'))
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Вверх'))
    vim.keymap.set('n', 's', api.node.run.system, opts('Запустить системное приложение'))
    vim.keymap.set('n', 'q', api.tree.close, opts('Закрыть'))
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Помощь'))
  end,
})

-- Дополнительные глобальные горячие клавиши
-- vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
