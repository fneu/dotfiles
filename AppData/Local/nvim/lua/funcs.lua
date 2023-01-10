function _G.find_dotfiles()
    local path = vim.fn.expand("$HOME\\devel\\dotfiles")
    local env_path = vim.env.DOTFILES_DIR
    if env_path then
        path = env_path
    else
        vim.notify("Environment variable DOTFILES_DIR not set! Defaulting to " .. path, vim.log.levels.ERROR)
    end
    return path
end

function _G.find_nextcloud()
    local path = vim.fn.expand("$HOME\\Nextcloud")
    local env_path = vim.env.NEXTCLOUD_DIR
    if env_path then
        path = env_path
    else
        vim.notify("Environment variable NEXTCLOUD_DIR not set! Defaulting to " .. path, vim.log.levels.ERROR)
    end
    return path
end

function _G.load_snippets()
    local ok, from_lua = pcall(require, "luasnip.loaders.from_lua")
    if not ok then
        return
    end
    from_lua.load({paths = find_dotfiles() .. "/nvim/snippets"})
end

function _G.copy_config()
    local sink = vim.fn.stdpath("config")
    local source = find_dotfiles() .. "/nvim"
    if vim.fn.isdirectory(source) then
        if vim.fn.empty(vim.fn.glob(sink)) < 1 then
            vim.notify(sink .. " exists, removing...", vim.log.levels.INFO)
            os.execute('rd /s/q "' .. sink .. '"')
        end
        vim.notify("copying files from " .. source, vim.log.levels.INFO)
        os.execute("robocopy " .. source .. " " .. sink .. " /s /xx")
    else
        vim.notify("Cannot copy nvim config to home, source directory is invalid: " .. source, vim.log.levels.INFO)
    end
    vim.notify("nvim config went $HOME", vim.log.levels.INFO)
end
