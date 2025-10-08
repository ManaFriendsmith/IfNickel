local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("aop-scrubber", "iron-gear-wheel", "cooling-fan", 0.4)
else
    rm.ReplaceIngredientProportional("aop-scrubber", "iron-gear-wheel", "electric-motor", 0.4)
end

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("aop-arc-furnace", "copper-cable", "electromagnetic-coil", 0.5, 50)
    rm.ReplaceIngredientProportional("aop-smeltery", "iron-gear-wheel", "motorized-arm", 0.33)
end

if data.raw.item["self-regulating-valve"] then
    rm.ReplaceIngredientProportional("aop-greenhouse", "iron-gear-wheel", "self-regulating-valve", 0.6)
else
    rm.ReplaceIngredientProportional("aop-greenhouse", "iron-gear-wheel", "high-pressure-valve", 0.6)
end

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("aop-biochemical-facility", "steel-plate", "non-reversible-tremie-pipe", 0.1)
    rm.AddIngredient("aop-mineral-synthesizer", "non-reversible-tremie-pipe", 10)
    rm.ReplaceIngredientProportional("aop-biochemical-facility", "nutrients", "cardiac-bioculture", 0.1, 250)
    rm.ReplaceIngredientProportional("aop-biochemical-facility", "nutrients", "musculoskeletal-bioculture", 0.1, 250)
elseif misc.difficulty == 2 then
    rm.ReplaceIngredientProportional("aop-biochemical-facility", "steel-plate", "fluid-regulator", 0.5)
    rm.AddIngredient("aop-mineral-synthesizer", "fluid-regulator", 25)
    tm.AddPrerequisite("aop-mineral-synthesizer", "tissue-cultivation")
else
    rm.ReplaceIngredientProportional("aop-biochemical-facility", "steel-plate", "high-pressure-valve", 0.5)
    rm.AddIngredient("aop-mineral-synthesizer", "high-pressure-valve", 25)
end

tm.AddUnlock("aop-mineral-synthesis", "ammoniacal-nickel-synthesis")

rm.AddIngredient("aop-lumber-mill", "electric-motor", 20)

rm.AddProduct("aop-nauvitian-crushing", {type="item", name="nickel-ore", amount=1, probability=0.4})
rm.AddProduct("aop-vulcanusian-crushing", {type="item", name="nickel-ore", amount=2, probability=0.5})
rm.AddProduct("aop-fulgoran-crushing", {type="item", name="nickel-ore", amount=1, probability=0.2})
rm.AddProduct("aop-gleban-crushing", {type="item", name="nickel-bacteria", amount=1, probability=0.5})

rm.AddCategory("nickel-bacteria", "biochemistry")