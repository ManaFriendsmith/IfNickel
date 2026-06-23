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
        categories={"smelting"},
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
        categories={"crafting"},
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
        categories={"smelting"},
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
        categories = mods["space-age"] and {"crafting", "electromagnetics"} or {"crafting"},
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
        categories={"advanced-crafting"},
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

    data.raw.item["invar-plate"].auto_recycle = false
    data:extend({
    {
            type = "recipe",
            name = "invar-plate-recycling",
            localised_name = {"recipe-name.recycling", {"item-name.invar-plate"}},
            icons = {
                      {
                        icon = "__recycler__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__IfNickelMk2__/graphics/icons/invar-plate.png",
                        icon_size = 64,
                        scale = 0.37
                      },
                      {
                        icon = "__recycler__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            categories={"recycling"},
            ingredients = {
                {type="item", name="invar-plate", amount=1}
            },
            results = {
                {type="item", name=mods["scrap-industry"] and "invar-scrap" or "invar-precursor", amount=1, independent_probability = 0.25}
            },
            energy_required = 0.4,
            allow_productivity = false,
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "invar-separation",
            icon = "__IfNickelMk2__/graphics/icons/invar-separation.png",
            icon_size = 64,
            categories={"centrifuging"},
            ingredients = {
                {type="item", name=mods["scrap-industry"] and "invar-scrap" or "invar-precursor", amount=1}
            },
            results = {
                {type="item", name=mods["scrap-industry"] and "iron-scrap" or "iron-ore", amount=1, independent_probability = 0.12},
                {type="item", name=mods["scrap-industry"] and "nickel-scrap" or "nickel-ore", amount=1, independent_probability = 0.12}
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
            name = "nickel-ore-melting",
            icon = "__pf-sa-compat__/graphics/icons/nickel-ore-melting.png",
            icon_size = 64,
            icon_mipmaps = 4,
            subgroup = "vulcanus-processes",
            order = "a[melting]-d",
            categories={"metallurgy"},
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
            categories={"metallurgy"},
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
            categories={"metallurgy"},
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
            categories={"metallurgy"},
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
            categories={"metallurgy"},
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
            categories={"organic"},
            ingredients = {
                {type="item", name=mods["BrassTacksMk2"] and "iron-bacteria" or "copper-bacteria", amount=3},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="nickel-bacteria", amount=3, always_fresh=true}
            },
            energy_required = 2,
            auto_recycle = false,
            allow_productivity = true,
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
                categories={"synthesis"},
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

    if mods["planet-muluna"] and not mods["BrassTacksMk2"] then
        data:extend({
            {
                type = "recipe",
                name = "asteroid-crushing-for-nickel",
                icon = "__pf-sa-compat__/graphics/icons/advanced-ferrous-asteroid-crushing.png",
                icon_size = 64,
                subgroup = "space-crushing",
                order = "b-a-a-a",
                categories={"crushing"},
                ingredients = {
                    {type="item", name="metallic-asteroid-chunk", amount=1},
                },
                results = {
                    {type="item", name="nickel-ore", amount=5},
                    {type="item", name="metallic-asteroid-chunk", amount=1, independent_probability=0.05}
                },
                energy_required = 5,
                auto_recycle = false,
                allow_productivity = true,
                allow_decomposition = false,
                enabled = false
            }
        })
    end

    if mods["Moshine"] then
        local motor_new = table.deepcopy(data.raw.recipe["electric-motor"])
        motor_new.name = "neodymium-motor"
        rm.MultiplyRecipe(motor_new, {input=2, time=2, output=4})
        rm.AddIngredient(motor_new, "magnet", 1)
        motor_new.localised_name = {"recipe-name.neodymium-motor"}
        motor_new.auto_recycle = false
        motor_new.categories={"electromagnetics"}
        motor_new.icons = {
            {
                icon = "__IfNickelMk2__/graphics/icons/electric-motor.png",
                icon_size = 64
            },
            {
                icon = "__Moshine__/graphics/icons/magnet.png",
                icon_size = 64,
                scale = 0.25,
                shift = {8, -8}
            }
        }
        motor_new.lasermill_dlc = nil
        data:extend({motor_new})
    end
end

if tune_up_data then
  if not mods["space-age"] then
    tune_up_data.recipes["nickel-ore"] = {
        categories={"purification"},
        count = 5,
        energy_required = 1,
        ingredients = {{{"nickel-ore", 5}, {"stone", 1}, {"sulfuric-acid", 25}}}
    }
  end

  tune_up_data.recipes["nickel-bacteria"] = {
    categories={"purification"},
    count = 4,
    energy_required = 2,
    result_is_always_fresh = true,
    ingredients = {{{"nickel-bacteria", 1}, {"philosophers-hormone", 1}, {"growth-serum", 5}}, {{"nickel-bacteria", 1}, {"nutrients", 8}}}
  }

  tune_up_data.recipes["malachite"] = {
      categories={"purification"},
      count = 10,
      energy_required = 1,
      ingredients = {{{"copper-ore", 5}, {"sulfur", 1}, {"sulfuric-acid", 25}}}
  }

  tune_up_data.recipes["nickel-plate"] = {
    categories={"purification"},
    count = 10,
    energy_required = 10,
    ingredients = {{{"nickel-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"nickel-ore", 5}}}
  }

  tune_up_data.recipes["invar-plate"] = {
    categories={"purification"},
    count = 10,
    energy_required = 10,
    ingredients = {{{"invar-plate", 5}, {"sulfuric-acid", 50}, {"calcite", 1}}, {{"stone", 1}, {"nickel-ore", 10}, {"iron-ore", 10}}}
  }

  tune_up_data.recipes["electric-motor"] = {
    categories={"tuning-up"},
    count = 2,
    energy_required = 2,
    ingredients = {{{"electromagnetic-coil", misc.difficulty * 3}}, {{"electronic-circuit", 2}}}
  }

  tune_up_data.recipes["high-pressure-valve"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 2,
    ingredients = {{{"invar-plate", 1}, {"galvanized-tubing", 1}}, {{"invar-plate", 1}, {"pipe", 1}}}
  }

  tune_up_data.recipes["cooling-fan"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 1,
    ingredients = {{{"malleable-logarithmic-casing", 1}, {"plastic-bar", 1}}, {{"plastic-bar", 2}, {"gold-wire", 2}}, {{"plastic-bar", 2}, {"copper-wire", 2}}}
  }

  tune_up_data.recipes["electromagnetic-coil"] = {
    categories={"tuning-up"},
    count = 2,
    energy_required = 1,
    ingredients = {{{"nickel-plate", 1}, {"gold-wire", 1}}, {{"nickel-plate", 1}, {"tinned-cable", 1}}, {{"nickel-plate", 1}}}
  }

  tune_up_data.recipes["fluid-regulator"] = {
    categories={"tuning-up"},
    count = 2,
    energy_required = 1,
    ingredients = {{{"galvanized-tubing", 2}, {"stepper-motor", 1}}, {{"pipe", 2}, {"stepper-motor", 1}}, {{"galvanized-tubing", 2}, {"advanced-circuit", 1}}, {{"pipe", 2}, {"advanced-circuit", 1}}}
  }

  tune_up_data.recipes["motorized-arm"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 1,
    ingredients = {{{"stepper-motor", 2}}, {{"advanced-circuit", 2}}}
  }

  tune_up_data.recipes["gimbaled-rocket-engine"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 1,
    ingredients = {{{"high-pressure-valve", 2}, {"nitinol-plate", 1}}, {{"high-pressure-valve", 2}}}
  }

  tune_up_data.recipes["stem-cells"] = {
    categories={"purification"},
    count = 3,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"philosophers-hormone", 1}}}
  }

  tune_up_data.recipes["skeletal-bioculture"] = {
    categories={"purification"},
    count = 40,
    energy_required = 20,
    result_is_always_fresh = true,
    ingredients = {{{"calcite", 1}}}
  }

  tune_up_data.recipes["musculoskeletal-bioculture"] = {
    categories={"purification"},
    count = 3,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"stem-cells", 1}, {"yumako-mash", 2}}}
  }

  tune_up_data.recipes["vascular-bioculture"] = {
    categories={"purification"},
    count = 5,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"philosophers-hormone", 1}}}
  }

  tune_up_data.recipes["cardiac-bioculture"] = {
    categories={"purification"},
    count = 5,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"stem-cells", 1}, {"jelly", 4}}}
  }

  tune_up_data.recipes["vestibular-bioculture"] = {
    categories={"purification"},
    count = 5,
    energy_required = 1,
    result_is_always_fresh = true,
    ingredients = {{{"stem-cells", 1}, {"jelly", 4}}}
  }

  tune_up_data.recipes["ambifacient-lunar-waneshaft"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 3,
    result_is_always_fresh = true,
    ingredients = {{{"molten-nickel", 25}, {"linkages", 1}}, {{"nickel-plate", 2}, {"linkages", 1}}, {{"molten-nickel", 25}, {"iron-stick", 2}}, {{"nickel-plate", 2}, {"iron-stick", 2}}}
  }

  tune_up_data.recipes["grabber"] = {
    categories={"tuning-up"},
    count = 1,
    energy_required = 3,
    result_is_always_fresh = true,
    ingredients = {{{"differential-girdlespring", 2}, {"advanced-circuit", 2}}, {{"complex-joint", 2}, {"advanced-circuit", 2}}, {{"electric-motor", 10}, {"advanced-circuit", 2}}}
  }

  tune_up_data.recipes["nitinol-plate"] = {
    categories={"purification"},
    count = 8,
    energy_required = 10,
    result_is_always_fresh = true,
    ingredients = {{{"nitinol-plate", 2}, {"calcite", 1}, {"sulfuric-acid", 50}, {"vacuum", 5}}}
  }

  tune_up_data.recipes["self-regulating-valve"] = {
    categories={"tuning-up"},
    count = 8,
    energy_required = 10,
    result_is_always_fresh = true,
    ingredients = {{{"high-pressure-valve", 1}}}
  }

  tune_up_data.recipes["non-reversible-tremie-pipe"] = {
    categories={"tuning-up"},
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
            categories={"crafting"},
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
        categories = mods["space-age"] and {"crafting", "electromagnetics"} or {"crafting"},
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
        categories={"crafting"},
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
        categories = mods["RoboticsFacility"] and {"robotics"} or {"crafting"},
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
        categories={"advanced-crafting"},
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
            categories={"crafting"},
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
            categories={"crafting"},
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
    data.raw.item["invar-plate"].auto_recycle = false
    data:extend({
        {
            type = "recipe",
            name = "stem-cells",
            categories={"organic"},
            ingredients = {
                {type="item", name="pentapod-egg", amount=1}
            },
            results = {
                {type="item", name="stem-cells", amount=6, always_fresh=true}
            },
            auto_recycle = false,
            energy_required = 2,
            allow_productivity = true,
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
            categories={"organic"},
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="iron-bacteria", amount=1},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="skeletal-bioculture", amount=mods["BrassTacksMk2"] and 3 or 8, always_fresh=true}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
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
            categories={"organic"},
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="nickel-bacteria", amount=1},
                {type="item", name="bioflux", amount=1},
                {type="item", name="skeletal-bioculture", amount=mods["BrassTacksMk2"] and 1 or 2},
            },
            results = {
                {type="item", name="musculoskeletal-bioculture", amount=1, always_fresh=true}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
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
            categories={"organic"},
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="copper-bacteria", amount=1},
                {type="item", name="philosophers-hormone", amount=1},
            },
            results = {
                {type="item", name="vascular-bioculture", amount=4, always_fresh=true}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
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
            categories={"organic"},
            ingredients = {
                {type="item", name="stem-cells", amount=1},
                {type="item", name="nickel-bacteria", amount=1},
                {type="item", name="bioflux", amount=1},
                {type="item", name="vascular-bioculture", amount=1},
            },
            results = {
                {type="item", name="cardiac-bioculture", amount=1, always_fresh=true}
            },
            auto_recycle = false,
            energy_required = 3,
            allow_productivity = true,
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
                categories={"organic"},
                ingredients = {
                    {type="item", name="stem-cells", amount=1},
                    {type="item", name="zinc-bacteria", amount=1},
                    {type="item", name="bioflux", amount=1},
                    {type="item", name="vascular-bioculture", amount=1},
                },
                results = {
                    {type="item", name="vestibular-bioculture", amount=1, always_fresh=true}
                },
                auto_recycle = false,
                energy_required = 3,
                allow_productivity = true,
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
        categories={"crafting"},
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
        categories = mods["RoboticsFacility"] and {"robotics"} or {"crafting"},
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
            categories={"cryogenics"},
            ingredients = {
                {type="item", name="cardiac-bioculture", amount=1},
                {type="item", name="ice", amount=1}
            },
            results = {
                {type="item", name="cardiac-bioculture", amount=1, always_fresh=true}
            },
            auto_recycle = false,
            energy_required = 3,
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
            categories={"organic"},
            ingredients = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1}
            },
            results = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, ignored_by_productivity=0, independent_probability=0.55},
                {type="item", name="iron-bacteria", amount=1, independent_probability=0.1},
                {type="item", name="copper-bacteria", amount=1, independent_probability=0.1},
                {type="item", name="nickel-bacteria", amount=1, independent_probability=0.05},
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
            categories={"organic"},
            ingredients = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1},
                {type="item", name="philosophers-hormone", amount=10}
            },
            results = {
                {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, ignored_by_productivity=0, independent_probability=0.25, always_fresh=true},
                {type="item", name="spoilage", amount=1}
            },
            auto_recycle = false,
            energy_required = 3,
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
        rm.AddProduct("bacterium-extraction-from-sludge", {type="item", name="zinc-bacteria", amount=1, independent_probability=0.05})
    end
    rm.AddProduct("musculoskeletal-bioculture", {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, independent_probability=0.05, always_fresh=true})
    rm.AddProduct("cardiac-bioculture", {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, independent_probability=0.05, always_fresh=true})
    rm.AddProduct("vestibular-bioculture", {type="item", name="mutagenic-sludge", amount=1, ignored_by_stats=1, independent_probability=0.05, always_fresh=true})

end

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "non-reversible-tremie-pipe",
            categories={"advanced-crafting"},
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
                        icon = "__recycler__/graphics/icons/recycling.png",
                        icon_size = 64
                      },
                      {
                        icon = "__IfNickelMk2__/graphics/icons/non-reversible-tremie-pipe.png",
                        icon_size = 64,
                        scale = 0.33
                      },
                      {
                        icon = "__recycler__/graphics/icons/recycling-top.png",
                        icon_size = 64
                      }
            },
            categories={"recycling"},
            ingredients = {
                {type="item", name="non-reversible-tremie-pipe", amount=1}
            },
            results = {
                {type="item", name="epip-eimert-elbisrever-non", amount=1}
            },
            bespoke = "non-reversible-tremie-pipe",
            energy_required = 1,
            auto_recycle = false,
            enabled = true,
            hidden = true,
            allow_decomposition = false,
            unlock_results = false
        },
        {
            type = "recipe",
            name = "double-half-rotation",
            categories = mods["LasingAroundMk2"] and {"conceptual-inversion"} or {"organic"},
            icon = "__IfNickelMk2__/graphics/icons/double-half-rotation.png",
            icon_size = 64,
            order = "c[advanced-intermediates]-2a3",
            ingredients = {
                {type="item", name="epip-eimert-elbisrever-non", amount=2},
                {type="item", name=mods["LasingAroundMk2"] and "perpendicular-processor" or "electric-motor", amount=mods["LasingAroundMk2"] and 1 or 6}
            },
            results = {
                {type="item", name="non-reversible-tremie-pipe", amount=1}
            },
            maximum_productivity = 0,
            auto_recycle = false,
            energy_required = 4,
            allow_productivity = false,
            auto_recycle = false,
            enabled = false,
        }
    })

    if not mods["LasingAroundMk2"] then
        data.raw.recipe["double-half-rotation"].localised_description = {"recipe-description.hint-no-biochamber-prod"}
    end
end

if mods["space-age"] and mods["bztitanium"] then
    data:extend({
        {
            type = "recipe",
            name = "nitinol-precursor",
            categories={"crafting"},
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
            categories={"smelting"},
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
            categories={"metallurgy"},
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
            categories={"advanced-crafting"},
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
            categories={"advanced-crafting"},
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