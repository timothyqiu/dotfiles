return {
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {
            open_mapping = [[<c-\>]],
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return math.floor(vim.o.columns * 0.4)
                end
            end,
        },
        config = function(_, opts)
            require("toggleterm").setup(opts)

            function _G.set_terminal_keymaps()
                vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], { noremap = true })
            end

            vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
        end
    }
}
