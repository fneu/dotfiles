function _G.reload_config()
  old_config_dir = vim.fn.stdpath('config')
  dotfiles = find_dotfiles()
  if dotfiles then
    new_config_dir = dotfiles..'/nvim'
    if vim.fn.empty(vim.fn.glob(old_config_dir)) < 1 then
        vim.notify(old_config_dir.." exists, removing...", vim.log.levels.INFO)
        os.execute('rd /s/q "'..old_config_dir..'"')
    end
    vim.notify("copying files from "..new_config_dir, vim.log.levels.INFO)
    os.execute('robocopy '..new_config_dir..' '..old_config_dir..' /s /xx')
  else
    vim.notify("no dotfiles found, loading current "..old_config_dir, vim.log.levels.INFO)
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

vim.keymap.set(
    'n',
    '<leader>ii',
    '<cmd>lua reload_config()<CR>', 
    {desc = 'Reload init.lua'})
    
vim.keymap.set(
    'n',
    '<leader>ie',
    '<cmd>e '..find_dotfiles()..'\\nvim\\lua<CR>', 
    {desc = 'Edit nvim config in dotfiles'})
