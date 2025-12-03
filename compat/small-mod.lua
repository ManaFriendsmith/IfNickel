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