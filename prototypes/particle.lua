
local function createOreParticle(ore, path, variants)
  local particle = {
    type="optimized-particle",
    name= ore .. "-particle",
    life_time=180,
    pictures = {},
    shadows = {}
  }
  for count = 1,variants,1 do
    table.insert(particle.pictures,
    {
        --so long as the files are copied from vanilla and mass-renamed with the ore name changed this pattern should hold
        filename = path .. "/" .. ore .. "-particle-" .. count .. ".png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
      })
  end
  for count = 1,variants,1 do
    table.insert(particle.shadows,
    {
        filename = path .. "/" .. ore .. "-particle-shadow-" .. count .. ".png",
        priority = "extra-high",
        width = 32,
        height = 32,
        frame_count = 1,
        scale = 0.5
    })
  end
  return particle
end

data:extend({
  createOreParticle("nickel-ore", "__IfNickelMk2__/graphics/particle", 4)
})

if mods["space-age"] then
  data:extend({
    createOreParticle("malachite", "__IfNickelMk2__/graphics/particle", 4)
  })
end