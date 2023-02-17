return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.setup_nvim_cmp {
                select_behavior = 'insert',
            }
            lsp.ensure_installed({
                'clangd',
                'zls',
            })
            lsp.nvim_workspace()
            lsp.on_attach(function (_, bufnr)
                local opts = {buffer = bufnr, remap = false}

                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

                vim.diagnostic.config({
                    virtual_text = true
                })
            end)
            lsp.setup()

            -- add command :A to :ClangdSwitchSourceHeader
            vim.api.nvim_create_user_command("A", "ClangdSwitchSourceHeader", {})

            local ls = require("luasnip")
            local t = ls.text_node
            local i = ls.insert_node
            ls.add_snippets("zig", {
                ls.snippet("std", {
                    t("const std = @import(\"std\");"),
                }),
                ls.snippet("ma", {
                    t("pub fn main() !void {"),
                    i(0),
                    t("}"),
                }),
                ls.snippet("tst", {
                    t("test \""),
                    i(1),
                    t("\" {"),
                    i(0),
                    t("}"),
                }),
                ls.snippet("rts", {
                    t("return switch ("),
                    i(1),
                    t(") {"),
                    i(0),
                    t("};"),
                }),
                ls.snippet("st", {
                    t("struct {"),
                    i(0),
                    t("};"),
                }),
                ls.snippet("en", {
                    t("enum {"),
                    i(0),
                    t("};"),
                }),
                ls.snippet("un", {
                    t("union {"),
                    i(0),
                    t("};"),
                }),
            })
        end
    },
}
