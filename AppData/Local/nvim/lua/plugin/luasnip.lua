return {
    {
        "L3MON4D3/LuaSnip",
        config = function(_, _)
            require "luasnip".config.setup(
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

            load_snippets()
        end
    }
}
