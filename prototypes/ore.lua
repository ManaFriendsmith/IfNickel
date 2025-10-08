local resource_autoplace = require("resource-autoplace")

if mods["galdocs-manufacturing"] then return end

local pointilism = settings.startup["ifnickel-old-ore-generation"].value

local nickel_sim = table.deepcopy(data.raw.resource["iron-ore"].factoriopedia_simulation)
nickel_sim.init = string.gsub(nickel_sim.init, "iron", "nickel")


data:extend({
  {
    type = "resource",
    name = "nickel-ore",
    icon = "__IfNickel__/graphics/icons/nickel-ore.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = {"placeable-neutral"},
    order="a-b-y",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "nickel-ore-particle",
      mining_time = 1,
      result = "nickel-ore"
    },
    walking_sound = data.raw.resource["iron-ore"].walking_sound,
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "nickel-ore",
      order = "a-b-e",
      base_density = 6,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = pointilism and 0.7 or 1.1,
      starting_rq_factor_multiplier = 1.1,
      base_spots_per_km2 = pointilism and 8 or 2,
      candidate_spot_count = 22,
      richness_post_multiplier = pointilism and 2 or 1.25
    },
    stage_counts = {30000, 19000, 11000, 5800, 2600, 800, 300, 160},
    stages =
    {
      sheet =
      {
        filename = "__IfNickel__/graphics/entity/nickel-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    map_color = {0.1, 0.1, 0.8},
    mining_visualisation_tint = {r=0.1, g=0.1, b=0.8},
    factoriopedia_simulation = nickel_sim
  },
  {
    type = "autoplace-control",
    category = "resource",
    name = "nickel-ore",
    localised_name = {"", (mods["LunarLandings"] and "[virtual-signal=ll-nauvis] " or "") .. "[entity=nickel-ore] ", {"entity-name.nickel-ore"}},
    richness = true,
    order = "a-ea"
  }
})

data.raw.planet["nauvis"].map_gen_settings.autoplace_controls["nickel-ore"] = {}
data.raw.planet["nauvis"].map_gen_settings.autoplace_settings.entity.settings["nickel-ore"] = {}

if mods["space-age"] then
  local malachite_sim = table.deepcopy(data.raw.resource["coal"].factoriopedia_simulation)
  malachite_sim.init = string.gsub(malachite_sim.init, "coal", "malachite")  
  data:extend({
    {
      type = "resource",
      name = "malachite",
      icon = "__IfNickel__/graphics/icons/malachite.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = {"placeable-neutral"},
      order="b-db",
      tree_removal_probability = 0.8,
      tree_removal_max_distance = 32 * 32,
      minable =
      {
        mining_particle = "malachite-particle",
        mining_time = 1,
        result = "malachite"
      },
      autoplace = {probability_expression = 0},
      walking_sound = data.raw.resource["iron-ore"].walking_sound,
      collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
      selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
      stage_counts = {60000, 38000, 22000, 11600, 5200, 1600, 600, 320},
      stages =
      {
        sheet =
        {
          filename = "__IfNickel__/graphics/entity/malachite.png",
          priority = "extra-high",
          size = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      },
      map_color = {0.22, 0.47, 0.35},
      mining_visualisation_tint = {0.22, 0.47, 0.35},
      factoriopedia_simulation = malachite_sim
    },
    --blatantly copy-pasted from vulcanus coal generation, some values tweaked
    --if it ain't broke don't fix it
    {
      type = "autoplace-control",
      category = "resource",
      name = "vulcanus_malachite",
      --6 years ago i was soooooo annoyed that they used hyphens instead of underscores and it threw me so off balance that i didn't bother trying to mod again for a while
      --now you have to use underscores in this specific circumstance because hyphens get interpreted as minuses in the expression parser
      --vindication!!!!!!
      localised_name = {"", "[entity=malachite] ", {"entity-name.malachite"}},
      richness = true,
      order = "b-ca"
    },
    {
      type = "noise-expression",
      name = "vulcanus_malachite_size",
      expression = "slider_rescale(control:vulcanus_malachite:size, 2)"
    },
    {
      type = "noise-expression",
      name = "vulcanus_malachite_region",
      expression = "max(vulcanus_starting_malachite,\z
                        min(1 - vulcanus_starting_circle,\z
                            vulcanus_place_non_metal_spots(69105, 12, 1,\z
                                                           vulcanus_malachite_size * min(1.2, vulcanus_ore_dist) * 25,\z
                                                           control:vulcanus_malachite:frequency,\z
                                                           vulcanus_ashlands_resource_favorability)))"
    },
    {
      type = "noise-expression",
      name = "vulcanus_malachite_probability",
      expression = "(control:vulcanus_malachite:size > 0) * (1000 * ((1 + vulcanus_malachite_region) * random_penalty_between(0.9, 1, 1) - 1))"
    },
    {
      type = "noise-expression",
      name = "vulcanus_malachite_richness",
      expression = "2.5 * (vulcanus_malachite_region * random_penalty_between(0.9, 1, 1)\z
                    * 30000 * vulcanus_starting_area_multiplier\z
                    * control:vulcanus_malachite:richness / vulcanus_malachite_size)"
    },
    {
      type = "noise-expression",
      name = "vulcanus_starting_malachite",
      expression = "starting_spot_at_angle{ angle = vulcanus_ashlands_angle + 5 * vulcanus_starting_direction,\z
                                            distance = 100 * vulcanus_starting_area_radius,\z
                                            radius = 25 * vulcanus_malachite_size,\z
                                            x_distortion = 0.5 * vulcanus_resource_wobble_x,\z
                                            y_distortion = 0.5 * vulcanus_resource_wobble_y}"
    }
  })
  
  data.raw.planet["vulcanus"].map_gen_settings.autoplace_controls["vulcanus_malachite"] = {}
  data.raw.planet["vulcanus"].map_gen_settings.autoplace_settings.entity.settings["malachite"] = {}
  data.raw.planet["vulcanus"].map_gen_settings.property_expression_names["entity:malachite:richness"] = "vulcanus_malachite_richness"
  data.raw.planet["vulcanus"].map_gen_settings.property_expression_names["entity:malachite:probability"] = "vulcanus_malachite_probability"

  if mods["maraxsis"] then
    --this ore generation is scuffed but I don't know how to make it nicer.
    --macro and micro are the wrong way around but if I swap them the ore doesn't generate. (??????)
    --does not help that the output ranges of the noise functions are not explained in the docs!!!!!
    data:extend({
      {
        type = "autoplace-control",
        category = "resource",
        name = "maraxsis_malachite",
        localised_name = {"", "[entity=malachite] ", {"entity-name.malachite"}},
        richness = true,
        order = "e-01"
      },
      {
        type = "noise-expression",
        name = "maraxsis_malachite_noise",
        expression = "min(1, noise_micro * 1.1) + (noise_macro * 0.75)",
        local_expressions = {
          noise_macro = [[
            multioctave_noise{
                x = x,
                y = y,
                persistence = 0.5,
                seed0 = map_seed,
                seed1 = 666,
                octaves = 3,
                input_scale = var("control:maraxsis_malachite:frequency") * 0.02/var("control:maraxsis_malachite:size"),
                output_scale = 1
            }
        ]],
        noise_micro = "basis_noise{x=x, y=y, seed0=map_seed, seed1=420, input_scale=5, output_scale=1}"
        }
      },
      {
        type = "noise-expression",
        name = "maraxsis_malachite_probability",
        expression = "min(maraxsis_malachite_noise, 1) + exclusion_area + min(trench_proximity * 20, 0.7)",
        local_expressions = {
          trench_proximity = "0.15 - (maraxsis_surface_elevation - " .. maraxsis.TRENCH_ENTRANCE_ELEVATION .. ")",
          exclusion_area = "((maraxsis_surface_elevation - 0.01) < " .. maraxsis.TRENCH_ENTRANCE_ELEVATION .. ") * -500"
        }
      },
      {
        type = "noise-expression",
        name = "maraxsis_malachite_richness",
        expression = "(maraxsis_malachite_probability + maraxsis_malachite_noise) * 1500 * control:maraxsis_malachite:richness"
      }
    })
    
    data.raw.planet["maraxsis"].map_gen_settings.autoplace_controls["maraxsis_malachite"] = {}
    data.raw.planet["maraxsis"].map_gen_settings.autoplace_settings.entity.settings["malachite"] = {}  
    data.raw.planet["maraxsis"].map_gen_settings.property_expression_names["entity:malachite:richness"] = "maraxsis_malachite_richness"
    data.raw.planet["maraxsis"].map_gen_settings.property_expression_names["entity:malachite:probability"] = "maraxsis_malachite_probability"  
  end
end