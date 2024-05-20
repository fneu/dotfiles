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
    from_lua.load({paths = vim.fn.stdpath("config") .. "/snippets"})
end
