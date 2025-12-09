if mods["space-age"] and not mods["pf-sa-compat"] then
    error("If I Had A Nickel requires PF Space Age compatibility (pf-sa-compat) to work with Space Age. Please download and enable that mod to continue.")
end

require("compat/castra-preparation")
require("prototypes/ore")
require("prototypes/particle")
require("prototypes/items-fluids")
require("prototypes/recipe")
require("prototypes/technology")
require("prototypes/achievement")
require("prototypes/scrap-compat")