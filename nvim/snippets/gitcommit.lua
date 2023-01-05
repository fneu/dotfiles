local s = require("luasnip.nodes.snippet").S
local sn = require("luasnip.nodes.snippet").SN
local isn = require("luasnip.nodes.snippet").ISN
local t = require("luasnip.nodes.textNode").T
local i = require("luasnip.nodes.insertNode").I
local f = require("luasnip.nodes.functionNode").F
local c = require("luasnip.nodes.choiceNode").C
local d = require("luasnip.nodes.dynamicNode").D
local r = require("luasnip.nodes.restoreNode").R
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local parse = require("luasnip.util.parser").parse_snippet
local types = require("luasnip.util.types")

return {
    -- manually triggered
    s(
        "build",
        fmt(
            "build({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "ci",
        fmt(
            "ci({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "docs",
        fmt(
            "docs({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "feat",
        fmt(
            "feat({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "fix",
        fmt(
            "fix({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "perf",
        fmt(
            "perf({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "ref",
        fmt(
            "refactor({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "style",
        fmt(
            "style({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "test",
        fmt(
            "test({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    ),
    s(
        "chore",
        fmt(
            "chore({}): {}\n\n{}",
            {
                i(1),
                i(2),
                i(3)
            }
        )
    )
}, {}
