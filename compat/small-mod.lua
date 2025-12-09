local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["se-space-trains"] then
    if misc.difficulty > 1 then
        rm.AddIngredient("space-locomotive", "electromagnetic-coil", 100)
        rm.AddIngredient("space-cargo-wagon", "electromagnetic-coil", 100)
        rm.AddIngredient("space-fluid-wagon", "electromagnetic-coil", 100)
        if #data.raw.recipe["space-locomotive"].ingredients > 5 then
            rm.RemoveIngredient("space-locomotive", "steel-plate", 99999)
            rm.RemoveIngredient("space-cargo-wagon", "steel-plate", 99999)
            rm.RemoveIngredient("space-fluid-wagon", "steel-plate", 99999)
        end
    end
end

if mods["deadlock-beltboxes-loaders"] then
    rm.ReplaceIngredientProportional("transport-belt-beltbox", "electronic-circuit", "electric-motor")
    if misc.difficulty == 3 or not mods["BrimStuffMk2"] then
        rm.AddIngredient("fast-transport-belt-loader", "electric-motor", 5)
    else
        rm.AddIngredient("express-transport-belt-loader", "electric-motor", 10)
    end

    if misc.difficulty == 1 then
        rm.ReplaceIngredientProportional("fast-transport-belt-beltbox", "iron-gear-wheel", "electric-motor")
    else
        if mods["space-age"] then
            if rm.GetIngredientCount("turbo-transport-belt-beltbox", "electric-engine-unit") == 0 then
                rm.AddIngredient("turbo-transport-belt-beltbox", "electric-engine-unit", 5)
            end
        else
            if rm.GetIngredientCount("express-transport-belt-beltbox", "electric-engine-unit") == 0 then
                rm.AddIngredient("express-transport-belt-beltbox", "electric-engine-unit", 2)
            end
        end

        rm.ReplaceIngredientProportional("fast-transport-belt-beltbox", "advanced-circuit", "motorized-arm")

        if misc.difficulty == 3 and not mods["BrassTacksMk2"] then
            rm.AddIngredient("turbo-transport-belt-beltbox", "grabber")
        end
    end

end


if mods["scrap-industry"] then
    if mods["space-age"] then
        tm.AddUnlock("foundry", "molten-nickel-from-scrap")
        tm.AddUnlock("foundry", "invar-liquation")
        if data.raw.item["nitinol-scrap"] then
            tm.AddUnlock("space-nitinol-processing", "nitinol-plate-from-scrap-in-space")
        end
    end
    if data.raw.item["mech-scrap"] then
        ScrapIndustry.items["electric-motor"] = {scrap="motor-scrap", scale=ScrapIndustry.CHEAP, failrate=0.02}
        ScrapIndustry.items["electric-engine-unit"] = {scrap={"motor-scrap", "mech-scrap"}, scale=ScrapIndustry.RARE, failrate=0.02}
        ScrapIndustry.items["high-pressure-valve"] = {scrap={"mech-scrap", "invar-scrap"}, scale=ScrapIndustry.COMMON, failrate=0.02}
        ScrapIndustry.items["fluid-regulator"] = {scrap={"mech-scrap", "motor-scrap", "circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.02}
        ScrapIndustry.items["motorized-arm"] = {scrap={"mech-scrap", "motor-scrap", "circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.03}
        ScrapIndustry.items["grabber"] = {scrap={"mech-scrap", "motor-scrap"}, scale=ScrapIndustry.EPIC, failrate=0.05}
        ScrapIndustry.items["non-reversible-tremie-pipe"] = {scrap={"mech-scrap", "invar-scrap", "motor-scrap", "circuit-scrap"}, scale=ScrapIndustry.EPIC, failrate=0.05}
        ScrapIndustry.items["self-regulating-valve"] = {scrap={"mech-scrap", "invar-scrap", "nitinol-scrap"}, scale=ScrapIndustry.EXPENSIVE, failrate=0.05}
        ScrapIndustry.items["gimbaled-thruster"] = {scrap={"mech-scrap", "invar-scrap", "motor-scrap"}, scale=ScrapIndustry.EXPENSIVE, failrate=0.04}

        if data.raw.item["plastic-bits"] then
            ScrapIndustry.items["cooling-fan"] = {scrap={"motor-scrap", "plastic-bits"}, scale=ScrapIndustry.UNCOMMON, failrate=-0.01}
        else
            ScrapIndustry.items["cooling-fan"] = {scrap="motor-scrap", scale=ScrapIndustry.CHEAP, failrate=-0.01}
        end

        rm.ReplaceIngredientProportional("electric-engine-unit-from-scrap", "circuit-scrap", "motor-scrap", 5)
    else
        tm.AddUnlock("electronics", "electric-motor-from-scrap")

        ScrapIndustry.items["electric-motor"] = {scrap={"nickel-scrap", "circuit-scrap"}, scale=ScrapIndustry.COMMON, failrate=0.02}
        ScrapIndustry.items["electric-engine-unit"] = {scrap={"circuit-scrap", "steel-scrap", "nickel-scrap"}, scale=ScrapIndustry.RARE, failrate=0.02}
        ScrapIndustry.items["high-pressure-valve"] = {scrap={mods["BrassTacksMk2"] and "brass-scrap" or "iron-scrap", "invar-scrap"}, scale=ScrapIndustry.COMMON, failrate=0.02}
        ScrapIndustry.items["fluid-regulator"] = {scrap={mods["BrassTacksMk2"] and "brass-scrap" or "iron-scrap", "invar-scrap", "circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.02}
        ScrapIndustry.items["motorized-arm"] = {scrap={"nickel-scrap", "circuit-scrap", "iron-scrap"}, scale=ScrapIndustry.RARE, failrate=0.03}
        ScrapIndustry.items["grabber"] = {scrap={"nickel-scrap", "circuit-scrap", mods["BrassTacksMk2"] and "brass-scrap" or "steel-scrap"}, scale=ScrapIndustry.EPIC, failrate=0.05}
        ScrapIndustry.items["non-reversible-tremie-pipe"] = {scrap={mods["BrassTacksMk2"] and "brass-scrap" or "iron-scrap", "invar-scrap", "circuit-scrap"}, scale=ScrapIndustry.EPIC, failrate=0.05}
        ScrapIndustry.items["self-regulating-valve"] = {scrap={mods["BrassTacksMk2"] and "brass-scrap" or "iron-scrap", "invar-scrap", "nitinol-scrap"}, scale=ScrapIndustry.EXPENSIVE, failrate=0.05}
        ScrapIndustry.items["gimbaled-thruster"] = {scrap={mods["BrassTacksMk2"] and "brass-scrap" or "iron-scrap", "invar-scrap", "circuit-scrap"}, scale=ScrapIndustry.EXPENSIVE, failrate=0.04}

        if data.raw.item["plastic-bits"] then
            ScrapIndustry.items["cooling-fan"] = {scrap={"nickel-scrap", "plastic-bits"}, scale=ScrapIndustry.UNCOMMON, failrate=-0.01}
        else
            ScrapIndustry.items["cooling-fan"] = {scrap={"circuit-scrap", "nickel-scrap"}, scale=ScrapIndustry.CHEAP, failrate=-0.01}
        end
    end

    if data.raw.item["nitinol-plate"] then
        table.insert(ScrapIndustry.items["non-reversible-tremie-pipe"].scrap, "nitinol-scrap")
        table.insert(ScrapIndustry.items["gimbaled-thruster"].scrap, "nitinol-scrap")
        if mods["BrassTacks"] then
            table.insert(ScrapIndustry.items["complex-joint"].scrap, "nitinol-scrap")
        end
    end

    if mods["BrassTacks"] then
        table.insert(ScrapIndustry.items["hardened-hull"].scrap, "invar-scrap")
    end

    ScrapIndustry.recipes["high-pressure-valve"] = {fake_ingredients = {{type="item", name="iron-gear-wheel", amount=2}, {type="item", name="invar-plate", amount=1}}}

    if data.raw.item["cooling-fan"] then
        rm.AddIngredient("processing-unit-from-scrap", "cooling-fan", 1)
    end

    ScrapIndustry.recipes["invar-precursor"] = {ignore=true}
    ScrapIndustry.recipes["nitinol-precursor"] = {ignore=true}
    ScrapIndustry.recipes["nitinol-plate"] = {ignore=true}
    ScrapIndustry.recipes["nitinol-plate-in-space"] = {ignore=true}
    ScrapIndustry.products["nitinol-scrap"] = {priority=3}

    ScrapIndustry.items["nickel-plate"] = {scrap="nickel-scrap", scale=ScrapIndustry.COMMON, failrate=0.02, recycle=2}
    ScrapIndustry.items["invar-plate"] = {scrap="invar-scrap", scale=ScrapIndustry.UNCOMMON, failrate=0.01, recycle=4}
    ScrapIndustry.items["nitinol-plate"] = {scrap="nitinol-scrap", scale=ScrapIndustry.UNCOMMON, recycle=2}
    ScrapIndustry.items["ambifacient-lunar-waneshaft"] = {scrap={"invar-scrap", "steel-scrap"}, scale=ScrapIndustry.UNCOMMON, failrate=0.03}
    ScrapIndustry.items["electromagnetic-coil"] = {scrap="nickel-scrap", scale=ScrapIndustry.COMMON, failrate=0.02}

    ScrapIndustry.items["skeletal-bioculture"] = {scrap={"stem-cells", "calcite"}, scale=ScrapIndustry.FLAVOR, failrate=0.01}
    ScrapIndustry.items["vascular-bioculture"] = {scrap="stem-cells", scale=ScrapIndustry.FLAVOR, failrate=0.01}

    ScrapIndustry.items["stem-cells"] = {scrap="jelly", scale=ScrapIndustry.FLAVOR, failrate=0.01}
end