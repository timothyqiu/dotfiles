local packages = {
    'savq/paq-nvim',
    'nvim-lualine/lualine.nvim',
    'tpope/vim-surround',
    'tpope/vim-repeat',
    'tpope/vim-sleuth',
    'tpope/vim-vinegar',
    'tpope/vim-unimpaired',
    'github/copilot.vim',

    { 'catppuccin/nvim', as = 'catppuccin' },

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'nvim-treesitter/nvim-treesitter-context',

    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope.nvim', branch = '0.1.x' },

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',

    'lewis6991/gitsigns.nvim',
}

local function setup_plugins()
    -- Theme
    require('lualine').setup {
        options = {
            section_separators = '',
            component_separators = '',
        },
    }
    require('catppuccin').setup { transparent_background = true }
    vim.cmd.colorscheme 'catppuccin'

    -- Autocomplete
    local cmp = require('cmp')
    cmp.setup {
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm { select = true },
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }),
    }
    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
        if vim.fn['vsnip#jumpable'](1) ~= 0 then
            return '<Plug>(vsnip-jump-next)'
        else
            return '<Tab>'
        end
    end, { expr = true })
    vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
        if vim.fn['vsnip#jumpable'](-1) ~= 0 then
            return '<Plug>(vsnip-jump-prev)'
        else
            return '<Tab>'
        end
    end, { expr = true })
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- require("nvim-autopairs").setup {}

    -- LSP
    vim.lsp.config('*', { capabilities = capabilities })
    vim.lsp.enable('zls')
    require('mason').setup()
    require('mason-lspconfig').setup {
        ensure_installed = { 'clangd' },
    }
    vim.api.nvim_create_user_command('A', 'LspClangdSwitchSourceHeader', {})

    -- GitHub Copilot
    vim.g.copilot_filetypes = { ['*'] = false, cpp = true, c = true, zig = true, python = true, html = true }
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
    })
    vim.g.copilot_no_tab_map = true

    -- Syntax Highlight
    require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Enter>",
                node_incremental = "<Enter>",
                scope_incremental = false,
                node_decremental = "<Backspace>",
            },
        },
    }
    require("treesitter-context").setup {
        max_lines = 8,
    }

    -- Navigation
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-P>', builtin.find_files)
    vim.keymap.set('n', '<leader>gS', builtin.live_grep)
    vim.keymap.set('n', '<leader>gs', builtin.grep_string)
    vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols)
end

local function clone_paq()
    local path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
    local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
    if not is_installed then
        vim.fn.system { 'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', path }
        return true
    end
end

local function bootstrap_paq()
    local first_install = clone_paq()
    vim.cmd.packadd('paq-nvim')
    local paq = require('paq')
    if first_install then
        vim.notify('Installing plugins... If prompted, hit Enter to continue.')
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'PaqDoneInstall',
        callback = setup_plugins,
    })
    paq(packages)
    paq.install()
end

bootstrap_paq()
