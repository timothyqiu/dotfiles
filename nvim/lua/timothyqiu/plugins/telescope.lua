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
            vim.keymap.set("n", "<leader>pf", builtin.find_files, {})

            -- Ctrl-P compatible
            vim.keymap.set("n", "<C-p>", builtin.git_files, {})

            -- Project Search
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set("n", "<leader>pg", builtin.grep_string, {})
        end
    },
}
