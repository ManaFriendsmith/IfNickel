local misc = require("__pf-functions__/misc")
local tm = require("__pf-functions__/technology-manipulation")

data:extend({
    {
        type = "technology",
        name = "invar-processing",
        icon = "__IfNickelMk2__/graphics/technology/invar-processing.png",
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
        icon = "__IfNickelMk2__/graphics/technology/high-pressure-valve.png",
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

if misc.difficulty > 1 and not mods["BrassTacksMk2"] then
    data:extend({
        {
            type = "technology",
            name = "mechanical-engineering",
            icon = "__IfNickelMk2__/graphics/technology/mechanical-engineering.png",
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
            icon = "__IfNickelMk2__/graphics/technology/tissue-cultivation.png",
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
        },
        {
            type = "technology",
            name = "bioculture-productivity",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/technology/tissue-cultivation.png",
                    icon_size = 256
                },
                {
                    icon = "__core__/graphics/icons/technology/constants/constant-mining-productivity.png",
                    icon_size = 128,
                    scale = 0.5,
                    shift = {50, 50}
                }
                },
            effects =
            {
                {
                type = "change-recipe-productivity",
                recipe = "skeletal-bioculture",
                change = 0.1
                },
                {
                type = "change-recipe-productivity",
                recipe = "musculoskeletal-bioculture",
                change = 0.1
                },
                {
                type = "change-recipe-productivity",
                recipe = "vascular-bioculture",
                change = 0.1
                },
                {
                type = "change-recipe-productivity",
                recipe = "cardiac-bioculture",
                change = 0.1
                }
            },
            prerequisites = {"tissue-cultivation", "production-science-pack", "cryogenic-science-pack"},
            unit =
            {
                count_formula = "1.5^L*2000",
                ingredients =
                {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1}
                },
                time = 60
            },
            max_level = 30,
            upgrade = true
        },
        {
            type = "technology",
            name = "gimbaled-rocket-engine-productivity",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/technology/gimbaled-rocket-engine.png",
                    icon_size = 256
                },
                {
                    icon = "__core__/graphics/icons/technology/constants/constant-mining-productivity.png",
                    icon_size = 128,
                    scale = 0.5,
                    shift = {50, 50}
                }
                },
            effects =
            {
                {
                type = "change-recipe-productivity",
                recipe = "gimbaled-rocket-engine",
                change = 0.1
                }
            },
            prerequisites = {mods["maraxsis"] and "hydraulic-science-pack" or "cryogenic-science-pack"},
            unit =
            {
                count_formula = "1.5^L*1000",
                ingredients =
                {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {mods["maraxsis"] and "hydraulic-science-pack" or "cryogenic-science-pack", 1}
                },
                time = 60
            },
            max_level = "infinite",
            upgrade = true
        }
    })

    tm.AddSciencePacks("gimbaled-rocket-engine-productivity", tm.post_aquilo_sciences)
    tm.AddSciencePacks("bioculture-productivity", tm.post_aquilo_sciences)
    if mods["maraxsis"] then
        tm.RemovePrerequisite("gimbaled-rocket-engine-productivity", "cryogenic-science-pack")
        tm.RemoveSciencePack("gimbaled-rocket-engine-productivity", "cryogenic-science-pack")
    end

    if mods["BrassTacksMk2"] then
        tm.AddUnlock("tissue-cultivation", "vestibular-bioculture")
        tm.AddUnlock("bioculture-productivity", {type="change-recipe-productivity", recipe="vestibular-bioculture", change=0.1})
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
            icon = "__IfNickelMk2__/graphics/technology/nitinol-processing.png",
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
                    icon = "__IfNickelMk2__/graphics/technology/nitinol-processing.png",
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