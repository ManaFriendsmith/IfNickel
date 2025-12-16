local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["LunarLandings"] then
    if misc.difficulty > 1 then
        rm.AddIngredient("ll-rocket-part-nauvis", "gimbaled-rocket-engine", 5)
        rm.AddIngredient("ll-rocket-part-luna", "gimbaled-rocket-engine", 5)
        rm.AddIngredient("ll-rocket-part-interstellar", "gimbaled-rocket-engine", 5)
        rm.AddProduct("ll-used-rocket-part-recycling", {type="item", name="gimbaled-rocket-engine", amount_min=2, amount_max=4})

        rm.AddRecipeCategory("electromagnetic-coil", "circuit-crafting")
    end
    rm.AddRecipeCategory("electric-motor", "circuit-crafting")

    rm.ReplaceIngredientProportional("ll-heat-shielding", "steel-plate", "invar-plate")

    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("ll-low-grav-assembling-machine", "advanced-circuit", "motorized-arm")

        rm.AddIngredient("ll-ion-logistic-robot", "grabber", 5)
        rm.AddIngredient("ll-ion-construction-robot", "grabber", 1)
    elseif misc.difficulty == 2 then
        rm.AddIngredient("ll-ion-logistic-robot", "motorized-arm", 3)
        rm.AddIngredient("ll-ion-construction-robot", "motorized-arm", 3)
    end

    if mods["space-age"] and misc.difficulty == 3 then
        rm.AddIngredient("ll-processing-unit-without-silicon", "cooling-fan", 1)
    end

    if mods["space-age"] and misc.difficulty > 1 then
        tm.AddSciencePack("bioculture-productivity", "ll-space-science-pack")
        tm.AddSciencePack("bioculture-productivity", "ll-quantum-science-pack")
    end

    if not data.raw.item["stepper-motor"] then
        rm.AddIngredient("ll-ion-roboport", "electric-motor", 50)
    end
end

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
        rm.AddIngredient("maraxsis-empty-research-vessel", "non-reversible-tremie-pipe", 1)
    else
        rm.AddIngredient("maraxsis-empty-research-vessel", "high-pressure-valve", 3)
    end

    rm.AddRecipeCategory("high-pressure-valve", "maraxsis-hydro-plant")
    rm.AddRecipeCategory("fluid-regulator", "maraxsis-hydro-plant")
    rm.AddRecipeCategory("gimbaled-rocket-engine", "maraxsis-hydro-plant")
    rm.AddRecipeCategory("non-reversible-tremie-pipe", "maraxsis-hydro-plant")
    rm.AddRecipeCategory("self-regulating-valve", "maraxsis-hydro-plant")
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

    if not (mods["ThemTharHillsMk2"] and misc.difficulty > 1) then
        rm.AddIngredient("mechanical-plant", "electric-motor", 20)
    end

    table.insert(data.raw["simple-entity"]["big-metallic-rock"].minable.results, {type="item", name="nickel-ore", amount_min=5, amount_max=11})

    if misc.difficulty > 1 then
        rm.ReplaceIngredientProportional("electric-coil", "copper-cable", "electromagnetic-coil", 0.5)
        data.raw.item["electric-coil"].localised_name = {"item-name.tripolar-electromagnet"}
        data.raw.recipe["electric-coil"].localised_name = {"item-name.tripolar-electromagnet"}
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

if mods["castra"] then
    data.raw.planet["castra"].map_gen_settings.autoplace_controls["nickel-ore"] = {}
    data.raw.planet["castra"].map_gen_settings.autoplace_settings.entity.settings["nickel-ore"] = {}

    data.raw.item["cst-nickel-plate"].localised_name = {"item-name.cobalt-plate"}
    data.raw.item["millerite"].localised_name = {"item-name.glaucodot"}
    data.raw.resource["millerite"].localised_name = {"entity-name.glaucodot"}
    data.raw.unit["data-collector-millerite"].localised_name = {"entity-name.glaucodot"}
    data.raw["autoplace-control"]["millerite"].localised_name = {"", "[entity=millerite]", {"entity-name.glaucodot"}}

    data.raw.recipe["nickel-extraction"].localised_name = {"recipe-name.cobalt-extraction"}
    data.raw.recipe["nickel-sulfide-reduction"].localised_name = {"recipe-name.cobalt-sulfide-reduction"}
    data.raw.recipe["advanced-nickel-processing"].localised_name = {"recipe-name.advanced-cobalt-processing"}
    data.raw.technology["advanced-nickel-processing"].localised_name = {"recipe-name.advanced-cobalt-processing"}
    data.raw.recipe["holmium-catalyzing"].localised_name = {"recipe-name.holmium-catalyzing-cobalt"}
    data.raw.recipe["battery-nickel"].localised_name = {"recipe-name.battery-cobalt"}
    data.raw.recipe["tank-nickel"].localised_name = {"recipe-name.tank-cobalt"}
    data.raw.recipe["firearm-magazine-nickel"].localised_name = {"recipe-name.firearm-magazine-cobalt"}
    data.raw.recipe["piercing-rounds-catalyzing"].localised_name = {"recipe-name.piercing-rounds-glaucodot"}

    if misc.difficulty == 3 then
        tm.AddUnlock("gunpowder-processing", "ambifacient-lunar-waneshaft-gunpowder", "-engine-unit-gunpowder")
        tm.RemoveUnlock("gunpowder-processing", "engine-unit-gunpowder")
        tm.RemoveUnlock("engine-productivity", {type="change-recipe-productivity", recipe="engine-unit-gunpowder"})
        data.raw.recipe["engine-unit-gunpowder"] = nil
        rm.AddIngredient("tank-nickel", "ambifacient-lunar-waneshaft", 20)
        rm.AddIngredient("processing-unit-battlefield-data", "cooling-fan", 4)
    else
        rm.ReplaceIngredientProportional("engine-unit-gunpowder", "pipe", "high-pressure-valve", 0.5)
    end
    rm.AddIngredient("battery-nickel", "nickel-plate", 1)
end

if mods["planet-muluna"] then
    if misc.difficulty > 1 then
        rm.AddIngredient("electric-engine-unit-from-carbon", "electromagnetic-coil", 10)
        tm.AddPrerequisite("gimbaled-rocket-engine-productivity", "interstellar-science-pack")
        tm.AddSciencePack("gimbaled-rocket-engine-productivity", "interstellar-science-pack")
    else
        rm.AddIngredient("electric-engine-unit-from-carbon", "nickel-plate", 6)
    end

    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("muluna-vacuum-heating-tower", "pipe", "non-reversible-tremie-pipe", 0.25)
        rm.AddIngredient("casting-low-density-structure-aluminum", "invar-plate", 2)
    else
        rm.ReplaceIngredientProportional("casting-low-density-structure-aluminum", "molten-iron", "invar-plate", 1/40)
    end

    if data.raw.item["nitinol-plate"] then
        rm.ReplaceIngredientProportional("muluna-cycling-steam-turbine", "pipe", "self-regulating-valve")
    else
        rm.ReplaceIngredientProportional("muluna-cycling-steam-turbine", "pipe", "high-pressure-valve")
    end

    if mods["BrassTacksMk2"] then
        tm.RemoveUnlock("advanced-asteroid-processing", "advanced-metallic-asteroid-crushing")
        tm.AddUnlock("metallic-asteroid-crushing", "advanced-metallic-asteroid-crushing")
    else
        tm.AddUnlock("metallic-asteroid-crushing", "asteroid-crushing-for-nickel")
        tm.AddUnlock("asteroid-productivity", {type="change-recipe-productivity", recipe="asteroid-crushing-for-nickel", change=0.1})
    end
end

if mods["Cerys-Moon-of-Fulgora"] then
    tm.AddUnlock("cerys-nuclear-scrap-recycling", "invar-separation")
    if misc.difficulty > 1 then
        rm.AddProduct("cerys-nuclear-scrap-recycling", {type="item", name="fluid-regulator", amount=1, probability=0.01})
    else
        rm.AddProduct("cerys-nuclear-scrap-recycling", {type="item", name="high-pressure-valve", amount=1, probability=0.01})
    end

    if misc.difficulty == 3 then
        rm.AddIngredient("cerys-processing-units-from-nitric-acid", "cooling-fan", 1)
    end
end