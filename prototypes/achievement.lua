local misc = require("__pf-functions__/misc")

if mods["space-age"] then
  data:extend(
  {
    {
      type = "produce-per-hour-achievement",
      name = "look-at-this-graph",
      order = "j",
      icon = "__pf-sa-compat__/graphics/achievement/look-at-this-graph.png",
      icon_size = 128,
      item_product = "nickel-bacteria",
      amount = 50000
    }
  })
  if misc.difficulty == 3 then
    data:extend(
      {
        {
          type = "produce-achievement",
          name = "reverse-squiggly",
          order = "k",
          icon = "__IfNickelMk2__/graphics/achievement/reverse-squiggly.png",
          icon_size = 128,
          item_product = "epip-eimert-elbisrever-non",
          limited_to_one_game = false,
          amount = 1
        }
      })    
  end
end