local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["se-space-trains"] then
    if misc.difficulty > 1 then
        rm.AddIngredient("space-locomotive", "electromagnetic-coil", 100)
        rm.AddIngredient("space-cargo-wagon", "electromagnetic-coil", 100)
        rm.AddIngredient("space-fluid-wagon", "electromagnetic-coil", 100)
    end
end