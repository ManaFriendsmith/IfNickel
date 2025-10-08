local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["bztin"] then
    if data.raw.item["tinned-cable"] and misc.difficulty > 1 then
        rm.AddIngredient("fluid-regulator", "tinned-cable", 2)
        rm.RemoveIngredient("pumpjack", "tinned-cable", 5)
        if not data.raw.technology["electroplating"] then
            tm.AddPrerequisite("high-pressure-valve", "tinned-cable")
        end

        if misc.difficulty == 2 and not mods["ThemTharHills"] then
            rm.ReplaceIngredientProportional("electromagnetic-coil", "copper-cable", "tinned-cable")
        end

        if mods["space-age"] then
            --valves in biochamber need tin
            table.insert(data.raw["simple-entity"]["copper-stromatolite"].minable.results, {type="item", name="tin-ore", amount_min=2, amount_max=5})
            table.insert(data.raw["simple-entity"]["iron-stromatolite"].minable.results, {type="item", name="tin-ore", amount_min=2, amount_max=5})    
        end
    end

    if data.raw.item["electromagnetic-coil"] then
        --scarcity of solder on fulgora
        rm.MultiplyRecipe("electromagnetic-coil", mods["space-age"] and 4 or 2)
        rm.AddIngredient("electromagnetic-coil", "solder", 1)
    end

    if data.raw.item["cooling-fan"] then
        rm.AddIngredient("cooling-fan", "solder", 1)

        rm.RemoveIngredient("roboport", "solder", 99999)
        rm.RemoveIngredient("substation", "solder", 99999)
    end

    if data.raw.item["bronze-plate"] and misc.difficulty > 1 and not data.raw.item["spring"] then
        rm.AddIngredient("motorized-arm", "bronze-plate", 2)
        if mods["quality"] then
            rm.RemoveIngredient("recycler", "bronze-plate", 99999)
        end
    end
end

if mods["bzlead"] then
    if mods["space-age"] then
        rm.RemoveProduct("molten-lead-from-lava", {type="item", name="copper-ore", amount_min=2, amount_max=3})
        rm.AddProduct("molten-lead-from-lava", {type="item", name="malachite", amount_min=2, amount_max=3})

        --valves in biochamber need lead
        table.insert(data.raw["simple-entity"]["copper-stromatolite"].minable.results, {type="item", name="lead-ore", amount_min=4, amount_max=8})
        table.insert(data.raw["simple-entity"]["iron-stromatolite"].minable.results, {type="item", name="lead-ore", amount_min=4, amount_max=8})    
    end
end

if mods["bztitanium"] then
    if data.raw.item["nitinol-plate"] then
        data.raw.item["titanium-plate"].weight = 2.5 * kg
        rm.ReplaceIngredientProportional("steam-turbine", "titanium-plate", "nitinol-plate")
        rm.ReplaceIngredientProportional("heat-exchanger", "titanium-plate", "nitinol-plate")
    end
end

if mods["bzzirconium"] then
    if misc.difficulty == 2 then
        rm.AddIngredient("electromagnetic-coil", "zirconia", 1)
    end
end

if mods["bzsilicon"] then
    rm.AddIngredient("basic-crusher", "electric-motor", 6)
end