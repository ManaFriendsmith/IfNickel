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