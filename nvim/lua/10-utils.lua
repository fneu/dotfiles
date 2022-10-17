function _G.find_dotfiles()
    path = vim.env.DOTFILES_DIR
    if not path then
        vim.notify("Environment variable DOTFILES_DIR not set!", vim.log.levels.ERROR)
    end
    return path
end

function _G.find_nextcloud()
    path = vim.env.NEXTCLOUD_DIR
    if not path then
        vim.notify("Environment variable NEXTCLOUD_DIR not set!", vim.log.levels.ERROR)
    end
    return path
end
