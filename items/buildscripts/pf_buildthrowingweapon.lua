require "/scripts/util.lua"
require "/scripts/versioningutils.lua"
require "/items/buildscripts/abilities.lua"

function build(directory, config, parameters, level, seed)
  local configParameter = function(keyName, defaultValue)
    if parameters[keyName] ~= nil then
      return parameters[keyName]
    elseif config[keyName] ~= nil then
      return config[keyName]
    else
      return defaultValue
    end
  end

  if level and not configParameter("fixedLevel", true) then
    parameters.level = level
  end

  -- elemental type
  local elementalType = parameters.elementalType or config.elementalType or "physical"
  replacePatternInData(config, nil, "<elementalType>", elementalType)

  -- calculate damage level multiplier
  config.damageLevelMultiplier = root.evalFunction("weaponDamageLevelMultiplier", configParameter("level", 1))

  config.tooltipFields = {}
  config.tooltipFields.levelLabel = util.round(configParameter("level", 1), 1)
  config.tooltipFields.subtitle = parameters.category
  config.tooltipFields.windupLabel = config.windupTime or 0
  config.tooltipFields.cooldownLabel = config.cooldown or 0
  config.tooltipFields.damagePerShotLabel = util.round(config.projectileConfig.power)
  if elementalType ~= "physical" then
    config.tooltipFields.damageKindImage = "/interface/elements/"..elementalType..".png"
  end

  -- set price
  config.price = (config.price or 0) * root.evalFunction("itemLevelPriceMultiplier", configParameter("level", 1))

  return config, parameters
end
