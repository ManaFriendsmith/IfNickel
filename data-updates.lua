local rm = require("__pf-functions__/recipe-manipulation")
local misc = require("__pf-functions__/misc")

require("compat/vanilla")
if mods["space-age"] then
    require("compat/space-age")
end

require("compat/bz")
require("compat/mod-planets")
require("compat.small-mod")

require("compat.deadlock")

if mods["quality"] and misc.last_pf_mod == "IfNickelMk2" then
    rm.FixStackingRecycling()
    require("__quality__/data-updates.lua")
end