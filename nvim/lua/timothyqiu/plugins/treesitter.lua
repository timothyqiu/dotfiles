return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            -- Parsers are installed inside `<package_dir>/parser`
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "html",
                "javascript",
                "json",
                "lua",
                "markdown",
                "python",
                "vim",
                "vimdoc",
                "yaml",
                "zig",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
            vim.opt.foldlevelstart = 99
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = true,
        opts = {
        },
    }
}
