-- Configuration
local ALTERNATIVE_USER_ID = <ALTERNATIVE_USER_ID>
local ALTERNATIVE_USER_NAME = "<ALTERNATIVE_QUICK_APP_USER_NAME>"

local SENSOR_IDS = { <SENSOR_ID_1>, <SENSOR_ID_2>, ... }
local PRIORITY_WARNING_ID = <PRIORITY_WARNING_SENSOR_ID>

local PUSHOVER_QUICK_APP_ID = <PUSHOVER_QA_ID>
local PUSHOVER_PRIORITY = "-1"
local PUSHOVER_TTL = "43200"

local TEXT_LIGHTS = "Lights"
local TEXT_DOORS_WINDOWS = "Open doors/windows"
local TEXT_NONE = "none"

local user = nil
if sourceTrigger.id == ALTERNATIVE_USER_ID then
    user = ALTERNATIVE_USER_NAME
end

local lightIds = hub.getDevicesID(
  {
    interfaces = {
      "light",
    },
    properties = {
      dead = false,
    },
    enabled = true,
    visible = true
  }
);

local reportData = {}
local notFound = true
table.insert(reportData, "<b>" .. TEXT_LIGHTS .. "</b>")

local lightsByRoom = {}
for _, deviceId in ipairs(lightIds) do
    local deviceValue = hub.getValue(deviceId, "value")
    if (type(deviceValue) == "number" and deviceValue > 0)
    or (type(deviceValue) == "boolean" and deviceValue) then
        local roomName = hub.getRoomNameByDeviceID(deviceId)
        local deviceName = hub.getName(deviceId)
        if not lightsByRoom[roomName] then
            lightsByRoom[roomName] = {}
        end
        table.insert(lightsByRoom[roomName], deviceName)
        notFound = false
    end
end

for roomName, devices in pairs(lightsByRoom) do
    table.insert(reportData, "💡 " .. roomName .. ":")
    for _, deviceName in ipairs(devices) do
        table.insert(reportData, "- " .. deviceName)
    end
end

if notFound then
    table.insert(reportData, TEXT_NONE)
end

notFound = true
table.insert(reportData, "<b>" .. TEXT_DOORS_WINDOWS .. "</b>")
for i = 1, # SENSOR_IDS do
    local deviceValue = hub.getValue(SENSOR_IDS[i], "value")
    if deviceValue then
        local deviceName = hub.getName(SENSOR_IDS[i])
        if SENSOR_IDS[i] == PRIORITY_WARNING_ID then
            table.insert(reportData, "⚠️ " .. deviceName)
        else
            table.insert(reportData, "🪟 " .. deviceName)
        end
        notFound = false
    end
end

if notFound then
    table.insert(reportData, TEXT_NONE)
end

hub.call(PUSHOVER_QUICK_APP_ID, "send", table.concat(reportData, "\n"), {
    user = user,
    priority = PUSHOVER_PRIORITY,
    ttl = PUSHOVER_TTL,
    html = 1,
})
