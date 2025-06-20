-- Configuration
local deviceId = <LED_ID>

local deviceValue = hub.getValue(deviceId, "value")
local prevAction = hub.getSceneVariable("prevAction")
if deviceValue >= 90 then
  hub.call(deviceId, "startLevelDecrease")
  hub.setSceneVariable("prevAction", 0)
elseif deviceValue <= 10 or prevAction == 0 then
  hub.call(deviceId, "startLevelIncrease")
  hub.setSceneVariable("prevAction", 1)
else
  hub.call(deviceId, "startLevelDecrease")
  hub.setSceneVariable("prevAction", 0)
end
