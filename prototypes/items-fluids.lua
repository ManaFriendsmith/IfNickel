local misc = require("__pf-functions__/misc")
local rm = require("__pf-functions__/recipe-manipulation")
local item_sounds = require("__base__/prototypes/item_sounds")
local space_age_item_sounds = "foo"

data:extend({
    {
        type = "item",
        name = "nickel-ore",
        icon = "__IfNickelMk2__/graphics/icons/nickel-ore.png",
        icon_size = 64,
        mipmap_count = 4,
        pictures = {
          { size = 64, filename = "__IfNickelMk2__/graphics/icons/nickel-ore.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__IfNickelMk2__/graphics/icons/nickel-ore-1.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__IfNickelMk2__/graphics/icons/nickel-ore-2.png", scale = 0.5, mipmap_count = 4 },
          { size = 64, filename = "__IfNickelMk2__/graphics/icons/nickel-ore-3.png", scale = 0.5, mipmap_count = 4 }
        },
        subgroup = "raw-resource",
        order = "fb", -- f = copper
        color_hint = { text = "N" },
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2*kg
      },
      {
        type = "item",
        name = "nickel-plate",
        icon = "__IfNickelMk2__/graphics/icons/nickel-plate.png",
        subgroup = "raw-material",
        order = "a[smelting]-bc",
        color_hint = { text = "N" },
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 1*kg
      },
      {
        type = "item",
        name = "invar-precursor",
        icon = "__IfNickelMk2__/graphics/icons/invar-precursor.png",
        subgroup = "raw-resource",
        order = "fbb",
        color_hint = { text = "I" },
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 1*kg
      },
      {
        type = "item",
        name = "invar-plate",
        icon = "__IfNickelMk2__/graphics/icons/invar-plate.png",
        subgroup = "raw-material",
        order = "a[smelting]-bd",
        color_hint = { text = "I" },
        inventory_move_sound = item_sounds.metal_small_inventory_move,
        pick_sound = item_sounds.metal_small_inventory_pickup,
        drop_sound = item_sounds.metal_small_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 2.5*kg
      },
      {
        type = "item",
        name = "electric-motor",
        icon = "__IfNickelMk2__/graphics/icons/electric-motor.png",
        subgroup = "intermediate-product",
        order = "b[circuits]-1",
        inventory_move_sound = item_sounds.inserter_inventory_move,
        pick_sound = item_sounds.inserter_inventory_pickup,
        drop_sound = item_sounds.inserter_inventory_move,
        stack_size = 100,
        default_import_location = "nauvis",
        weight = 1*kg
      },
      {
        type = "item",
        name = "high-pressure-valve",
        icon = "__IfNickelMk2__/graphics/icons/high-pressure-valve.png",
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-2",
        inventory_move_sound = item_sounds.fluid_inventory_move,
        pick_sound = item_sounds.fluid_inventory_pickup,
        drop_sound = item_sounds.fluid_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2.5*kg
      }
})

if mods["space-age"] then
    space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
    data:extend({
        {
            type = "item",
            name = "malachite",
            icon = "__IfNickelMk2__/graphics/icons/malachite.png",
            icon_size = 64,
            mipmap_count = 4,
            pictures = {
              { size = 64, filename = "__IfNickelMk2__/graphics/icons/malachite.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__IfNickelMk2__/graphics/icons/malachite-1.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__IfNickelMk2__/graphics/icons/malachite-2.png", scale = 0.5, mipmap_count = 4 },
              { size = 64, filename = "__IfNickelMk2__/graphics/icons/malachite-3.png", scale = 0.5, mipmap_count = 4 }
            },
            subgroup = "raw-resource",
            order = "f]", --reaching new lows
            color_hint = { text = "M" },
            inventory_move_sound = item_sounds.resource_inventory_move,
            pick_sound = item_sounds.resource_inventory_pickup,
            drop_sound = item_sounds.resource_inventory_move,
            stack_size = 50,
            default_import_location = "vulcanus",
            weight = 2*kg
        },
        {
            type = "fluid",
            name = "molten-nickel",
            icon = "__pf-sa-compat__/graphics/icons/molten-nickel.png",
            icon_size = 64,
            mipmap_count = 4,
            subgroup = "fluid",
            order = "b[new-fluid]-b[vulcanus]-d",
            default_temperature = 1450,
            max_temperature = 2000,
            base_color = {0, 0, 0.9, 1},
            flow_color = {0.3, 0.3, 1, 1},
            visualization_color = {0, 0, 1, 1},
            auto_barrel = false
        },
        {
            type = "item",
            name = "nickel-bacteria",
            icon = "__pf-sa-compat__/graphics/icons/nickel-bacteria.png",
            icon_size = 64,
            mipmap_count = 4,
            pictures = {
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/nickel-bacteria.png", scale = 0.5, mipmap_count = 4 },
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/nickel-bacteria-1.png", scale = 0.5, mipmap_count = 4 },
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/nickel-bacteria-2.png", scale = 0.5, mipmap_count = 4 },
                { size = 64, filename = "__pf-sa-compat__/graphics/icons/nickel-bacteria-3.png", scale = 0.5, mipmap_count = 4 }
              },
            subgroup = "agriculture-processes",
            order = "b[agriculture]-db",
            inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
            pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
            drop_sound = space_age_item_sounds.agriculture_inventory_move,
            color_hint = { text = "N" },
            stack_size = 50,
            default_import_location = "gleba",
            weight = 1*kg,
            spoil_ticks = 1 * minute,
            spoil_result = "nickel-ore"
        }
    })

    --reserve deep blue for nickel.
    data.raw.fluid["molten-iron"].base_color = {0.4, 0.5, 1}
    data.raw.fluid["molten-iron"].flow_color = {0.6, 0.7, 1}
    data.raw.fluid["molten-iron"].visualization_color = {0.6, 0.8, 1}
end

if misc.difficulty < 2 then
    return
end

if misc.difficulty == 3 or not mods["space-age"] then
  data:extend({
    {
      type = "item",
      name = "cooling-fan",
      icon = "__IfNickelMk2__/graphics/icons/cooling-fan.png",
      subgroup = "intermediate-product",
      order = "b[circuits]-2",
      inventory_move_sound = item_sounds.plastic_inventory_move,
      pick_sound = item_sounds.plastic_inventory_pickup,
      drop_sound = item_sounds.plastic_inventory_move,
      stack_size = 50,
      default_import_location = "nauvis",
      weight = 1*kg
    }
  })
end

data:extend({
    {
      type = "item",
      name = "electromagnetic-coil",
      icon = "__IfNickelMk2__/graphics/icons/electromagnetic-coil.png",
      subgroup = "intermediate-product",
      order = "b[circuits]-0",
      inventory_move_sound = item_sounds.electric_small_inventory_move,
      pick_sound = item_sounds.electric_small_inventory_pickup,
      drop_sound = item_sounds.electric_small_inventory_move,
      stack_size = 100,
      default_import_location = "nauvis",
      weight = 1*kg
  },
  {
    type = "item",
    name = "fluid-regulator",
    icon = "__IfNickelMk2__/graphics/icons/fluid-regulator.png",
    subgroup = "intermediate-product",
    order = "c[advanced-intermediates]-2a",
    inventory_move_sound = item_sounds.fluid_inventory_move,
    pick_sound = item_sounds.fluid_inventory_pickup,
    drop_sound = item_sounds.fluid_inventory_move,
    stack_size = 50,
    default_import_location = "nauvis",
    weight = 2.5*kg
  },
  {
    type = "item",
    name = "motorized-arm",
    icon = "__IfNickelMk2__/graphics/icons/motorized-arm.png",
    subgroup = "intermediate-product",
    order = "c[advanced-intermediates]-2b",
    inventory_move_sound = item_sounds.inserter_inventory_move,
    pick_sound = item_sounds.inserter_inventory_pickup,
    drop_sound = item_sounds.inserter_inventory_move,
    stack_size = 50,
    default_import_location = "nauvis",
    weight = 2.5*kg
  },
  {
    type = "item",
    name = "gimbaled-rocket-engine",
    icon = "__IfNickelMk2__/graphics/icons/gimbaled-rocket-engine.png",
    subgroup = "intermediate-product",
    order = "d[rocket-parts]-c",
    inventory_move_sound = item_sounds.flamethrower_inventory_move,
    pick_sound = item_sounds.explosives_inventory_move,
    drop_sound = item_sounds.flamethrower_inventory_move,
    stack_size = mods["LunarLandings"] and 50 or 20,
    default_import_location = "nauvis",
    weight = 5*kg
  }
})

if mods["space-age"] then
  data:extend({
    {
      type = "item-subgroup",
      name = "original-dint",
      group = "intermediate-products",
      order = "nooooooooooooooooo"
    },
    {
      type = "item",
      name = "stem-cells",
      icon = "__IfNickelMk2__/graphics/icons/stem-cells.png",
      subgroup = "original-dint",
      order = "a",
      inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
      pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
      drop_sound = space_age_item_sounds.agriculture_inventory_move,
      stack_size = 50,
      default_import_location = "gleba",
      weight = 1*kg,
      spoil_ticks = 10 * minute,
      spoil_result = "spoilage"
    },
    {
      type = "item",
      name = "skeletal-bioculture",
      icon = "__IfNickelMk2__/graphics/icons/skeletal-bioculture.png",
      subgroup = "original-dint",
      order = "c",
      inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
      pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
      drop_sound = space_age_item_sounds.agriculture_inventory_move,
      stack_size = 50,
      default_import_location = "gleba",
      weight = 1*kg,
      spoil_ticks = 5 * minute,
      spoil_result = mods["BrassTacksMk2"] and "linkages" or "iron-stick"
    },
    {
      type = "item",
      name = "musculoskeletal-bioculture",
      icon = "__IfNickelMk2__/graphics/icons/musculoskeletal-bioculture.png",
      subgroup = "original-dint",
      order = "d",
      inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
      pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
      drop_sound = space_age_item_sounds.agriculture_inventory_move,
      stack_size = 50,
      default_import_location = "gleba",
      weight = 2*kg,
      spoil_ticks = 5 * minute,
      spoil_result = "motorized-arm"
    },
    {
      type = "item",
      name = "vascular-bioculture",
      icon = "__IfNickelMk2__/graphics/icons/vascular-bioculture.png",
      subgroup = "original-dint",
      order = "e",
      inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
      pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
      drop_sound = space_age_item_sounds.agriculture_inventory_move,
      stack_size = 50,
      default_import_location = "gleba",
      weight = 1*kg,
      spoil_ticks = 5 * minute,
      spoil_result = data.raw.item["galvanized-tubing"] and "galvanized-tubing" or "pipe"
    },
    {
      type = "item",
      name = "cardiac-bioculture",
      icon = "__IfNickelMk2__/graphics/icons/cardiac-bioculture.png",
      subgroup = "original-dint",
      order = "f",
      inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
      pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
      drop_sound = space_age_item_sounds.agriculture_inventory_move,
      stack_size = 50,
      default_import_location = "gleba",
      weight = 2*kg,
      spoil_ticks = 5 * minute,
      spoil_result = "high-pressure-valve"
    }
  })

  if mods["BrassTacksMk2"] then
    data:extend({
      {
        type = "item",
        name = "vestibular-bioculture",
        icon = "__IfNickelMk2__/graphics/icons/vestibular-bioculture.png",
        subgroup = "original-dint",
        order = "g",
        inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
        pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
        drop_sound = space_age_item_sounds.agriculture_inventory_move,
        stack_size = 50,
        default_import_location = "gleba",
        weight = 2*kg,
        spoil_ticks = 5 * minute,
        spoil_result = "gyro"
      }
    })
  end
end

if mods["LunarLandings"] then
  data:extend({
      {
        type = "item",
        name = "gimbaled-rocket-engine-packed",
        localised_name = { "item-name.ll-packed-rocket-ingredient", {"item-name.gimbaled-rocket-engine"} },
        icon = "__IfNickelMk2__/graphics/icons/gimbaled-rocket-engine-packed.png",
        subgroup = "ll-packed-rocket-ingredients",
        order = "z",
        inventory_move_sound = item_sounds.flamethrower_inventory_move,
        pick_sound = item_sounds.explosives_inventory_move,
        drop_sound = item_sounds.flamethrower_inventory_move,
        stack_size = 10,
        default_import_location = "nauvis",
        weight = 25*kg
     }
  })
end

if misc.difficulty == 2 then
  return
end

data:extend({
  {
    type = "item",
    name = "ambifacient-lunar-waneshaft",
    icon = "__IfNickelMk2__/graphics/icons/ambifacient-lunar-waneshaft.png",
    subgroup = "intermediate-product",
    order = "c[advanced-intermediates]-a0",
    inventory_move_sound = item_sounds.metal_small_inventory_move,
    pick_sound = item_sounds.metal_small_inventory_pickup,
    drop_sound = item_sounds.metal_small_inventory_move,
    stack_size = 100,
    default_import_location = "nauvis",
    weight = 3.33*kg
  },
  {
    type = "item",
    name = "grabber",
    icon = "__IfNickelMk2__/graphics/icons/grabber.png",
    subgroup = "intermediate-product",
    order = "c[advanced-intermediates]-a0",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 50,
    default_import_location = "nauvis",
    weight = 5*kg
  }
})

if mods["space-age"] and mods["bztitanium"] then
  data:extend({
    {
      type = "item",
      name = "nitinol-precursor",
      icon = "__IfNickelMk2__/graphics/icons/nitinol-precursor.png",
      subgroup = "raw-resource",
      order = "fbc",
      inventory_move_sound = item_sounds.resource_inventory_move,
      pick_sound = item_sounds.resource_inventory_pickup,
      drop_sound = item_sounds.resource_inventory_move,
      stack_size = 50,
      default_import_location = "nauvis",
      weight = 1*kg
    },
    {
      type = "item",
      name = "nitinol-plate",
      icon = "__IfNickelMk2__/graphics/icons/nitinol-plate.png",
      subgroup = "raw-material",
      order = "a[smelting]-be",
      inventory_move_sound = item_sounds.metal_small_inventory_move,
      pick_sound = item_sounds.metal_small_inventory_pickup,
      drop_sound = item_sounds.metal_small_inventory_move,
      stack_size = 100,
      canonical_cost = 5,
      default_import_location = "nauvis",
      weight = 5*kg
    },
    {
      type = "item",
      name = "self-regulating-valve",
      icon = "__IfNickelMk2__/graphics/icons/self-regulating-valve.png",
      subgroup = "intermediate-product",
      order = "c[advanced-intermediates]-2a1",
      inventory_move_sound = item_sounds.fluid_inventory_move,
      pick_sound = item_sounds.fluid_inventory_pickup,
      drop_sound = item_sounds.fluid_inventory_move,
      stack_size = 50,
      default_import_location = "nauvis",
      weight = 5*kg
    }
  })
end

if mods["space-age"] then
  local sludge_pickup = {filename = "__base__/sound/creatures/spitter-spit-end-2.ogg", volume=0.6}
  local sludge_drop = {filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg", volume=0.7}
  data:extend({
    {
      type = "item",
      name = "non-reversible-tremie-pipe",
      icon = "__IfNickelMk2__/graphics/icons/non-reversible-tremie-pipe.png",
      subgroup = "intermediate-product",
      order = "c[advanced-intermediates]-2a2",
      inventory_move_sound = item_sounds.fluid_inventory_move,
      pick_sound = item_sounds.fluid_inventory_pickup,
      drop_sound = item_sounds.fluid_inventory_move,
      stack_size = 50,
      auto_recycle = false,
      default_import_location = "gleba",
      weight = 10*kg,
    },
    {
      type = "item",
      name = "epip-eimert-elbisrever-non",
      icon = "__IfNickelMk2__/graphics/icons/epip-eimert-elbisrever-non.png",
      inventory_move_sound = item_sounds.fluid_inventory_move,
      pick_sound = item_sounds.fluid_inventory_pickup,
      drop_sound = item_sounds.fluid_inventory_move,
      stack_size = 50,
      default_import_location = "gleba",
      weight = 10*kg,
      spoil_ticks = 20 * 60,
      auto_recycle = false,
      hidden_in_factoriopedia = true,
      hidden = true,
      spoil_to_trigger_result =
      {
        items_per_trigger = 1,
        trigger =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-entity",
                entity_name = "lightning",
                affects_target = true,
                show_in_tooltip = true,
                as_enemy = true,
                find_non_colliding_position = false,
                offset_deviation = {{-5, -5}, {5, 5}},
            }
          }
        }
      }
    }
   },
    {
      type = "item",
      name = "mutagenic-sludge",
      icon = "__IfNickelMk2__/graphics/icons/mutagenic-sludge.png",
      subgroup = "original-dint",
      order = "y",
      inventory_move_sound = sludge_drop,
      pick_sound = sludge_pickup,
      drop_sound = sludge_drop,
      stack_size = 1,
      flags = {"not-stackable"},
      default_import_location = "gleba",
      weight = 100*kg,
      auto_recycle = false,
      spoil_ticks = 3 * minute,
      spoil_result = "bubbling-mutagenic-sludge",
    },
    {
      type = "item",
      name = "bubbling-mutagenic-sludge",
      icon = "__IfNickelMk2__/graphics/icons/bubbling-mutagenic-sludge.png",
      subgroup = "original-dint",
      order = "z",
      inventory_move_sound = sludge_drop,
      pick_sound = sludge_pickup,
      drop_sound = sludge_drop,
      stack_size = 1,
      flags = {"not-stackable"},
      default_import_location = "gleba",
      weight = 100*kg,
      auto_recycle = false,
      spoil_ticks = 30 * second,
      spoil_to_trigger_result =
      {
        items_per_trigger = 1,
        trigger =
        {
          type = "direct",
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-entity",
                entity_name = "big-stomper-pentapod",
                affects_target = true,
                show_in_tooltip = true,
                as_enemy = true,
                offset_deviation = {{-5, -5}, {5, 5}},
                }
              }
            }
          }
        }
      }
  })
end