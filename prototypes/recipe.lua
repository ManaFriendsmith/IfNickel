local rm = require("__pf-functions__/recipe-manipulation")
local misc = require("__pf-functions__/misc")

local motor_ingredients = {
    {type="item", name="nickel-plate", amount=2},
    {type="item", name="copper-cable", amount=2},
    {type="item", name="iron-stick", amount=1}
}
if misc.difficulty == 3 then
    motor_ingredients = {
        {type="item", name="electromagnetic-coil", amount=3},
        {type="item", name="iron-gear-wheel", amount=1},
        {type="item", name="iron-stick", amount=1}
    }
end

data:extend({
    {
        type = "recipe",
        name = "nickel-plate",
        category = "smelting",
        ingredients = {
            {type="item", name="nickel-ore", amount=1}
        },
        results = {
            {type="item", name="nickel-plate", amount=1}
        },
        energy_required = 3.2,
        allow_productivity = true,
        enabled = true
    },
    {
        type = "recipe",
        name = "invar-precursor",
        category = "crafting",
        ingredients = {
            {type="item", name="nickel-plate", amount=2},
            {type="item", name="iron-plate", amount=2}
        },
        results = {
            {type="item", name="invar-precursor", amount=1}
        },
        auto_recycle = false,
        energy_required = 0.5,
        enabled = false
    },
    {
        type = "recipe",
        name = "invar-plate",
        category = "smelting",
        ingredients = {
            {type="item", name="invar-precursor", amount=1}
        },
        results = {
            {type="item", name="invar-plate", amount=1}
        },
        energy_required = 6.4,
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "electric-motor",
        category = mods["space-age"] and "electronics" or "crafting",
        ingredients = motor_ingredients,
        results = {
            {type="item", name="electric-motor", amount=1}
        },
        energy_required = misc.difficulty == 3 and 1 or 0.5,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "high-pressure-valve",
        category = "advanced-crafting",
        ingredients = {
            {type="item", name="invar-plate", amount=1},
            {type="item", name="pipe", amount=2},
            {type="item", name="copper-plate", amount=2}
        },
        results = {
            {type="item", name="high-pressure-valve", amount=1}
        },
        energy_required = 3,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    }
})

if mods["space-age"] then
    --data.raw.item["invar-plate"].localised_description = {"recipe-description.hint-nonstandard-recycling"}
    --data.raw.item["nickel-plate"].localised_description = {"recipe-description.hint-nonstandard-recycling"}

    data.raw.recipe["invar-plate"].force_auto_recycle = true

    data:extend({
        {
            type = "recipe",
            name = "invar-separation",
            icon = "__IfNickelMk2__/graphics/icons/invar-separation.png",
            icon_size = 64,
            category = "centrifuging",
            ingredients = {
                {type="item", name="invar-precursor", amount=1}
            },
            results = {
                {type="item", name="iron-ore", amount=1, probability = 0.12},
                {type="item", name="nickel-ore", amount=1, probability = 0.12}
            },
            subgroup = "fulgora-processes",
            auto_recycle = false,
            order = "a[trash]-ac",
            energy_required = 0.25,
            allow_productivity = false,
            allow_quality = false,
            enabled = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "molten-nickel",
            icon = "__pf-sa-compat__/graphics/icons/nickel-ore-melting.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "a[melting]-d",
            category = "metallurgy",
            ingredients = {
                {type="item", name="nickel-ore", amount=50},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-nickel", amount=500, fluidbox_multiplier=10}
            },
            auto_recycle = false,
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "molten-nickel-from-lava",
            icon = "__pf-sa-compat__/graphics/icons/molten-nickel-from-lava.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "a[melting]-a[lava-b]",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="lava", amount=500, fluidbox_multiplier=10},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-nickel", amount=250, fluidbox_multiplier=10},
                {type="item", name="stone", amount=15},
            },
            auto_recycle = false,
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "casting-nickel",
            icon = "__pf-sa-compat__/graphics/icons/casting-nickel.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "b[casting]-bc",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-nickel", amount=20, fluidbox_multiplier=10},
            },
            results = {
                {type="item", name="nickel-plate", amount=2}
            },
            auto_recycle = false,
            energy_required = 3.2,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "casting-invar",
            icon = "__pf-sa-compat__/graphics/icons/casting-invar.png",
            icon_size = 64,
            subgroup = "vulcanus-processes",
            order = "b[casting]-bd",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="molten-iron", amount=12, fluidbox_multiplier=10},
                {type="fluid", name="molten-nickel", amount=12, fluidbox_multiplier=10},
            },
            results = {
                {type="item", name="invar-plate", amount=1}
            },
            auto_recycle = false,
            energy_required = 3.2,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "copper-ore-from-malachite",
            icon = "__IfNickelMk2__/graphics/icons/copper-ore-from-malachite.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "a[melting]-a0",
            category = "metallurgy",
            ingredients = {
                {type="fluid", name="sulfuric-acid", amount=200, fluidbox_multiplier=10},
                {type="item", name="malachite", amount=50},
                {type="item", name="calcite", amount=2},
            },
            results = {
                {type="item", name="copper-ore", amount=35},
                {type="item", name="carbon", amount=10}
            },
            auto_recycle = false,
            energy_required = 20,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "nickel-bacteria",
            icon = "__pf-sa-compat__/graphics/icons/nickel-bacteria.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "agriculture-processes",
            order = "e[bacteria]-a[bacteria]-d",
            category = "organic",
            ingredients = {
                {type="item", name=mods["BrassTacksMk2"] and "iron-bacteria" or "copper-bacteria", amount=3},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="nickel-bacteria", amount=3}
            },
            energy_required = 2,
            auto_recycle = false,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {0, 0, 0.9, 1},
              secondary = {0.4, 0.4, 0.75, 1},
            }
        }
    })

    if mods["Age-of-Production"] then
        data:extend({
            {
                type = "recipe",
                name = "ammoniacal-nickel-synthesis",
                icons = {
                    {
                        icon = "__space-age__/graphics/icons/fluid/ammoniacal-solution.png",
                        icon_size = 64
                    },
                    {
                        icon = "__IfNickelMk2__/graphics/icons/nickel-ore.png",
                        icon_size = 64,
                        scale = 0.25,
                        shift = {0, 8}
                    }
                },
                subgroup = "raw-material",
                order = "n",
                category = "synthesis",
                ingredients = {
                    {type="item", name="carbon", amount=5},
                    {type="fluid", name="ammoniacal-solution", amount=100},
                    {type="fluid", name="petroleum-gas", amount=25},
                },
                results = {
                    {type="item", name="nickel-ore", amount=5}
                },
                auto_recycle = false,
                energy_required = 15,
                enabled = false
            }
        })
    end
end

if tune_up_data then
  if not mods["space-age"] then
    tune_up_data.recipes["nickel-ore"] = {
        category = "purification",
        count = 5,
        energy_required = 1,
        ingredients = {{{"nickel-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
    }
  end

  tune_up_data.recipes["nickel-bacteria"] = {
    category = "purification",
    count = 4,
    energy_required = 2,
    result_is_always_fresh = true,
    ingredients = {{{"nickel-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"nickel-bacteria", 1}, {"nutrients", 8}}}
  }

  tune_up_data.recipes["malachite"] = {
      category = "purification",
      count = 10,
      energy_required = 1,
      ingredients = {{{"copper-ore", 5}, {"sulfur", 1}, {"sulfuric-acid", 25}}}
  }

  tune_up_data.recipes["nickel-plate"] = {
    category = "purification",
    count = 10,
    energy_required = 10,
    ingredients = {{{"nickel-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"nickel-ore", 5}}}
  }

  tune_up_data.recipes["invar-plate"] = {
    category = "purification",
    count = 10,
    energy_required = 10,
    ingredients = {{{"invar-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"nickel-ore", 10}, {"iron-ore", 10}}}
  }

  tune_up_data.recipes["electric-motor"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 2,
    ingredients = {{{"electromagnetic-coil", misc.difficulty * 3}}, {{"electronic-circuit", 2}}}
  }

  tune_up_data.recipes["high-pressure-valve"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 2,
    ingredients = {{{"invar-plate", 1}, {"galvanized-tubing", 1}}, {{"invar-plate", 1}, {"pipe", 1}}}
  }

  tune_up_data.recipes["cooling-fan"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 1,
    ingredients = {{{"malleable-logarithmic-casing", 1}}, {{"iron-stick", 3}}}
  }

  tune_up_data.recipes["electromagnetic-coil"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 1,
    ingredients = {{{"nickel-plate", 1}, {"gold-wire", 1}}, {{"nickel-plate", 1}, {"tinned-cable", 1}}, {{"nickel-plate", 1}}}
  }

  tune_up_data.recipes["fluid-regulator"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 1,
    ingredients = {{{"galvanized-tubing", 2}, {"stepper-motor", 1}}, {{"pipe", 2}, {"stepper-motor", 1}}, {{"galvanized-tubing", 2}, {"advanced-circuit", 1}}, {{"pipe", 2}, {"advanced-circuit", 1}}}
  }

  tune_up_data.recipes["motorized-arm"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 1,
    ingredients = {{{"stepper-motor", 1}}, {{"advanced-circuit", 1}}}
  }

  tune_up_data.recipes["gimbaled-rocket-engine"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 1,
    ingredients = {{{"high-pressure-valve", 2}, {"nitinol-plate", 1}}, {{"high-pressure-valve", 2}}}
  }

  tune_up_data.recipes["stem-cells"] = {
    category = "purification",
    count = 3,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"philosophers-hormone", 1}}}
  }

  tune_up_data.recipes["skeletal-bioculture"] = {
    category = "purification",
    count = 40,
    energy_required = 20,
    result_is_always_fresh = true,
    ingredients = {{{"calcite", 1}}}
  }

  tune_up_data.recipes["musculoskeletal-bioculture"] = {
    category = "purification",
    count = 3,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"stem-cells", 1}, {"yumako-mash", 2}}}
  }

  tune_up_data.recipes["vascular-bioculture"] = {
    category = "purification",
    count = 5,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"philosophers-hormone", 1}}}
  }

  tune_up_data.recipes["cardiac-bioculture"] = {
    category = "purification",
    count = 5,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"stem-cells", 1}, {"jelly", 4}}}
  }

  tune_up_data.recipes["vestibular-bioculture"] = {
    category = "purification",
    count = 5,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"stem-cells", 1}, {"jelly", 4}}}
  }

  tune_up_data.recipes["ambifacient-lunar-waneshaft"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 3,
    result_is_always_fresh = true,
    ingredients = {{{"molten-nickel", 25}, {"linkages", 1}}, {{"nickel-plate", 2}, {"linkages", 1}}, {{"molten-nickel", 25}, {"iron-stick", 2}}, {{"nickel-plate", 2}, {"iron-stick", 2}}}
  }

  tune_up_data.recipes["grabber"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 3,
    result_is_always_fresh = true,
    ingredients = {{{"differential-girdlespring", 2}, {"advanced-circuit", 2}}, {{"complex-joint", 2}, {"advanced-circuit", 2}}, {{"electric-motor", 10}, {"advanced-circuit", 2}}}
  }

  tune_up_data.recipes["nitinol-plate"] = {
    category = "purification",
    count = 8,
    energy_required = 10,
    result_is_always_fresh = true,
    ingredients = {{{"nitinol-plate", 2}, {"calcite", 1}, {"sulfuric-acid", 50}, {"vacuum", 5}}}
  }

  tune_up_data.recipes["self-regulating-valve"] = {
    category = "tuning-up",
    count = 8,
    energy_required = 10,
    result_is_always_fresh = true,
    ingredients = {{{"high-pressure-valve", 1}}}
  }

  tune_up_data.recipes["non-reversible-tremie-pipe"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 4,
    result_is_always_fresh = true,
    ingredients = {{{"self-regulating-valve", 1}}, {{"cardiac-bioculture", 1}}}
  }
end

if misc.difficulty == 1 then return end

if misc.difficulty == 3 or not mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "cooling-fan",
            category = "crafting",
            ingredients = {
                {type="item", name="plastic-bar", amount=4},
                {type="item", name="electric-motor", amount=1}
            },
            results = {
                {type="item", name="cooling-fan", amount=1}
            },
            energy_required = 2,
            lasermill_dlc = {helium = -1},
            allow_productivity = true,
            enabled = false
        }
    })
end

data:extend({
    {
        type = "recipe",
        name = "electromagnetic-coil",
        category = mods["space-age"] and "electronics" or "crafting",
        ingredients = {
            {type="item", name="nickel-plate", amount=1},
            {type="item", name="copper-cable", amount=1},
        },
        results = {
            {type="item", name="electromagnetic-coil", amount=1}
        },
        energy_required = 0.5,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "fluid-regulator",
        category = "crafting",
        ingredients = {
            {type="item", name="high-pressure-valve", amount=1},
            {type="item", name="electric-motor", amount=1},
            {type="item", name="electronic-circuit", amount=1}
        },
        results = {
            {type="item", name="fluid-regulator", amount=1}
        },
        energy_required = 2,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "motorized-arm",
        category = mods["RoboticsFacility"] and "robotics" or "crafting",
        ingredients = {
            {type="item", name="iron-stick", amount=6},
            {type="item", name="electric-motor", amount=2},
            {type="item", name="electronic-circuit", amount=1}
        },
        results = {
            {type="item", name="motorized-arm", amount=1}
        },
        energy_required = 2,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "gimbaled-rocket-engine",
        category = "advanced-crafting",
        ingredients = {
            {type="item", name="high-pressure-valve", amount=2},
            {type="item", name="motorized-arm", amount=1},
            {type="item", name="iron-gear-wheel", amount=5},
            {type="item", name="invar-plate", amount=2}
        },
        results = {
            {type="item", name="gimbaled-rocket-engine", amount=1}
        },
        energy_required = 10,
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    }
})

if mods["LunarLandings"] then
    data:extend({
        {
            type = "recipe",
            name = "pack-gimbaled-rocket-engine",
            category = "crafting",
            icon = "__IfNickelMk2__/graphics/icons/gimbaled-rocket-engine-packed.png",
            subgroup = "ll-packed-rocket-ingredients",
            order = "x",
            localised_name = { "recipe-name.ll-pack-rocket-ingredient", {"item-name.gimbaled-rocket-engine"} },
            ingredients = {
                {type="item", name="gimbaled-rocket-engine", amount=5},
            },
            results = {
                {type="item", name="gimbaled-rocket-engine-packed", amount=1}
            },
            auto_recycle = false,
            energy_required = 2,
            allow_quality = false,
            enabled = false
        },
        {
            type = "recipe",
            name = "unpack-gimbaled-rocket-engine",
            category = "crafting",
            icon = "__IfNickelMk2__/graphics/icons/gimbaled-rocket-engine-packed.png",
            subgroup = "ll-packed-rocket-ingredients",
            order = "y",
            localised_name = { "recipe-name.ll-unpack-rocket-ingredient", {"item-name.gimbaled-rocket-engine"} },
            ingredients = {
                {type="item", name="gimbaled-rocket-engine-packed", amount=1}
            },
            results = {
                {type="item", name="gimbaled-rocket-engine", amount=5},
            },
            auto_recycle = false,
            energy_required = 2,
            allow_quality = false,
            enabled = false
        }
    })
end

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "stem-cells",
            category = "organic",
            ingredients = {
                {type="item", name="pentapod-egg", amount=1}
            },
            results = {
                {type="item", name="stem-cells", amount=6}
            },
            auto_recycle = false,
            energy_required = 2,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {0.3, 1, 0, 1},
              secondary = {0.5, 0.8, 0.4, 1},
            }
        },
        {
            type = "recipe",
            name = "skeletal-bioculture",
            category = "organic",
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="iron-bacteria", amount=1},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="skeletal-bioculture", amount=mods["BrassTacksMk2"] and 3 or 8}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {1, 1, 0.7, 1},
              secondary = {0.8, 0.8, 0.6, 1},
            }
        },
        {
            type = "recipe",
            name = "musculoskeletal-bioculture",
            category = "organic",
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="nickel-bacteria", amount=1},
                {type="item", name="bioflux", amount=1},
                {type="item", name="skeletal-bioculture", amount=mods["BrassTacksMk2"] and 1 or 2},
            },
            results = {
                {type="item", name="musculoskeletal-bioculture", amount=1}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {0.9, 0.1, 0.1, 1},
              secondary = {0.8, 0.4, 0.4, 1},
            }
        },
        {
            type = "recipe",
            name = "vascular-bioculture",
            category = "organic",
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="copper-bacteria", amount=1},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="vascular-bioculture", amount=4}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {0.1, 1, 0.1, 1},
              secondary = {0.4, 0.8, 0.4, 1},
            }
        },
        {
            type = "recipe",
            name = "cardiac-bioculture",
            category = "organic",
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="nickel-bacteria", amount=1},
                {type="item", name="bioflux", amount=1},
                {type="item", name="vascular-bioculture", amount=1},
            },
            results = {
                {type="item", name="cardiac-bioculture", amount=1}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
            result_is_always_fresh = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {0.9, 0.1, 0.1, 1},
              secondary = {0.8, 0.4, 0.4, 1},
            }
        }
    })

    if mods["BrassTacksMk2"] then
        data:extend({
            {
                type = "recipe",
                name = "vestibular-bioculture",
                category = "organic",
                ingredients = {
                    {type="item", name="stem-cells", amount=1},
                    {type="item", name="zinc-bacteria", amount=1},
                    {type="item", name="bioflux", amount=1},
                    {type="item", name="vascular-bioculture", amount=1},
                },
                results = {
                    {type="item", name="vestibular-bioculture", amount=1}
                },
                auto_recycle = false,
                energy_required = 3,
                allow_productivity = true,
                result_is_always_fresh = true,
                enabled = false,
                crafting_machine_tint =
                {
                  primary = {0.1, 0.9, 0.1, 1},
                  secondary = {0.4, 0.8, 0.4, 1},
                }
            }
        })
    end
end

if misc.difficulty == 2 then return end

data:extend({
    {
        type = "recipe",
        name = "ambifacient-lunar-waneshaft",
        category = "crafting",
        ingredients = {
            {type="item", name="steel-plate", amount=1},
            {type="item", name="invar-plate", amount=1},
            {type="item", name="iron-stick", amount=4}
        },
        results = {
            {type="item", name="ambifacient-lunar-waneshaft", amount=1}
        },
        energy_required = 2,
        lasermill_vanilla = {helium = -1},
        lasermill_dlc = {helium = -1},
        allow_productivity = true,
        enabled = false
    },
    {
        type = "recipe",
        name = "grabber",
        category = mods["RoboticsFacility"] and "robotics" or "crafting",
        ingredients = {
            {type="item", name="motorized-arm", amount=3},
            {type="item", name="electric-engine-unit", amount=1},
            {type="item", name="iron-gear-wheel", amount=6}
        },
        results = {
            {type="item", name="grabber", amount=1}
        },
        energy_required = 8,
        lasermill_dlc = {helium = -1},
        allow_productivity = false,
        enabled = false
    }
})

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "organ-preservation",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/cardiac-bioculture.png",
                    icon_size = 64
                },
                {
                    icon = "__space-age__/graphics/icons/ice.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.25,
                    shift = {8, 8}
                },
            },
            category = "cryogenics",
            ingredients = {
                {type="item", name="cardiac-bioculture", amount=1},
                {type="item", name="ice", amount=1}
            },
            results = {
                {type="item", name="cardiac-bioculture", amount=1}
            },
            auto_recycle = false,
            energy_required = 3,
            result_is_always_fresh = true,
            allow_quality = false,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {1, 0, 0, 1},
              secondary = {0, 1, 0, 1},
              tertiary = {0, 0, 1, 1},
              quaternary = {1, 1, 1, 1},
            }
        },
        {
            type = "recipe",
            name = "bacterium-extraction-from-sludge",
            subgroup = "original-dint",
            order = "y",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/mutagenic-sludge.png",
                    icon_size = 64
                },
                {
                    icon = "__space-age__/graphics/icons/iron-bacteria.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.25,
                    shift = {8, 8}
                },
            },
            category = "organic",
            ingredients = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1}
            },
            results = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, ignored_by_productivity=0, probability=0.55},
                {type="item", name="iron-bacteria", amount=1, probability=0.1},
                {type="item", name="copper-bacteria", amount=1, probability=0.1},
                {type="item", name="nickel-bacteria", amount=1, probability=0.05},
            },
            auto_recycle = false,
            energy_required = 5,
            allow_productivity = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {1, 0, 1, 1},
              secondary = {0.8, 0.4, 0.8, 1},
            }
        },
        {
            type = "recipe",
            name = "mutagenic-sludge-quelling",
            subgroup = "original-dint",
            order = "z",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/mutagenic-sludge.png",
                    icon_size = 64
                },
                {
                    icon = "__pf-sa-compat__/graphics/icons/philosophers-hormone.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {8, 8}
                },
            },
            category = "organic",
            ingredients = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1},
                {type="item", name="philosophers-hormone", amount=10}
            },
            results = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, ignored_by_productivity=0, probability=0.25},
                {type="item", name="spoilage", amount=1}
            },
            auto_recycle = false,
            energy_required = 3,
            result_is_always_fresh = true,
            allow_productivity = true,
            enabled = false,
            crafting_machine_tint =
            {
              primary = {1, 0, 1, 1},
              secondary = {0.8, 0.4, 0.8, 1},
            }
        }
    })
    
    if mods["BrassTacksMk2"] then
        rm.AddProduct("bacterium-extraction-from-sludge", {type="item", name="zinc-bacteria", amount=1, probability=0.05})
    end
    rm.AddProduct("musculoskeletal-bioculture", {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, probability=0.05})
    rm.AddProduct("cardiac-bioculture", {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, probability=0.05})
    rm.AddProduct("vestibular-bioculture", {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, probability=0.05})

end

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "non-reversible-tremie-pipe",
            category = "advanced-crafting",
            ingredients = {
                {type="item", name=mods["bztitanium"] and "self-regulating-valve" or "high-pressure-valve", amount=6},
                {type="item", name="fluid-regulator", amount=6},
                {type="item", name="vascular-bioculture", amount=6},
                {type="item", name="bioflux", amount=6}
            },
            results = {
                {type="item", name="non-reversible-tremie-pipe", amount=1}
            },
            auto_recycle = false,
            energy_required = 6,
            lasermill_dlc = {helium = -1, unlock="tissue-cultivation"},
            allow_productivity = true,
            auto_recycle = false,
            enabled = false,
        },
        {
            type = "recipe",
            name = "non-reversible-tremie-pipe-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.non-reversible-tremie-pipe"}},
            icons = {
                    {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__IfNickelMk2__/graphics/icons/non-reversible-tremie-pipe.png",
                        icon_size = 64,
                        scale = 0.33
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="non-reversible-tremie-pipe", amount=1}
            },
            results = {
                {type="item", name="epip-eimert-elbisrever-non", amount=1}
            },
            hidden_in_factoriopedia = true,
            bespoke = "non-reversible-tremie-pipe",
            energy_required = 1,
            allow_quality = false,
            auto_recycle = false,
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "epip-eimert-elbisrever-non-recycling",
            localised_name = {"recipe-name.gnilcycer-epip-eimert-elbisrever-non"},
            icons = {
                    {
                        icon = "__quality__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__IfNickelMk2__/graphics/icons/epip-eimert-elbisrever-non.png",
                        icon_size = 64,
                        scale = 0.33
                      },
                      {
                        icon = "__quality__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            category = "recycling",
            ingredients = {
                {type="item", name="epip-eimert-elbisrever-non", amount=1}
            },
            results = {
                {type="item", name="non-reversible-tremie-pipe", amount=1}
            },
            auto_recycle = false,
            hidden_in_factoriopedia = true,
            energy_required = 1,
            allow_quality = false,
            auto_recycle = false,
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        }
    })
end

if mods["space-age"] and mods["bztitanium"] then
    data:extend({
        {
            type = "recipe",
            name = "nitinol-precursor",
            category = "crafting",
            ingredients = {
                {type="item", name="nickel-plate", amount=5},
                {type="item", name="titanium-plate", amount=1}
            },
            results = {
                {type="item", name="nitinol-precursor", amount=10}
            },
            auto_recycle = false,
            energy_required = 1,
            allow_productivity = false,
            enabled = false
        },
        {
            type = "recipe",
            name = "nitinol-plate",
            category = "smelting",
            ingredients = {
                {type="item", name="nitinol-precursor", amount=15}
            },
            results = {
                {type="item", name="nitinol-plate", amount=1}
            },
            surface_conditions = {
                {
                    property = "pressure",
                    min = 1
                }
            },
            energy_required = 8,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "nitinol-plate-in-space",
            category = "metallurgy",
            ingredients = {
                {type="item", name="nitinol-precursor", amount=10},
                {type="item", name="metallic-asteroid-chunk", amount=1},
                {type="fluid", name="vacuum", amount=5}
            },
            results = {
                {type="item", name="nitinol-plate", amount=10}
            },
            surface_conditions = {
                {
                    property = "pressure",
                    min = 0,
                    max = 0
                }
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "self-regulating-valve",
            category = "advanced-crafting",
            ingredients = {
                {type="item", name="high-pressure-valve", amount=1},
                {type="item", name="nitinol-plate", amount=1},
                {type="item", name="pipe", amount=3}
            },
            results = {
                {type="item", name="self-regulating-valve", amount=1}
            },
            energy_required = 4,
            lasermill_dlc = {helium = -1},
            allow_productivity = true,
            enabled = false
        }
    })
end

if mods["space-age"] and mods["castra"] then
    data:extend({
        {
            type = "recipe",
            name = "ambifacient-lunar-waneshaft-gunpowder",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/ambifacient-lunar-waneshaft.png",
                    icon_size = 64,
                    scale = 0.7,
                    shift = {0, -10}
                },
                {
                    icon = "__castra__/graphics/icons/gunpowder.png",
                    icon_size = 64,
                    scale = 0.5,
                    shift = {-10, 10}
                }
            },
            category = "advanced-crafting",
            ingredients = {
                {type="item", name="invar-plate", amount=1},
                {type="item", name=mods["BrassTacksMk2"] and "galvanized-rod" or "iron-stick", amount=4},
                {type="item", name="gunpowder", amount=5}
            },
            results = {
                {type="item", name="ambifacient-lunar-waneshaft", amount=1}
            },
            auto_recycle = false,
            energy_required = 2,
            allow_productivity = true,
            enabled = false
        },
    })
end