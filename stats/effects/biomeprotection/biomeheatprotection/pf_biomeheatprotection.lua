function init()
   effect.addStatModifierGroup({{stat = "fireResistance", amount = 0.2}, {stat = "biomeheatImmunity", amount = 1}, {stat = "pf_mildBiomeHeatImmunity", amount = 1}})

   script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end
