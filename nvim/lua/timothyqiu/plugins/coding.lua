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
        config = function()
            require("nvim_comment").setup()

            local group = vim.api.nvim_create_augroup('set-commentstring-ag', {})
            local autocmd = vim.api.nvim_create_autocmd
            autocmd({ "BufEnter", "BufFilePost" }, {
                group = group,
                pattern = "*.cpp,*.h,*.zig",
                callback = function()
                    vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
                end
            })
        end,
    },
    -- markdown table
    {
        "junegunn/vim-easy-align",
        config = function()
            vim.keymap.set('x', 'ga', ':EasyAlign*|<Enter>', { silent = true, noremap = true })
        end
    },
    -- copilot
    {
        "github/copilot.vim",
        config = function()
            vim.keymap.set('i', '<C-J>', 'copilot#Accept("")', {
                expr = true, replace_keycodes = false
            })
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_filetypes = { ["*"] = false, cpp = true, c = true, zig = true, lua = true, python = true }
        end
    },
}
