local misc = require("__pf-functions__/misc")

if mods["maraxsis"] and mods["planet-muluna"] then
    data.raw["autoplace-control"]["oxide-asteroid-chunk"].order = "e-02"
end

if mods["planet-muluna"] and misc.difficulty == 3 then
    rm.AddIngredient("rocket-part-muluna", "gimbaled-rocket-engine")
end