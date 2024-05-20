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

local namespace = function()
    local path = vim.fn.expand("%:h"):match("src[/\\](.*)")
    if path == nil then
        path = vim.fn.expand("%:h"):match("tests[/\\](.*)")
    end
    if path == nil then
        return "fail"
    else
        local ns, _ = path:gsub("[/\\]", ".")
        return ns
    end
end

return {
    -- manually triggered
    s(
        "///",
        fmt(
            "/// <summary>\n/// {}\n/// </summary>\n{}",
            {
                i(1),
                i(2)
            }
        )
    ),
    s(
        "namespace",
        fmt(
            "namespace {}",
            {
                f(namespace)
            }
        )
    ),
    s(
        "finterface",
        fmt(
            [[
                {}
                {{
                    public interface {}
                    {{
                        {}
                    }}
                }}
            ]],
            {
                f(namespace, {}),
                f(
                    function()
                        return vim.fn.expand("%:t:r")
                    end,
                    {}
                ),
                i(1)
            }
        )
    ),
    s(
        "class",
        fmt(
            [[
                ///<summary>
                /// {}
                ///</summary>
                public sealed class {} : {}
                {{
                    ///<summary>
                    /// {}
                    ///</summary>
                    public {}({})
                    {{{} }}
                }}
            ]],
            {
                i(1),
                i(2),
                i(3),
                rep(1),
                rep(2),
                i(4),
                i(5)
            }
        )
    ),
    s(
        "fclass",
        fmt(
            [[
                namespace {}
                {{
                    ///<summary>
                    /// {}
                    ///</summary>
                    public sealed class {} : {}
                    {{
                        ///<summary>
                        /// {}
                        ///</summary>
                        public {}({})
                        {{{} }}
                    }}
                }}
            ]],
            {
                f(namespace, {}),
                i(1),
                f(
                    function()
                        return vim.fn.expand("%:t:r")
                    end,
                    {}
                ),
                i(2),
                rep(1),
                f(
                    function()
                        return vim.fn.expand("%:t:r")
                    end,
                    {}
                ),
                i(3),
                i(4)
            }
        )
    )
}, {}
