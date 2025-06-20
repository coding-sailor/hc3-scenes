-- Configuration
local deviceId = <DIMMER_ID>

local deviceValue = hub.getValue(deviceId, "value")
local isItDarkOutside = (hub.getGlobalVariable("is_it_dark_outside") == "true")
if deviceValue >= 70 then
    hub.call(deviceId, "setValue", 30)
elseif deviceValue >= 10 and isItDarkOutside then
    hub.call(deviceId, "setValue", 2)
else
    hub.call(deviceId, "setValue", 100)
end
