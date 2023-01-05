local ok, luasnip = pcall(require, "luasnip")
if not ok then
    return
end

luasnip.config.setup(
    {
        -- jump back into last snippet
        history = true,
        -- update dynamic snippets more often
        updateevents = "TextChanged,TextChangedI",
        -- Auto trigger some snippets (performance penalty!)
        enable_autosnippets = false,
        -- from https://www.youtube.com/watch?v=Dn800rlPIho
        ext_opts = {
            [require("luasnip.util.types").choiceNode] = {
                active = {
                    virt_text = {{"<-", "Choice"}}
                }
            }
        }
    }
)

-- require("luasnip.loaders.from_lua").load({paths = "./snippets"})
load_snippets()
