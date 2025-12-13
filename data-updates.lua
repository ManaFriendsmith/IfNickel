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

    local biggest_result_list = data.raw.furnace.recycler.result_inventory_size
    for k, v in pairs(data.raw.recipe) do
      if v.type == "recycling" or v.type == "recycling-or-hand-crafting" then
        if v.results and #v.results > biggest_result_list then
          biggest_result_list = #v.results
        end
      end
    end
    data.raw.furnace.recycler.result_inventory_size = biggest_result_list
    if mods["Age-of-Production"] then
        data.raw.furnace["aop-salvager"].result_inventory_size = biggest_result_list
    end
end