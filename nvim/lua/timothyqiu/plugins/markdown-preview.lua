return {
    {
        "iamcco/markdown-preview.nvim",
        built = "cd app && yarn install",
        ft = "markdown",
        config = function()
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_auto_close = 1
            vim.g.mkdp_refresh_slow = 1
            vim.g.mkdp_command_for_global = 0
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_browser = "/usr/bin/qutebrowser"
            vim.g.mkdp_page_title = "Markdown Preview"
            vim.g.mkdp_open_to_the_world = 0
        end
    }
}
