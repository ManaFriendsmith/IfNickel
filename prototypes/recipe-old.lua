local parts = require("variable-parts")
local tf = require("techfuncs")

local yield = 1
local cost = 1

if mods["Krastorio2"] then
  yield = 5
  cost = 10
  if mods["space-exploration"] then
    yield = 15
    cost = 20
  end
end

data:extend({
  {
    type = "recipe",
    name = "invar-valve",
    category = "advanced-crafting",
    normal = {
      enabled = false,
      energy_required = 3,
      ingredients = {{"invar-plate", 1}, {"pipe", 2}, parts.preferred({"airtight-seal", "brass-plate", "copper-plate"}, {1, 2, 2})},
      result = "invar-valve"
    },
    expensive = {
      enabled = false,
      energy_required = 3,
      ingredients = {{"invar-plate", 1}, {"pipe", 2}, parts.preferred({"airtight-seal", "brass-plate", "copper-plate"}, {1, 2, 4})}, --brass is doublecosted
      result = "invar-valve"
    }
  }

})

if not mods["aai-industry"] then
  if mods["bzaluminum"] then
    data:extend({
      {
        type = "recipe",
        name = "motor",
        category = "crafting",
        normal = {
          energy_required = 1,
          ingredients = {{"nickel-plate", 4}, {"iron-stick", 2}, {"aluminum-cable", 1}},
          result = "motor",
          result_count = 2
        },
        expensive = {
          energy_required = 1,
          ingredients = {{"nickel-plate", 8}, {"iron-stick", 2}, {"aluminum-cable", 1}},
          result = "motor",
          result_count = 2
        }
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "motor",
        category = "crafting",
        normal = {
          energy_required = 0.5,
          ingredients = {{"nickel-plate", 2}, {"iron-stick", 1}, {"copper-cable", 2}},
          result = "motor"
        },
        expensive = {
          energy_required = 0.5,
          ingredients = {{"nickel-plate", 4}, {"iron-stick", 1}, {"copper-cable", 4}},
          result = "motor"
        }
      }
    })
  end
end

if not mods["galdocs-manufacturing"] then
  data:extend({
    {
      type = "recipe",
      name = "nickel-plate",
      category = "smelting",
      energy_required = 3.2 * yield,
      ingredients = {{"nickel-ore", cost}},
      result = "nickel-plate",
      result_count = yield
    }
  })
  if parts.foundryEnabled or mods["Krastorio2"] then
    data:extend({
      {
        type = "recipe",
        name = "invar-plate",
        category = parts.foundryEnabled and "founding" or "smelting",
        normal = {
          enabled = false,
          energy_required = 6.4,
          ingredients = {{"iron-plate", 2}, {"nickel-plate", 2}},
          result = "invar-plate"
        },
        expensive = {
          enabled = false,
          energy_required = 6.4,
          ingredients = {{"iron-plate", 2}, {"nickel-plate", 4}},
          result = "invar-plate",
          --a realistic ratio would be 66% iron  33% nickel
          --however there's no rule that each plate item represents the same mass
          --also i think this is just better balancewise. steel already very iron-expensive.
        }
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "invar-precursor",
        category = "crafting",
        normal = {
          enabled = false,
          energy_required = 0.5,
          ingredients = {{"iron-plate", 2}, {"nickel-plate", 2}},
          result = "invar-precursor"
        },
        expensive = {
          enabled = false,
          energy_required = 0.5,
          ingredients = {{"iron-plate", 2}, {"nickel-plate", 6}},
          result = "invar-precursor"
        }
      },
      {
        type = "recipe",
        name = "invar-plate",
        category = "smelting",
        energy_required = 6.4,
        enabled = false,
        ingredients = {{"invar-precursor", 1}},
        result = "invar-plate"
      }
    })
    tf.addRecipeUnlock("invar-processing", "invar-precursor")
  end
end

if parts.experimental then
  data:extend({
    {
      type = "recipe",
      name = "motorized-articulator",
      category = "crafting",
      energy_required = 2,
      enabled = false,
      ingredients = {parts.preferred({"electric-motor", "motor"}, {2, 2}), {"electronic-circuit", 1}, parts.preferred({"articulated-mechanism", "inserter-parts", "iron-gear-wheel"}, {2, 1, 2}), parts.optionalIngredient("bronze-plate", 2)},
      result = "motorized-articulator"
    },
    {
      type = "recipe",
      name = "cooling-fan",
      category = "advanced-crafting",
      normal = {
        energy_required = 2,
        enabled = false,
        ingredients = {parts.preferred({"electric-motor", "motor"}, {1, 1}), {"plastic-bar", 4}},
        result = "cooling-fan"
      },
      expensive = {
        energy_required = 2,
        enabled = false,
        ingredients = {parts.preferred({"electric-motor", "motor"}, {1, 1}), {"plastic-bar", 8}},
        result = "cooling-fan"
      }
    },
    {
      type = "recipe",
      name = "gimbaled-thruster",
      category = "crafting",
      energy_required = 30,
      enabled = false,
      ingredients = {{"motorized-articulator", 1}, {"invar-valve", 1}, parts.preferred({"rocket-engine-nozzle", "se-heat-shielding", "invar-plate"}, {2, 1, 2}), parts.preferred({"complex-joint", "bearing", "iron-gear-wheel"}, {1, 2, 4})},
      result = "gimbaled-thruster"
    },
    {
      type = "recipe",
      name = "flow-controller",
      category = "crafting",
      energy_required = 2,
      enabled = false,
      ingredients = {parts.preferred({"electric-motor", "motor"}, {1, 1}), {"invar-valve", 1}, {"electronic-circuit", 1}, parts.preferred({"tinned-cable", "glass"}, {2, 1})},
      result = "flow-controller"
    }
  })

  if mods["LunarLandings"] then
    data:extend({
      {
        type = "recipe",
        name = "pack-gimbaled-thruster",
        category = "crafting",
        energy_required = 2,
        enabled = false,
        icon = "__IfNickel__/graphics/icons/gimbaled-thruster-packed.png",
        icon_size = 64,
        subgroup = "ll-packed-rocket-ingredients",
        localised_name = {"recipe-name.pack-gimbaled-thruster"},
        order = "za",
        ingredients = {{"gimbaled-thruster", 5}},
        results = {{type="item", name="gimbaled-thruster-packed", amount=1}}
      },
      {
        type = "recipe",
        name = "unpack-gimbaled-thruster",
        category = "crafting",
        energy_required = 2,
        enabled = false,
        icon = "__IfNickel__/graphics/icons/gimbaled-thruster-packed.png",
        icon_size = 64,
        subgroup = "ll-packed-rocket-ingredients",
        localised_name = {"recipe-name.unpack-gimbaled-thruster"},
        order = "zb",
        ingredients = {{"gimbaled-thruster-packed", 1}},
        results = {{type="item", name="gimbaled-thruster", amount=5}}
      }
    })
  end

  if not mods["galdocs-manufacturing"] then
    data:extend({
      {
        type = "recipe",
        name = "machining-tool",
        category = "crafting",
        energy_required = 2,
        enabled = false,
        ingredients = {parts.preferred({"electric-motor", "motor"}, {1, 1}), {"motorized-articulator", 1}, parts.preferred({"tungsten-carbide", "steel-plate"}, {2, 1})},
        result = "machining-tool"
      },
      {
        type = "recipe",
        name = "advanced-machining-tool",
        category = "crafting",
        energy_required = 4,
        enabled = false,
        ingredients = {{"machining-tool", 1}, parts.optionalIngredient("diamond", 1), parts.preferred({"complex-joint", "bearing", "iron-gear-wheel"}, {1, 2, 4}), {"speed-module", 1}},
        result = "advanced-machining-tool"
      }
    })
  end

  if parts.brassExperiment then
    tf.addRecipeUnlock("mechanical-engineering", "motorized-articulator")
  end

  if mods["space-exploration"] then
    data:extend({
      {
        type = "recipe",
        name = "nickel-electromagnet",
        category = "crafting",
        energy_required = 2,
        enabled = false,
        ingredients = {{"electronic-circuit", 1}, {"nickel-plate", 4}, {"copper-cable", 4}},
        result = "nickel-electromagnet",
        result_count = 4
      },
      {
        type = "recipe",
        name = "advanced-flow-controller",
        category = "crafting",
        energy_required = 8,
        enabled = false,
        allow_decomposition = false,
        ingredients = {{"flow-controller", 2}, {"invar-valve", 2}, {"advanced-circuit", 1}, parts.preferred({"kr-steel-pipe", "pipe"}, {4, 10})},
        result = "advanced-flow-controller"
      },
      {
        type = "recipe",
        name = "flow-controller-biological",
        category = "advanced-crafting",
        icons = {
          {
            icon = "__IfNickel__/graphics/icons/flow-controller.png",
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/vitamelange-bloom.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        energy_required = 9,
        enabled = false,
        allow_decomposition = false,
        ingredients = {{"electric-motor", 1}, {"invar-valve", 3}, {"electronic-circuit", 1}, {"se-vitamelange-bloom", 2}, parts.preferred({"tinned-cable", "glass"}, {3, 3})},
        results = {{"flow-controller", 3}},
        main_product = "flow-controller"
      },
      {
        type = "recipe",
        name = "advanced-flow-controller-biological",
        category = "advanced-crafting",
        icons = {
          {
            icon = "__IfNickel__/graphics/icons/advanced-flow-controller.png",
            icon_size = 64
          },
          {
            icon = "__space-exploration-graphics__/graphics/icons/vitamelange-bloom.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        energy_required = 30,
        enabled = false,
        ingredients = {{"flow-controller", 6}, parts.preferred({"self-regulating-valve", "invar-valve"}, {2, 2}), {"advanced-circuit", 1}, parts.preferred({"kr-steel-pipe", "pipe"}, {12, 30}), {"se-vitamelange-bloom", 5}},
        results = {{"advanced-flow-controller", 3}},
        main_product = "advanced-flow-controller"
      }
    })
  end
end

if mods["Krastorio2"] then
  local matterutil = require("__Krastorio2__/lib/public/data-stages/matter-util")
  data:extend(
    {
      {
        type = "recipe",
        name = "enriched-nickel",
        category = "chemistry",
        energy_required = 3,
        ingredients = {{"nickel-ore", 9}, {type="fluid", name="sulfuric-acid", amount=3}, {type="fluid", name="water", amount=25, catalyst_amount = 25}},
        results = {{"enriched-nickel", mods["space-exploration"] and 9 or 6}, {type="fluid", name="dirty-water", amount=25, catalyst_amount=25}},
        main_product = "enriched-nickel",
        enabled = false,
        crafting_machine_tint = {
          primary = {r = 0.0, g = 0.0, b = 1, a = 1.0},
    			secondary = {r = 0.8, g = 0.8, b = 1.0, a = 1.0},
    			tertiary = {r = 0.0, g = 0.0, b = 1.0, a = 1.0},
    			quaternary = {r = 0.7, g = 0.7, b = 1.0, a = 0.5}
        }
      },
      {
        type = "recipe",
        name = "enriched-nickel-plate",
        icons = {
          { icon = "__IfNickel__/graphics/icons/nickel-plate.png", icon_size = 64 },
          { icon = "__IfNickel__/graphics/icons/enriched-nickel.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        category = "smelting",
        energy_required = 16,
        ingredients = {{"enriched-nickel", 5}},
        result = "nickel-plate",
        result_count = 5,
        enabled = false
      },
      {
    		type = "recipe",
    		name = "dirty-water-filtration-nickel",
        subgroup = "raw-material",
    		order = "w013[dirty-water-filtration-zinc]",
    		category = "fluid-filtration",
    		icons =
    		{
    			{
    				icon = data.raw.fluid["dirty-water"].icon,
    				icon_size = data.raw.fluid["dirty-water"].icon_size
    			},
    			{
    				icon = "__IfNickel__/graphics/icons/nickel-ore.png",
    				icon_size =	64,
    				scale = 0.2,
    				shift = {0, 4}
    			}
    		},
    		energy_required = 2,
    		ingredients = { {type = "fluid", name = "dirty-water", amount = 100, catalyst_amount = 100} },
    		results =	{ {type = "fluid", name = "water", amount = 90, catalyst_amount = 90}, {type = "item",  name = "stone", probability = 0.3, amount = 1}, {type = "item",  name = "nickel-ore", probability = 0.1, amount = 1},
    		},
    		crafting_machine_tint =
    		{
    			primary = {r = 0.0, g = 0.0, b = 0.9, a = 0.9},
          secondary = {r = 0.66, g = 0.66, b = 1, a = 0.6}
    		},
        enabled = false
    	}
    }
  )
  matterutil.createMatterRecipe({
    item_name = "nickel-ore",
    minimum_conversion_quantity = 10,
    matter_value = 5,
    energy_required = 1,
    need_stabilizer = false,
    unlocked_by_technology = "kr-matter-nickel-processing"
  })
  matterutil.createMatterRecipe({
    item_name = "nickel-plate",
    minimum_conversion_quantity = 10,
    matter_value = mods["space-exploration"] and 7.5 or 10,
    energy_required = 3,
    only_deconversion = true,
    need_stabilizer = true,
    unlocked_by_technology = "kr-matter-nickel-processing"
  })
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["nickel-ore"] = {name= "nickel-ore"}
  se_delivery_cannon_recipes["nickel-plate"] = {name= "nickel-plate"}
  se_delivery_cannon_recipes["nickel-ingot"] = {name= "nickel-ingot"}
  se_delivery_cannon_recipes["invar-plate"] = {name= "invar-plate"}
  se_delivery_cannon_recipes["invar-ingot"] = {name= "invar-ingot"}
  if mods["Krastorio2"] then
    se_delivery_cannon_recipes["enriched-nickel"] = {name= "enriched-nickel"}
  end
  if parts.nitinol then
    se_delivery_cannon_recipes["nitinol-plate"] = {name= "nitinol-plate"}
  end

  data:extend(
    {
      {
        type = "recipe",
        icon = "__IfNickel__/graphics/icons/molten-nickel.png",
        icon_size = 64,
        subgroup = "nickel",
        name = "molten-nickel",
        category = "smelting",
        energy_required = 60,
        ingredients = {{mods["Krastorio2"] and "enriched-nickel" or "nickel-ore", 24}, {type="fluid", name="se-pyroflux", amount=10}},
        results = {{type="fluid", name="molten-nickel", amount= mods["Krastorio2"] and 750 or 900}},
        enabled = false
      },
      {
        type = "recipe",
        name = "nickel-ingot",
        category = "casting",
        energy_required = 25,
        ingredients = {{type="fluid", name="molten-nickel", amount=250}},
        result = "nickel-ingot",
        result_count = 1,
        enabled = false
      },
      {
        type = "recipe",
        name = "nickel-ingot-to-plate",
        icons = {
          { icon = "__IfNickel__/graphics/icons/nickel-plate.png", icon_size = 64 },
          { icon = "__IfNickel__/graphics/icons/nickel-ingot.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        category = "crafting",
        energy_required = 5,
        ingredients = {{"nickel-ingot", 1}},
        result = "nickel-plate",
        result_count = 10,
        allow_decomposition = false,
        enabled = false
      },
      {
        type = "recipe",
        name = "invar-ingot",
        category = "casting",
        energy_required = 50,
        ingredients = {{type="fluid", name="se-molten-iron", amount=500}, {type="item", name="nickel-ingot", amount=2}},
        result = "invar-ingot",
        result_count = 1,
        enabled = false
      },
      {
        type = "recipe",
        name = "invar-ingot-to-plate",
        icons = {
          { icon = "__IfNickel__/graphics/icons/invar-plate.png", icon_size = 64 },
          { icon = "__IfNickel__/graphics/icons/invar-ingot.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        },
        category = "crafting",
        energy_required = 5,
        ingredients = {{"invar-ingot", 1}},
        result = "invar-plate",
        result_count = 10,
        allow_decomposition = false,
        enabled = false
      }
    }
  )
end

if parts.nitinol then
  if parts.foundryEnabled or mods["Krastorio2"] then
    data:extend({
      {
        type = "recipe",
        name = "nitinol-plate",
        category = parts.foundryEnabled and "founding" or "smelting",
        energy_required = 16,
        ingredients = {{"nickel-plate", 3}, {"titanium-plate", 1}},
        result = "nitinol-plate",
        enabled = false,
        result_count = 2
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "nitinol-precursor",
        category = "crafting",
        energy_required = 0.5,
        ingredients = {{"nickel-plate", 3}, {"titanium-plate", 1}},
        result = "nitinol-precursor",
        enabled = false,
        result_count = 2
      },
      {
        type = "recipe",
        name = "nitinol-plate",
        category = "smelting",
        energy_required = 8,
        ingredients = {{"nitinol-precursor", 1}},
        result = "nitinol-plate",
        enabled = false,
        result_count = 1
      },
    })
  end
  data:extend({
    {
      type = "recipe",
      name = "nitinol-plate-space",
      category = "space-thermodynamics",
      icons = {
        {
          icon = "__IfNickel__/graphics/icons/nitinol-plate.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/astronomic/planet-orbit.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 32,
      ingredients = {{"nickel-plate", 3}, {"titanium-plate", 1}},
      result = "nitinol-plate",
      enabled = false,
      result_count = 4
    },
    {
      type = "recipe",
      name = "self-regulating-valve",
      category = "advanced-crafting",
      energy_required = 8,
      ingredients = {{"nitinol-plate", 1}, {"invar-valve", 1}, parts.preferred({"titanium-palladium-flange", "titanium-plate"}, {2, 2})},
      result = "self-regulating-valve",
      enabled = false,
      result_count = 2
    },
    {
      type = "recipe",
      name = "nitinol-mesh",
      category = "advanced-crafting",
      energy_required = 8,
      ingredients = {{"nitinol-plate", 3}, parts.preferred({"aluminum-2219", "iron-stick"}, {2, 4}), parts.preferred({"carbon-fiber", "plastic-bar"}, {2, 2})},
      result = "nitinol-mesh",
      enabled = false,
      result_count = 2,
      lasermill = {
        convert = true,
        helium = 3,
        se_variant = "space-crafting",
        unlock = "se-space-assembling",
        se_tooltip_entity = "se-space-assembling-machine",
        icon_offset = {8, -8}
      }
    },
    {
      type = "recipe",
      name = "nitinol-mesh-beryllium",
      category = "advanced-crafting",
      icons = {
        {
          icon = "__IfNickel__/graphics/icons/nitinol-mesh.png",
          icon_size = 64
        },
        {
          icon = "__space-exploration-graphics__/graphics/icons/beryllium-plate.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 24,
      ingredients = {{"nitinol-plate", 6}, {"se-beryllium-plate", 1}, parts.preferred({"carbon-fiber", "plastic-bar"}, {4, 4})},
      result = "nitinol-mesh",
      enabled = false,
      result_count = 6,
      lasermill = {
        convert = true,
        helium = 9,
        se_variant = "space-crafting",
        unlock = "nitinol-mesh-beryllium",
        se_tooltip_entity = "se-space-assembling-machine",
        icon_offset = {8, -8}
      }
    }
  })
  if mods["LasingAround"] then
    data:extend({
      {
        type = "recipe",
        name = "nitinol-plate-helium",
        category = "smelting",
        icons = {
          {
            icon = "__IfNickel__/graphics/icons/nitinol-plate.png",
            icon_size = 64
          },
          {
            icon = "__LasingAround__/graphics/icons/helium.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        energy_required = 32,
        ingredients = {{"nickel-plate", 3}, {"titanium-plate", 1}, {type="fluid", name="helium", amount=6}},
        result = "nitinol-plate",
        enabled = false,
        result_count = 4
      }
    })
  end
end

if mods["FreightForwarding"] then
  data:extend({
    {
      type = "recipe",
      name = "meteoric-nodule-dredging",
      category = "ff-dredging",
      energy_required = 50,
      ingredients = {},
      results = {{type="item", name="meteoric-nodule", amount_min=100, amount_max=200}},
      show_amount_in_title = false,
      always_show_products = true,
      enabled = false
    },
    {
      type = "recipe",
      name = "meteoric-nodule-washing",
      category = "chemistry",
      energy_required = 15,
      allow_decomposition = false,
      ingredients = {{"meteoric-nodule", 18}, {type="fluid", name="sulfuric-acid", amount=15}},
      results = {{type="item", name="nickel-ore", amount_min=40, amount_max=50}, {type="item", name="iron-ore", amount_min=0, amount_max=8}, {type="item", name="stone", amount_min=0, amount_max=4}, {type="item", name="meteoric-nodule", amount_min=0, amount_max=6}},
      main_product = "nickel-ore",
      enabled = false,
      crafting_machine_tint = {
        primary = {r = 0.0, g = 0.0, b = 1, a = 1.0},
        secondary = {r = 0.8, g = 0.8, b = 1.0, a = 1.0},
        tertiary = {r = 0.0, g = 0.0, b = 1.0, a = 1.0},
        quaternary = {r = 0.7, g = 0.7, b = 1.0, a = 0.5}
      }
    }
  })
end

if mods["248k"] then
  data:extend({
    {
      type = "recipe",
      name = "248k-nickel-atom-hot",
      category = "fu_star_engine_core_crafting_category",
      energy_required = 1,
      ingredients = {{type="fluid", name="fu_protium_heated", amount=30000}},
      results = {{type="fluid", name="248k-nickel-atom-hot", amount=1000}},
      subgroup = "fu_star_engine_subgroup_b",
      enabled=false
    },
    {
      type = "recipe",
      name = "248k-nickel-atom",
      category = "fu_star_engine_cooler_crafting_category",
      energy_required = 1,
      ingredients = {{type="fluid", name="248k-nickel-atom-hot", amount=500}},
      results = {{type="fluid", name="248k-nickel-atom", amount=500}},
      subgroup = "fu_star_engine_subgroup_c",
      enabled=false
    },
    {
      type = "recipe",
      name = "nickel-from-atoms",
      category = "crafting-with-fluid",
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-nickel-atom", amount=500}},
      result = "nickel-plate",
      result_count = 500,
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    },
    {
      type = "recipe",
      name = "invar-from-atoms",
      category = "chemistry",
      energy_required = 6,
      ingredients = {{type="fluid", name="248k-nickel-atom", amount=250}, {type="fluid", name="fu_iron", amount=250}},
      result = "invar-plate",
      result_count = 500,
      subgroup = "fu_star_engine_subgroup_d",
      enabled=false
    }
  })
end
