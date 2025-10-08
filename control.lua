script.on_configuration_changed(
  function()
    for redacted, theForce in pairs(game.forces) do
      for k, v in pairs(theForce.technologies) do
        if v.researched then
          for k2, v2 in pairs(v.prototype.effects) do
            if v2.recipe then
              theForce.recipes[v2.recipe].enabled = true
            end
          end
        end
      end
    end
  end
)