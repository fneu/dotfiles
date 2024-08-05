MiniDeps.later(function()
    MiniDeps.add("pasky/claude.vim")
    vim.g.claude_api_key = os.getenv("CLAUDE_API_KEY")
    -- <leader>ci to refactor
    -- <leader>cc to chat
    --     - use <C-+> to send
end)
