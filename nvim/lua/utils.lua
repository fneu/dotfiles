function _G.reload_config()
  for name,_ in pairs(package.loaded) do
    if name:match('^utils') or name:match('^options') or name:match('^plugins') or name:match('^keymaps') or name:match('^autocmds') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("init.lua reloaded!", vim.log.levels.INFO)
end
