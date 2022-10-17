function _G.reload_config()
  dot_dir = find_dotfiles()
  if dot_dir then
    vim.notify(dot_dir.."/install.ps1")
    if vim.fn.empty(vim.fn.glob(vim.fn.stdpath('config'))) < 1 then
        vim.notify("nvim_dir exists, removing...")
        os.execute('rd /s/q "'..vim.fn.stdpath('config')..'"')
    end
    vim.notify("copying files")
    os.execute('robocopy '..dot_dir..'/nvim '..vim.fn.stdpath('config')..' /s /xx')
  end
  -- all packages starting with 00- to 99- will be reloaded, and init.lua will be reread.
  -- this might fail to update some plugin configs as their packages will not be reloaded
  for name,_ in pairs(package.loaded) do
    if name:match('^%d%d%-') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("init.lua reloaded!", vim.log.levels.INFO)
end

-- reload config
vim.keymap.set(
    'n',
    '<leader>ri',
    '<cmd>lua reload_config()<CR>', 
    {desc = 'Reload init.lua'})
    
 
