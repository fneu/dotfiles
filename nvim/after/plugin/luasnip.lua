local ok, luasnip = pcall(require, "luasnip")
if not ok then
    return
end

local types = require "luasnip.util.types"
local s = luasnip.s
local fmt = require("luasnip.extras.fmt").fmt
local i = luasnip.insert_node
local rep = require("luasnip.extras").rep

luasnip.config.set_config {
    -- jump back into last snippet
    history = true,
    -- update dynamic snippets more often
    updateevents = "TextChanged,TextChangedI",

    -- Autosnippets:
    -- TODO: maybe remove? (performance penalty)
    enable_autosnippets = true,

    -- from https://www.youtube.com/watch?v=Dn800rlPIho
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } }
            }
        }
    }
}

luasnip.add_snippets("all", {
        s("req", fmt("local {} = require('{}')", {i(1, "default"), rep(1)})),

    })
