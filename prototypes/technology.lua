local misc = require("__pf-functions__/misc")
local tm = require("__pf-functions__/technology-manipulation")

data:extend({
    {
        type = "technology",
        name = "invar-processing",
        icon = "__IfNickel__/graphics/technology/invar-processing.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "invar-precursor"
            },
            {
                type = "unlock-recipe",
                recipe = "invar-plate"
            }
        },
        prerequisites = {"steel-processing", "logistic-science-pack"},
        unit = {
            count = 50,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            }
        }
    },
    {
        type = "technology",
        name = "high-pressure-valve",
        icon = "__IfNickel__/graphics/technology/high-pressure-valve.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "high-pressure-valve"
            },
            misc.difficulty > 1 and {
                type = "unlock-recipe",
                recipe = "fluid-regulator"
            } or nil
        },
        prerequisites = {"invar-processing"},
        unit = {
            count = 50,
            time = 15,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1}
            }
        }
    }
})

if misc.difficulty > 1 and not mods["BrassTacks"] then
    data:extend({
        {
            type = "technology",
            name = "mechanical-engineering",
            icon = "__IfNickel__/graphics/technology/mechanical-engineering.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "motorized-arm"
                }
            },
            prerequisites = {"logistic-science-pack"},
            unit = {
                count = 50,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                }
            }
        }
    })
end

if misc.difficulty > 1 and mods["space-age"] then
    data:extend({
        {
            type = "technology",
            name = "tissue-cultivation",
            icon = "__IfNickel__/graphics/technology/tissue-cultivation.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "stem-cells"
                },
                {
                    type = "unlock-recipe",
                    recipe = "skeletal-bioculture"
                },
                {
                    type = "unlock-recipe",
                    recipe = "musculoskeletal-bioculture"
                },
                {
                    type = "unlock-recipe",
                    recipe = "vascular-bioculture"
                },
                {
                    type = "unlock-recipe",
                    recipe = "cardiac-bioculture"
                }
            },
            prerequisites = {"agricultural-science-pack"},
            unit = {
                count = 1000,
                time = 30,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"agricultural-science-pack", 1}
                }
            }
        }
    })

    if mods["BrassTacks"] then
        tm.AddUnlock("tissue-cultivation", "vestibular-bioculture")
    end

    if misc.difficulty == 3 then
        tm.AddUnlock("tissue-cultivation", "non-reversible-tremie-pipe")
        tm.AddUnlock("tissue-cultivation", "bacterium-extraction-from-sludge")
        tm.AddUnlock("tissue-cultivation", "mutagenic-sludge-quelling")
    end
end

if misc.difficulty == 3 and mods["space-age"] and mods["bztitanium"] then
    data:extend({
        {
            type = "technology",
            name = "nitinol-processing",
            icon = "__IfNickel__/graphics/technology/nitinol-processing.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "nitinol-precursor"
                },
                {
                    type = "unlock-recipe",
                    recipe = "nitinol-plate"
                },
                {
                    type = "unlock-recipe",
                    recipe = "self-regulating-valve"
                }
            },
            prerequisites = {"advanced-material-processing-2", "titanium-processing"},
            unit = {
                count = 50,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "space-nitinol-processing",
            icons ={
                {
                    icon = "__IfNickel__/graphics/technology/nitinol-processing.png",
                    icon_size = 256,        
                },
                {
                    icon = "__space-age__/graphics/technology/space-platform.png",
                    icon_size = 256,
                    icon_mipmaps = 4,
                    scale = 0.25,
                    shift = {64, 64}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "nitinol-plate-in-space"
                }
            },
            prerequisites = {"metallurgic-science-pack"},
            unit = {
                count = 500,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1}
                }
            }
        }
    })
end