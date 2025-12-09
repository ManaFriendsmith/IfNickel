local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if not mods["scrap-industry"] then
    return
end

local item_sounds = require("__base__/prototypes/item_sounds")

data:extend({
      {
        type = "item",
        name = "nickel-scrap",
        icon = "__IfNickelMk2__/graphics/icons/nickel-scrap.png",
        icon_size = 64,
        subgroup = "production-scrap",
        order = "a[material]-ea[nickel]",
        color_hint = { text = "N" },
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 1,
        weight = 2*kg
      },
      {
        type = "item",
        name = "invar-scrap",
        icon = "__IfNickelMk2__/graphics/icons/invar-scrap.png",
        icon_size = 64,
        subgroup = "production-scrap",
        order = "a[material]-eb[invar]",
        color_hint = { text = "I" },
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        canonical_cost = 1,
        weight = 2*kg
      },
      {
        type = "recipe",
        name = "nickel-plate-from-scrap",
        icons = {
            {
                icon = "__IfNickelMk2__/graphics/icons/nickel-scrap.png",
                icon_size = 64,
                shift = {-4, -4}
            },
            {
                icon = "__IfNickelMk2__/graphics/icons/nickel-plate.png",
                icon_size = 64,
                shift = {4, 4}
            }
        },
        hide_from_player_crafting = true,
        subgroup = "production-scrap",
        order = "b[smelting]-ea[nickel]",
        category = "smelting",
        energy_required = 3.2,
        allow_productivity = true,
        enabled = true,
        ingredients = {
            {type="item", name="nickel-scrap", amount=2}
        },
        results = {
            {type="item", name="nickel-plate", amount=1}
        }
      },
      {
        type = "recipe",
        name = "invar-plate-from-scrap",
        icons = {
            {
                icon = "__IfNickelMk2__/graphics/icons/invar-scrap.png",
                icon_size = 64,
                shift = {-4, -4}
            },
            {
                icon = "__IfNickelMk2__/graphics/icons/invar-plate.png",
                icon_size = 64,
                shift = {4, 4}
            }
        },
        hide_from_player_crafting = true,
        subgroup = "production-scrap",
        order = "b[smelting]-eb[invar]",
        category = "smelting",
        energy_required = 6.4,
        allow_productivity = true,
        enabled = true,
        ingredients = {
            {type="item", name="invar-scrap", amount=8}
        },
        results = {
            {type="item", name="invar-plate", amount=1}
        }
      }
})

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "molten-nickel-from-scrap",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/nickel-scrap.png",
                    icon_size = 64,
                    shift = {-4, -4}
                },
                {
                    icon = "__pf-sa-compat__/graphics/icons/molten-nickel.png",
                    icon_size = 64,
                    shift = {4, 4}
                }
            },
            hide_from_player_crafting = true,
            subgroup = "production-scrap",
            order = "e[melting]-ea[molten-nickel]",
            category = "metallurgy",
            energy_required = 64,
            allow_productivity = true,
            enabled = false,
            ingredients = {
                {type="item", name="nickel-scrap", amount=50},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-nickel", amount=200}
            }
        },
        {
            type = "recipe",
            name = "invar-liquation",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/invar-scrap.png",
                    icon_size = 64,
                    shift = {-5, -5}
                },
                {
                    icon = "__space-age__/graphics/icons/fluid/molten-iron.png",
                    icon_size = 64,
                    scale = 0.33,
                    shift = {-4, 5}
                },
                {
                    icon = "__pf-sa-compat__/graphics/icons/molten-nickel.png",
                    icon_size = 64,
                    scale = 0.33,
                    shift = {5, 5}
                }
            },
            hide_from_player_crafting = true,
            subgroup = "production-scrap",
            order = "e[melting]-eb[molten-invar]",
            category = "metallurgy",
            energy_required = 64,
            allow_productivity = true,
            enabled = false,
            ingredients = {
                {type="item", name="invar-scrap", amount=50},
                {type="item", name="calcite", amount=1}
            },
            results = {
                {type="fluid", name="molten-nickel", amount=100},
                {type="fluid", name="molten-iron", amount=100}
            }
        }
    })

    if data.raw.item["nitinol-plate"] then
        data:extend({
            {
                type = "item",
                name = "nitinol-scrap",
                icon = "__IfNickelMk2__/graphics/icons/nitinol-scrap.png",
                icon_size = 64,
                subgroup = "production-scrap",
                order = "a[material]-ec[nitinol]",
                color_hint = { text = "N" },
                inventory_move_sound = item_sounds.resource_inventory_move,
                pick_sound = item_sounds.resource_inventory_pickup,
                drop_sound = item_sounds.resource_inventory_move,
                stack_size = 200,
                default_import_location = "nauvis",
                canonical_cost = 1,
                weight = 0.25*kg
            },
            {
                type = "recipe",
                name = "nitinol-plate-from-scrap",
                icons = {
                    {
                        icon = "__IfNickelMk2__/graphics/icons/nitinol-scrap.png",
                        icon_size = 64,
                        shift = {-4, -4}
                    },
                    {
                        icon = "__IfNickelMk2__/graphics/icons/nitinol-plate.png",
                        icon_size = 64,
                        shift = {4, 4}
                    }
                },
                hide_from_player_crafting = true,
                subgroup = "production-scrap",
                order = "b[smelting]-ec[nitinol]",
                category = "smelting",
                energy_required = 8,
                allow_productivity = true,
                enabled = true,
                ingredients = {
                    {type="item", name="nitinol-scrap", amount=30}
                },
                results = {
                    {type="item", name="nitinol-plate", amount=1}
                }
            },
            {
                type = "recipe",
                name = "nitinol-plate-from-scrap-in-space",
                icons = {
                    {
                        icon = "__IfNickelMk2__/graphics/icons/nitinol-scrap.png",
                        icon_size = 64,
                        shift = {-4, -4}
                    },
                    {
                        icon = "__IfNickelMk2__/graphics/icons/nitinol-plate.png",
                        icon_size = 64,
                        shift = {4, 4}
                    }
                },
                hide_from_player_crafting = true,
                subgroup = "production-scrap",
                order = "e[melting]-ed[nitinol]",
                category = "metallurgy",
                energy_required = 3.2,
                allow_productivity = true,
                surface_conditions = {
                    {
                        property = "pressure",
                        min = 0,
                        max = 0
                    }
                },
                enabled = false,
                ingredients = {
                    {type="item", name="nitinol-scrap", amount=4},
                    {type="fluid", name="vacuum", amount=1}
                },
                results = {
                    {type="item", name="nitinol-plate", amount=2}
                }
            },
        })
    end
end

if settings.startup["scrap-industry-mech"].value then
    data:extend({
        {
            type = "item",
            name = "motor-scrap",
            icon = "__IfNickelMk2__/graphics/icons/motor-scrap.png",
            icon_size = 64,
            subgroup = "production-scrap",
            order = "c[product]-ca[motor]",
            inventory_move_sound = item_sounds.metal_small_inventory_move,
            pick_sound = item_sounds.metal_small_inventory_pickup,
            drop_sound = item_sounds.metal_small_inventory_move,
            stack_size = 50,
            default_import_location = "nauvis",
            canonical_cost = 1,
            weight = 2*kg
        },
        {
            type = "recipe",
            name = "sort-motor-scrap",
            icons = {
                {
                    icon = "__IfNickelMk2__/graphics/icons/motor-scrap.png",
                    icon_size = 64,
                    shift = {0, -4}
                },
                {
                    icon = "__IfNickelMk2__/graphics/icons/electromagnetic-coil.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {8, 8}
                },
                {
                    icon = "__base__/graphics/icons/copper-cable.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {-8, 8}
                }
            },
            hide_from_player_crafting = true,
            subgroup = "intermediate-product",
            order = "a[basic-intermediate]-b[copper-cable]-a[scrap]",
            category = "crafting",
            energy_required = 4,
            allow_productivity = true,
            enabled = true,
            ingredients = {
                {type="item", name="motor-scrap", amount=4}
            },
            results = {
                {type="item", name="copper-cable", amount=1, probability=0.5},
                {type="item", name="mech-scrap", amount=1},
                {type="item", name="nickel-scrap", amount_min=1, amount_max=3}
            }
        }
    })
    if misc.difficulty == 3 then
        rm.AddProduct("sort-motor-scrap", {type="item", name="electromagnetic-coil", amount=1, probability=0.5})
    else
        rm.AddProduct("sort-motor-scrap", {type="item", name="circuit-scrap", amount=1, probability=0.5})
    end
else
    data:extend({
        {
            type = "recipe",
            name = "electric-motor-from-scrap",
            icons = {
                {
                    icon = "__scrap-industry__/graphics/icons/circuit-scrap.png",
                    icon_size = 64,
                    shift = {-4, -4}
                },
                {
                    icon = "__IfNickelMk2__/graphics/icons/electric-motor.png",
                    icon_size = 64,
                    shift = {4, 4}
                }
            },
            hide_from_player_crafting = true,
            category = mods["space-age"] and "electronics" or "crafting",
            energy_required = 2.5,
            allow_productivity = true,
            enabled = false,
            ingredients = misc.difficulty == 3 and {
                {type="item", name="nickel-plate", amount=3},
                {type="item", name="circuit-scrap", amount=4},
                {type="item", name="iron-gear-wheel", amount=1},
            } or {
                {type="item", name="nickel-plate", amount=2},
                {type="item", name="circuit-scrap", amount=2}
            },
            results = {
                {type="fluid", name="electric-motor", amount=1}
            }
        }
    })
end
