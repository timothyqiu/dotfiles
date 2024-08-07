return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-buffer' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'onsails/lspkind.nvim' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            lsp_zero.on_attach(function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('lspconfig').zls.setup({})

            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {},
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,

                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require("lspconfig").lua_ls.setup(lua_opts)
                    end,
                },
            })

            local cmp = require("cmp");
            local luasnip = require("luasnip")
            require('luasnip.loaders.from_vscode').lazy_load()
            cmp.setup({
                sources = {
                    { name = "path" },
                    { name = "nvim_lsp" },
                    { name = "nvim_lua" },
                    { name = "buffer",  keyword_length = 3 },
                    { name = "luasnip", keyword_length = 2 },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                formatting = {
                    fields = { 'abbr', 'kind', 'menu' },
                    format = require("lspkind").cmp_format({
                        mode = 'symbol',
                        maxwidth = 30,
                        ellipsis_char = '...',
                    }),
                },
            })

            -- add command :A to :ClangdSwitchSourceHeader
            vim.api.nvim_create_user_command("A", "ClangdSwitchSourceHeader", {})
        end
    },
}
