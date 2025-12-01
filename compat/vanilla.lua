local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

--INTERMEDIATE PRODUCTS

tm.AddUnlock("electronics", "electric-motor", "-electronic-circuit")
if not data.raw.recipe["iron-stick"].enabled then
    tm.AddUnlock("electronics", "iron-stick", "-electric-motor")
    tm.RemoveUnlock("railway", "iron-stick")
    tm.RemoveUnlock("circuit-network", "iron-stick")
    tm.RemoveUnlock("electric-energy-distribution-1", "iron-stick")
    tm.RemoveUnlock("concrete", "iron-stick")
end

tm.AddPrerequisite("engine", "high-pressure-valve")
rm.ReplaceIngredientProportional("engine-unit", "pipe", "high-pressure-valve", 0.5)

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("engine-unit", "steel-plate", "ambifacient-lunar-waneshaft")
    --what is the engine block made of? i don't care. nitrogen. go away

    tm.AddUnlock("engine", "ambifacient-lunar-waneshaft", "-engine-unit")
    if not mods["BrassTacks"] then
        rm.ReplaceIngredientProportional("motorized-arm", "iron-stick", "ambifacient-lunar-waneshaft", 0.16)
        tm.AddUnlock("mechanical-engineering", "ambifacient-lunar-waneshaft")
    end
end

if misc.difficulty > 1 and mods["BrassTacks"] then
    tm.AddUnlock("mechanical-engineering", "motorized-arm")
    rm.ReplaceIngredientProportional("gyro", "iron-gear-wheel", "electric-motor", 0.5)
    if misc.difficulty == 3 then
        tm.AddUnlock("electric-engine", "grabber")
    end
elseif difficulty == 3 then
    data.raw.technology["electric-engine"].icon = "__IfNickel__/graphics/technology/mechanical-engineering-2.png"
    data.raw.technology["electric-engine"].localised_name = {"technology-name.mechanical-engineering-2"}
    data.raw.technology["electric-engine"].localised_description = {"technology-description.mechanical-engineering-2"}
    data.raw.technology["electric-engine"].unit.count = 100
    tm.AddUnlock("electric-engine", "grabber")
end

if mods["ThemTharHills"] and misc.difficulty == 2 then
    if mods["space-age"] then
        rm.ReplaceIngredientProportional("stepper-motor", "iron-gear-wheel", "nickel-plate", 2)
    else
        rm.AddIngredient("stepper-motor", "nickel-plate", 2)
    end
end

if misc.difficulty > 1 then
    --this is a little mean, but in space age you can reduce the nickel demand to near nothing with EM plants making motors.
    rm.AddIngredient("electric-engine-unit", "electromagnetic-coil", mods["space-age"] and 10 or 6)
    if misc.difficulty == 3 then
        tm.AddUnlock("electronics", "electromagnetic-coil", "-electric-motor")
    else
        if mods["ThemTharHills"] then
            tm.AddUnlock("gold-electronics", "electromagnetic-coil", "advanced-circuit")
        else
            tm.AddUnlock("advanced-circuit", "electromagnetic-coil", "advanced-circuit")
        end
    end
else
    rm.AddIngredient("electric-engine-unit", "nickel-plate", 6)
end

if rm.GetIngredientCount("battery", "lead-plate") == 0 then
    rm.AddIngredient("battery", "nickel-plate", 1)
    rm.RemoveIngredient("battery", "iron-plate")
end

if data.raw.item["cooling-fan"] then
    tm.AddUnlock("plastics", "cooling-fan", "plastic-bar")
    rm.AddIngredient("processing-unit", "cooling-fan", 1)
end

if misc.difficulty > 1 then
    --in LL you will already have to make so many valves for rocket engines
    if not mods["LunarLandings"] then
        rm.AddIngredient("production-science-pack", "fluid-regulator", 6)
        if mods["maraxsis"] then
            rm.AddIngredient("maraxsis-deepsea-research-production-science-pack", "fluid-regulator", 6)
        end
    end

    if mods["BrassTacks"] then
        rm.ReplaceIngredientProportional("hardened-hull", "iron-plate", "invar-plate")
        if misc.difficulty == 2 then
            tm.AddPrerequisite("hardened-hull", "invar-processing")
        end            
    end

    if mods["space-age"] and mods["LunarLandings"] then
        tm.AddUnlock("ll-luna-rocket-silo", "gimbaled-rocket-engine", "-rocket-part")
        tm.AddUnlock("ll-luna-rocket-silo", "pack-gimbaled-rocket-engine", "-rocket-part")
        tm.AddUnlock("ll-luna-rocket-silo", "unpack-gimbaled-rocket-engine", "-rocket-part")
    else
        tm.AddUnlock("rocket-silo", "gimbaled-rocket-engine", "-rocket-part")
        if mods["LunarLandings"] then
            tm.AddUnlock("rocket-silo", "gimbaled-rocket-engine", "-rocket-part")
            tm.AddUnlock("rocket-silo", "gimbaled-rocket-engine", "-rocket-part")
        end
    end

    if mods["space-age"] then
        rm.AddIngredient("rocket-part", "gimbaled-rocket-engine", mods["planet-muluna"] and 2 or 1)
        rm.AddIngredient("maraxsis-rocket-part", "gimbaled-rocket-engine", mods["planet-muluna"] and 2 or 1)
    else
        rm.AddIngredient("rocket-part", "gimbaled-rocket-engine", 10)
        rm.AddIngredient("satellite", "gimbaled-rocket-engine", 50)
    end

    if data.raw.item["nitinol-plate"] then
        rm.ReplaceIngredientProportional("gimbaled-rocket-engine", "high-pressure-valve", "self-regulating-valve", 0.5)
        tm.AddPrerequisite("rocket-silo", "nitinol-processing")
    end
end

if data.raw.item["differential-girdlespring"] and data.raw.item["nitinol-plate"] then
    rm.ReplaceIngredientProportional("differential-girdlespring", "rubber", "nitinol-plate", 0.125)
    rm.AddIngredient("differential-girdlespring", "spring", 4)
end

if mods["space-age"] then
    if misc.difficulty == 3 then
        rm.AddIngredient("low-density-structure", "invar-plate", 2)
        rm.AddIngredient("casting-low-density-structure", "invar-plate", 2)
    else
        rm.ReplaceIngredientProportional("low-density-structure", "steel-plate", "invar-plate", 2)
        rm.ReplaceIngredientProportional("casting-low-density-structure", "molten-iron", "invar-plate", 1/40)
    end
else
    if misc.difficulty == 1 then
        rm.ReplaceIngredientProportional("low-density-structure", "steel-plate", "invar-plate", 2)
    else
        rm.AddIngredient("low-density-structure", "invar-plate", 2)
        rm.AddIngredient("casting-low-density-structure", "invar-plate", 2)
    end
end

if mods["ThemTharHills"] and misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("transceiver", "iron-stick", "electromagnetic-coil")
    if misc.difficulty == 2 then
        rm.ReplaceIngredientProportional("stepper-motor", "copper-plate", "electromagnetic-coil", mods["space-age"] and 1 or 2)
    else
        rm.ReplaceIngredientProportional("semiboloid-stator", "copper-plate", "electromagnetic-coil", 2)
    end
end

if mods["ThemTharHills"] then
    rm.AddProduct("trace-metals-from-copper", {type="item", name="nickel-ore", amount=1, probability=0.1})
end

--LOGISTICS

--BELTS

if misc.difficulty == 3 or not mods["BrimStuff"] then
    --greater complexity earlier adds more difficulty than greater cost later
    rm.AddIngredient("fast-transport-belt", "electric-motor", 1)
    rm.AddIngredient("fast-underground-belt", "electric-motor", 8)
    rm.AddIngredient("fast-splitter", "electric-motor", 2)
else
    rm.AddIngredient("express-transport-belt", "electric-motor", 2)
    rm.AddIngredient("express-underground-belt", "electric-motor", 16)
    rm.AddIngredient("express-splitter", "electric-motor", 4)
end

if misc.difficulty > 1 then
    rm.AddIngredient("fast-splitter", "motorized-arm", misc.difficulty - 1)
end

--INSERTERS

rm.AddIngredient("inserter", "electric-motor", 1)
rm.ReplaceIngredientProportional("fast-inserter", "electronic-circuit", "electric-motor", 1, 1)
if misc.difficulty > 1 then
    if misc.difficulty == 3 and not data.raw.item["stack-inserter"] then
        rm.AddIngredient("bulk-inserter", "grabber", 1)
        tm.AddPrerequisite("bulk-inserter", "electric-engine")
        tm.AddSciencePack("bulk-inserter", "chemical-science-pack")
        tm.AddSciencePack("inserter-capacity-bonus-1", "chemical-science-pack")
        tm.AddSciencePack("inserter-capacity-bonus-2", "chemical-science-pack")
    else
        if misc.difficulty == 3 then
            rm.AddIngredient("stack-inserter", "grabber", 1)
            rm.RemoveIngredient("stack-inserter", "complex-joint", 1)
        end
        rm.AddIngredient("bulk-inserter", "motorized-arm", 5)
    end
    if rm.GetIngredientCount("bulk-inserter", "iron-gear-wheel") <= 5 then --can be replaced by titanium
        rm.RemoveIngredient("bulk-inserter", "electronic-circuit", 10)
    else
        rm.RemoveIngredient("bulk-inserter", "electronic-circuit", 5)
        rm.RemoveIngredient("bulk-inserter", "iron-gear-wheel", 5)
    end
else
    rm.AddIngredient("bulk-inserter", "electric-motor", 5)
end

--PIPES

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("pump", "pipe", "fluid-regulator", 1)
else
    rm.ReplaceIngredientProportional("pump", "pipe", "high-pressure-valve", 1)
end
rm.AddIngredient("pump", "electric-motor", 1)

--RAILWAY

rm.AddIngredient("fluid-wagon", "high-pressure-valve", 6)

if misc.difficulty == 3 then
    --1 waneshaft per axle
    rm.AddIngredient("locomotive", "ambifacient-lunar-waneshaft", 4)
    rm.AddIngredient("cargo-wagon", "ambifacient-lunar-waneshaft", 4)
    rm.AddIngredient("fluid-wagon", "ambifacient-lunar-waneshaft", 4)

    --why does artillery take waneshafts? lmao someone was asleep in history class
    rm.AddIngredient("artillery-wagon", "ambifacient-lunar-waneshaft", 24)
    rm.AddIngredient("artillery-turret", "ambifacient-lunar-waneshaft", 20)

    --personal vehicles can get away with being more expensive per axle because they are not really mall items you need to mass produce
    --this doesn't strictly belong in the railway section but whatever
    --spidertrons can be stupid expensive because they are spidertrons
    rm.AddIngredient("car", "ambifacient-lunar-waneshaft", 4)
    rm.AddIngredient("tank", "ambifacient-lunar-waneshaft", 20)
    rm.AddIngredient("spidertron", "ambifacient-lunar-waneshaft", 64)
end

--CIRCUIT NETWORK

if misc.difficulty == 3 then
    if data.raw.item["tinned-cable"] then
        if mods["BrassTacks"] then
            rm.ReplaceIngredientProportional("programmable-speaker", "galvanized-panel", "electromagnetic-coil", 1)
        else
            rm.ReplaceIngredientProportional("programmable-speaker", "iron-plate", "electromagnetic-coil", 1)
        end
    else
        rm.ReplaceIngredientProportional("programmable-speaker", "copper-cable", "electromagnetic-coil", 0.6)
    end
end

--ROBOTICS

if not (mods["ThemTharHills"] and misc.difficulty > 1) then
    rm.ReplaceIngredientProportional("roboport", "iron-gear-wheel", "electric-motor", 1, 15)

    rm.AddIngredient("passive-provider-chest", "electric-motor", 1)
    rm.AddIngredient("storage-chest", "electric-motor", 1)
    rm.AddIngredient("active-provider-chest", "electric-motor", 1)
    rm.AddIngredient("buffer-chest", "electric-motor", 1)
    rm.AddIngredient("requester-chest", "electric-motor", 1)    

    if misc.difficulty > 1 then
        rm.AddIngredient("roboport", "electromagnetic-coil", 25)
    end
end

if misc.difficulty == 3 then
    rm.AddIngredient("logistic-robot", "grabber", 5) --lmao. get crafting, bot players.
    rm.AddIngredient("construction-robot", "grabber", 1)
else
    rm.AddIngredient("logistic-robot", "motorized-arm", 1)
    rm.AddIngredient("construction-robot", "motorized-arm", 1)
end

if data.raw.item["cooling-fan"] then
    rm.AddIngredient("roboport", "cooling-fan", 10)
end

--ELECTRIC POLES

if data.raw.item["cooling-fan"] then
    rm.AddIngredient("substation", "cooling-fan", 5)
end

--MODULES

if misc.difficulty > 1 and not mods["ThemTharHills"] then
    rm.ReplaceIngredientProportional("beacon", "electronic-circuit", "electromagnetic-coil", 1.5)
end

if data.raw.item["cooling-fan"] then
    local fan_count = (rm.GetIngredientCount("speed-module", "silicon-wafer") > 0 and 2 or 1)
    rm.AddIngredient("efficiency-module", "cooling-fan", fan_count)
    rm.AddIngredient("speed-module", "cooling-fan", fan_count)
    rm.AddIngredient("productivity-module", "cooling-fan", fan_count)
    rm.AddIngredient("quality-module", "cooling-fan", fan_count)
end

--PRODUCTION
--GENERATORS
if misc.difficulty == 3 then
    rm.AddIngredient("steam-engine", "electromagnetic-coil", 10)
    rm.AddIngredient("steam-turbine", "electromagnetic-coil", 30)
else
    rm.AddIngredient("steam-engine", "electric-motor", 2)
    rm.AddIngredient("steam-turbine", "electric-motor", 10)
end

if data.raw.item["nitinol-plate"] then
    tm.AddPrerequisite("nuclear-power", "nitinol-processing")
    rm.AddIngredient("heat-exchanger", "self-regulating-valve", 10)
    rm.AddIngredient("steam-turbine", "self-regulating-valve", 10)
else
    rm.AddIngredient("heat-exchanger", "high-pressure-valve", 10)
    rm.AddIngredient("steam-turbine", "high-pressure-valve", 10)
end
rm.ReplaceIngredientProportional("heat-pipe", "steel-plate", "invar-plate")
if not data.raw.item["hardened-hull"] then
    rm.ReplaceIngredientProportional("heat-exchanger", "steel-plate", "invar-plate")
    rm.ReplaceIngredientProportional("nuclear-reactor", "steel-plate", "invar-plate", 1, 250)
end

--CRAFTING MACHINES
rm.AddIngredient("assembling-machine-1", "electric-motor", 3)
rm.AddIngredient("chemical-plant", "electric-motor", 5)
tm.AddPrerequisite("automation-2", "high-pressure-valve")

if misc.difficulty == 1 then
    rm.AddIngredient("assembling-machine-2", "electric-motor", 3)
    rm.ReplaceIngredientProportional("chemical-plant", "iron-gear-wheel", "high-pressure-valve")
    rm.ReplaceIngredientProportional("oil-refinery", "iron-gear-wheel", "high-pressure-valve")
    rm.AddIngredient("assembling-machine-2", "high-pressure-valve", 1)
else
    rm.ReplaceIngredientProportional("assembling-machine-2", "electronic-circuit", "motorized-arm")
    rm.ReplaceIngredientProportional("chemical-plant", "iron-gear-wheel", "fluid-regulator")
    rm.ReplaceIngredientProportional("oil-refinery", "iron-gear-wheel", "fluid-regulator")
    rm.AddIngredient("assembling-machine-2", "fluid-regulator", 1)

    if data.raw.item["cooling-fan"] then
        rm.AddIngredient("laser-mill", "cooling-fan", 10)
    end

    rm.RemoveIngredient("chemical-plant", "electronic-circuit", 5)
    rm.RemoveIngredient("oil-refinery", "electronic-circuit", 10)
end

if rm.GetIngredientCount("assembling-machine-3", "electric-engine-unit") == 0 then
    rm.AddIngredient("assembling-machine-3", "electric-engine-unit", 2)
end

if rm.GetIngredientCount("centrifuge", "electric-engine-unit") == 0 then
    tm.AddPrerequisite("uranium-mining", "electric-engine")
    rm.AddIngredient("centrifuge", "electric-engine-unit", 10)
end

if misc.difficulty > 1 and not mods["BrassTacks"] then
    rm.AddIngredient("assembling-machine-3", "motorized-arm", 6)
end

tm.AddPrerequisite("advanced-material-processing", "invar-processing")
rm.AddIngredient("steel-furnace", "invar-plate", 1)
if not data.raw.item["hardened-hull"] then
    rm.ReplaceIngredientProportional("electric-furnace", "steel-plate", "invar-plate", 1, 5)
    rm.ReplaceIngredientProportional("oil-refinery", "steel-plate", "invar-plate", 1, 5)
end

if mods["quality"] then
    if misc.difficulty > 1 then
        rm.AddIngredient("recycler", "electromagnetic-coil", mods["space-age"] and 50 or 20)
        rm.ReplaceIngredientProportional("recycler", "iron-gear-wheel", "motorized-arm", 0.5, 20)
    else
        rm.AddIngredient("recycler", "electric-motor", 10)
    end
end

if mods["BrassTacks"] and data.raw.item["nitinol-plate"] then
    rm.AddIngredient("advanced-electroplating-machine", "self-regulating-valve", 5)
end

--MINING
rm.AddIngredient("electric-mining-drill", "nickel-plate", 5)
rm.AddIngredient("electric-mining-drill", "electric-motor", 3)
if mods["BrassTacks"] and misc.difficulty > 1 then
    rm.RemoveIngredient("electric-mining-drill", "electronic-circuit", 99999)
end
rm.AddIngredient("pumpjack", "electric-motor", 5)

if misc.difficulty == 1 then
    rm.ReplaceIngredientProportional("pumpjack", "iron-gear-wheel", "high-pressure-valve", 1, 5)
else
    rm.ReplaceIngredientProportional("pumpjack", "iron-gear-wheel", "fluid-regulator", 1, 5)
    rm.RemoveIngredient("pumpjack", "electronic-circuit", 5)
end

--MILITARY
--ARMOR

rm.AddIngredient("heavy-armor", "nickel-plate", 50)
rm.AddIngredient("modular-armor", "invar-plate", 20)
rm.AddIngredient("power-armor", "invar-plate", 20)

--CAPSULES

if misc.difficulty > 1 then
    rm.AddIngredient("destroyer-capsule", "electromagnetic-coil", 5)
end

--AMMO
if rm.GetIngredientCount("flamethrower-ammo", "steel-plate") >= 5 then
    rm.RemoveIngredient("flamethrower-ammo", "steel-plate", 4) --i still hold this stuff is too expensive.
end
rm.ReplaceIngredientProportional("flamethrower-ammo", "steel-plate", "invar-plate")
rm.ReplaceIngredientProportional("piercing-rounds-magazine", "steel-plate", "invar-plate")

if misc.difficulty > 1 and mods["space-age"] then
    rm.AddIngredient("atomic-bomb", "gimbaled-rocket-engine", 10)
end

--EQUIPMENT

if misc.difficulty > 1 then
    rm.AddIngredient("energy-shield-equipment", "electromagnetic-coil", 20)
    rm.AddIngredient("discharge-defense-equipment", "electromagnetic-coil", 50)
    rm.AddIngredient("exoskeleton-equipment", "motorized-arm", 10)
    if mods["space-age"] then
        rm.AddIngredient("personal-roboport-mk2-equipment", "electromagnetic-coil", 50)
    else
        rm.AddIngredient("personal-roboport-equipment", "electromagnetic-coil", 25)
    end
    rm.AddIngredient("belt-immunity-equipment", "electromagnetic-coil", 10)

    if data.raw.item["nitinol-plate"] then
        tm.AddPrerequisite("exoskeleton-equipment", "nitinol-processing")
        rm.ReplaceIngredientProportional("exoskeleton-equipment", "titanium-plate", "nitinol-plate")
    end
end

--TURRETS

if misc.difficulty == 1 then
    rm.ReplaceIngredientProportional("gate", "electronic-circuit", "electric-motor")
    rm.AddIngredient("laser-turret", "electric-motor", 5)
else
    rm.ReplaceIngredientProportional("gate", "electronic-circuit", "motorized-arm", 0.5)
    tm.AddPrerequisite("gate", "mechanical-engineering")

    rm.ReplaceIngredientProportional("laser-turret", "electronic-circuit", "motorized-arm", 1, 5)
end

rm.AddIngredient("radar", "electric-motor", 1)
if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("radar", "electronic-circuit", "electromagnetic-coil", 2)
end

if mods["bzlead"] then
    rm.ReplaceIngredientProportional("gun-turret", "iron-plate", "nickel-plate", 1, 6)
else
    rm.ReplaceIngredientProportional("gun-turret", "iron-plate", "nickel-plate", 1, 10)
end

rm.ReplaceIngredientProportional("flamethrower-turret", "steel-plate", "invar-plate", 1, 10)
