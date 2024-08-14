return {
    -- pairs
    {
        "windwp/nvim-autopairs",
        config = true,
    },
    -- surround
    {
        "tpope/vim-surround",
    },
    -- comment
    {
        "terrortylor/nvim-comment",
        dependencies = {
            { "JoosepAlviste/nvim-ts-context-commentstring" },
        },
        config = function()
            require("nvim_comment").setup({
                hook = function ()
                    require('ts_context_commentstring.internal').update_commentstring()
                end
            })
        end,
    },
    -- copilot
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set('i', '<C-J>', 'copilot#Accept("")', {
                expr = true, replace_keycodes = false
            })
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { ["*"] = false, cpp = true, c = true, lua = true }
        end
    },
}
