local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

--mods that just use vanilla-like ore generation will not get special design effort
if mods["tenebris"] then
    data.raw.planet["tenebris"].map_gen_settings.autoplace_controls["nickel-ore"] = {}
    data.raw.planet["tenebris"].map_gen_settings.autoplace_settings.entity.settings["nickel-ore"] = {}    
end

if mods["terrapalus"] then
    data.raw.planet["terrapalus"].map_gen_settings.autoplace_controls["nickel-ore"] = {}
    data.raw.planet["terrapalus"].map_gen_settings.autoplace_settings.entity.settings["nickel-ore"] = {}    
end

if mods["maraxsis"] then
    if data.raw.item["nitinol-plate"] then
        rm.ReplaceIngredientProportional("maraxsis-hydro-plant", "pipe", "self-regulating-valve")
    else
        rm.ReplaceIngredientProportional("maraxsis-hydro-plant", "pipe", misc.difficulty == 1 and "high-pressure-valve" or "fluid-regulator")
    end

    rm.ReplaceIngredientProportional("maraxsis-pressure-dome", "pipe", "pump", 0.2)
    if misc.difficulty == 3 then
        rm.AddIngredient("maraxsis-hydro-plant", "non-reversible-tremie-pipe", 1)
        rm.AddIngredient("maraxsis-salt-reactor", "non-reversible-tremie-pipe", 10)
    end
end

--cerys: I'm really not sure if you can obtain all ores in decent ratios from recycling stuff.
--as I understand it cerys is a meticulously designed puzzle, adding explicit compat would almost be like adding compat with ultracube

--arrakis, shattered planet: incomplete

if mods["Paracelsin"] then
    if data.raw.item["nitinol-plate"] then
        table.insert(data.raw["simple-entity"]["crashed-fulgoran-pod"].minable.results, {type="item", name="nitinol-plate", amount_min=4, amount_max=10})
        table.insert(data.raw["simple-entity"]["crashed-fulgoran-pod"].minable.results, {type="item", name="self-regulating-valve", amount_min=1, amount_max=2}) -- needed to craft turbines
        rm.AddIngredient("electrochemical-plant", "self-regulating-valve", 10)
        rm.AddIngredient("zinc-pump", "self-regulating-valve")
        rm.AddIngredient("elevated-pipe", "self-regulating-valve")
    else
        table.insert(data.raw["simple-entity"]["crashed-fulgoran-pod"].minable.results, {type="item", name="invar-plate", amount_min=1, amount_max=6})
        table.insert(data.raw["simple-entity"]["crashed-fulgoran-pod"].minable.results, {type="item", name="high-pressure-valve", amount_min=1, amount_max=2}) -- needed to craft turbines
        if misc.difficulty > 1 then
            rm.AddIngredient("electrochemical-plant", "fluid-regulator", 10)
        else
            rm.AddIngredient("electrochemical-plant", "high-pressure-valve", 10)
        end
    end

    if not (mods["ThemTharHills"] and misc.difficulty > 1) then
        rm.AddIngredient("mechanical-plant", "electric-motor", 20)
    end

    table.insert(data.raw["simple-entity"]["big-metallic-rock"].minable.results, {type="item", name="nickel-ore", amount_min=5, amount_max=11})

    if misc.difficulty > 1 then
        rm.ReplaceIngredientProportional("electric-coil", "copper-cable", "electromagnetic-coil", 0.5)
        data.raw.item["electric-coil"].localised_name = {"item-name.tripolar-electromagnet"}
    else
        rm.ReplaceIngredientProportional("electric-coil", "iron-gear-wheel", "nickel-plate", 1)
    end

    if misc.difficulty == 3 then
        rm.AddIngredient("paracelsin-processing-units-from-nitric-acid", "cooling-fan", 1)
    end

    rm.AddRecipeCategory("high-pressure-valve", "mechanics")
    rm.AddRecipeCategory("fluid-regulator", "mechanics")
    rm.AddRecipeCategory("motorized-arm", "mechanics")
    rm.AddRecipeCategory("grabber", "mechanics")

    rm.AddProduct("tetrahedrite-processing", "nickel-ore")
    rm.RemoveProduct("tetrahedrite-processing", "zinc-ore")
end