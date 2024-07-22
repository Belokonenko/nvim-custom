-- lua/plugins/lspconfig.lua

return {
  'neovim/nvim-lspconfig',  -- Имя плагина
  config = function()
    local lspconfig = require('lspconfig')  -- Загружаем модуль lspconfig

    -- Общие настройки LSP (например, настройка отображения подсказок и справки)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }  -- Закругленные границы для всплывающих окон
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }  -- Закругленные границы для справки по функциям
    )

    -- Функция для настройки горячих клавиш и других параметров LSP при подключении к серверу
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')  -- Настройка автокомплита

      -- Маппинги для LSP
      local opts = { noremap=true, silent=true }

      -- Горячие клавиши для различных LSP команд
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)  -- Переход к объявлению
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)  -- Переход к определению
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)  -- Всплывающая подсказка
      buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)  -- Переход к реализации
      buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)  -- Подсказка по параметрам функции
      buf_set_keymap('n', '<leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)  -- Добавить рабочую папку
      buf_set_keymap('n', '<leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)  -- Удалить рабочую папку
      buf_set_keymap('n', '<leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)  -- Показать рабочие папки
      buf_set_keymap('n', '<leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)  -- Переход к определению типа
      buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)  -- Переименование символа
      buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)  -- Показать все ссылки на символ
      buf_set_keymap('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)  -- Показать доступные действия с кодом
      buf_set_keymap('n', '<leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)  -- Показать диагностические сообщения для строки
      buf_set_keymap('n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)  -- Перейти к предыдущей диагностике
      buf_set_keymap('n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)  -- Перейти к следующей диагностике
      buf_set_keymap('n', '<leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)  -- Добавить диагностику в локальный список
      buf_set_keymap('n', '<leader>so', [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)  -- Показать символы документа через Telescope
      vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]  -- Команда для форматирования документа
    end

    -- Настройка LSP серверов для различных языков
    local servers = { 'tsserver', 'cssls', 'html', 'eslint' }  -- Список LSP серверов
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,  -- Использование функции on_attach для настройки серверов
      }
    end

    -- Специальная настройка для tsserver (JavaScript и TypeScript)
    lspconfig.tsserver.setup {
      on_attach = on_attach,
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },  -- Файлы, которые обрабатывает сервер
      cmd = { "typescript-language-server", "--stdio" }  -- Команда для запуска сервера
    }

    -- Специальная настройка для cssls (CSS, SCSS и LESS)
    lspconfig.cssls.setup {
      on_attach = on_attach,
      cmd = { "vscode-css-language-server", "--stdio" },  -- Команда для запуска сервера
      filetypes = { "css", "scss", "less" },  -- Файлы, которые обрабатывает сервер
      settings = {
        css = { validate = true },  -- Включение валидации CSS
        scss = { validate = true },  -- Включение валидации SCSS
        less = { validate = true }  -- Включение валидации LESS
      }
    }

    -- Специальная настройка для html (HTML)
    lspconfig.html.setup {
      on_attach = on_attach,
      cmd = { "vscode-html-language-server", "--stdio" },  -- Команда для запуска сервера
      filetypes = { "html" },  -- Файлы, которые обрабатывает сервер
      settings = {
        html = {
          format = { enable = true },  -- Включение форматирования
          validate = { scripts = true, styles = true }  -- Включение валидации скриптов и стилей
        }
      }
    }

    -- Специальная настройка для eslint (линтер для JavaScript и TypeScript)
    lspconfig.eslint.setup {
      on_attach = on_attach,
      cmd = { "vscode-eslint-language-server", "--stdio" },  -- Команда для запуска сервера
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },  -- Файлы, которые обрабатывает сервер
      settings = { format = { enable = true } }  -- Включение форматирования
    }
  end,
}

