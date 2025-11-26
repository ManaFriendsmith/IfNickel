local rr = require("__pf-functions__/rude-renaming")

if not mods["castra"] then return end

--note: do NOT rename things beyond what is strictly necessary to avoid ID collisions.
--the localised name can be changed later.

rr.Convert("item", "nickel-plate", "cst-nickel-plate")

--now everything that references these
rr.Convert("recipe", "nickel-extraction")
rr.Convert("recipe", "nickel-sulfide-reduction")
rr.Convert("recipe", "advanced-nickel-processing")

rr.Convert("recipe", "firearm-magazine-nickel")
rr.Convert("recipe", "battery-nickel")
rr.Convert("recipe", "tank-nickel")
rr.Convert("recipe", "forge")
rr.Convert("technology", "forge")

rr.Convert("recipe", "military-transport-belt")
rr.Convert("recipe", "military-underground-belt")
rr.Convert("recipe", "military-splitter")
rr.Convert("recipe", "slowdown-capsule-sulfur")
rr.Convert("recipe", "poison-capsule-sulfur")
rr.Convert("recipe", "lithium-battery")
rr.Convert("recipe", "carbon-fiber-wall")
rr.Convert("recipe", "combat-roboport")

rr.Confirm()
rr.Clear()