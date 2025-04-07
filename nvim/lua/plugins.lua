local packages = {
    'savq/paq-nvim',
    'nvim-lualine/lualine.nvim',
    'tpope/vim-surround',
    'tpope/vim-fugitive',
    'tpope/vim-vinegar',
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

    -- LSP
    require('lspconfig').zls.setup {
        capabilities = capabilities,
    }
    require('mason').setup()
    require('mason-lspconfig').setup {
        ensure_installed = { 'clangd' },
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                }
            end
        }
    }
    vim.api.nvim_create_user_command('A', 'ClangdSwitchSourceHeader', {})

    -- GitHub Copilot
    vim.g.copilot_filetypes = { ['*'] = false, cpp = true, c = true }
    vim.g.copilot_no_tab_map = true
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
    })

    -- Syntax Highlight
    require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
    }

    -- Navigation
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-P>', builtin.find_files)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
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
