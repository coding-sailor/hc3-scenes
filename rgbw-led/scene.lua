-- Configuration
local deviceId = <LED_ID>

local colors = {
  { type = 0, r = 0, g = 0, b = 0, w = 255 },
  { type = 0, r = 0, g = 255, b = 255, w = 0 },
  { type = 0, r = 255, g = 40, b = 30, w = 0 },
  { type = 1, id = 4}
}

function applyStep(currentStep)
  local color = colors[currentStep]
  if color.type == 0 then
    hub.call(deviceId, "setColor", color.r, color.g, color.b, color.w)
  else
    hub.call(deviceId, "startProgram", color.id)
  end
  hub.call(deviceId, "turnOn")
  hub.setSceneVariable("step", currentStep)
end

local deviceValue = hub.getValue(deviceId, "value")
local step = hub.getSceneVariable("step")
if step == nil or step > #colors then
  step = 1
end

if sourceTrigger.value == 24 then -- 2 clicks
  local isItDarkOutside = (hub.getGlobalVariable("is_it_dark_outside") == "true")
  if deviceValue <= 0 then
    applyStep(1)
    hub.call(deviceId, "setValue", 100)
  elseif deviceValue >= 60 then
    hub.call(deviceId, "setValue", 30)
  elseif deviceValue >= 10 and isItDarkOutside then
    hub.call(deviceId, "setValue", 2)
  else
    hub.call(deviceId, "setValue", 100)
  end
elseif sourceTrigger.value == 25 then -- 3 clicks
  step = step + 1
  if step > #colors then
    step = 1
  end
  applyStep(step)
else -- 1 click or default
  if deviceValue <= 0 then
    local defaultLightValue = hub.getGlobalVariable("default_light_value")
    applyStep(step)
    hub.call(deviceId, "setValue", defaultLightValue)
  else
    hub.call(deviceId, "turnOff")
  end
end
