return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            {'nvim-lua/plenary.nvim'},
        },
        config = function()
            require("telescope").setup({})

            local builtin = require("telescope.builtin")

            -- Project Files
            -- vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
            vim.keymap.set("n", "<C-p>", builtin.find_files, {})

            -- Ctrl-P compatible
            -- vim.keymap.set("n", "<C-p>", builtin.git_files, {})

            -- Project Search
            vim.keymap.set("n", "<leader>ps", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>pg", builtin.grep_string, {})

            -- Symbols
            vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, {})
        end
    },
}
