return {
    {
        "tpope/vim-fugitive",
        config = function()
            -- Git Status
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },
}
