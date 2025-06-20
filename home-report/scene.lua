-- Configuration
local pushoverToken = "<TOKEN>"
local defaultPushoverUser = "<DEFAULT_PUSHOVER_USER>"
local alternativePushoverUser = "<ALTERNATIVE_PUSHOVER_USER>"
local alternativeUserId = <ALTERNATIVE_USER_ID>
local sceneId = "<SCENE_ID>"
local sensorIds = { <SENSOR_ID_1>, <SENSOR_ID_2>, ... }
local priorityWarningId = <PRIORITY_WARNING_SENSOR_ID>

function sendMessage(user, message)
    local http = net.HTTPClient()
    local request = {
                    token   = pushoverToken,
                    user    = user,
                    priority   = "-1",
                    ttl     = "43200",
                    html    = 1,
                    message = message
                    }

    local data_str = {}
    for k,v in pairs(request) do
        table.insert(data_str, tostring(k) .. "=" .. tostring(v))
    end

    http:request("https://api.pushover.net/1/messages.json", {
        options = {
            method = "POST",
            data = table.concat(data_str, "&")
        },
        success = function(response)
            if response.status ~= 200 then
                hub.error(sceneId, response.status, response.data)
            end
        end,
        error = function(message)
            hub.error(sceneId, message)
        end
    })
end

local user = defaultPushoverUser
if sourceTrigger.id == alternativeUserId then
    user = alternativePushoverUser
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

local report_data = {}
local notFound = true
table.insert(report_data, "<b>Lights</b>")
for _, deviceId in ipairs(lightIds) do
    local deviceValue = hub.getValue(deviceId, "value")
    if (type(deviceValue) == "number" and deviceValue > 0)
    or (type(deviceValue) == "boolean" and deviceValue) then
        local roomName = hub.getRoomNameByDeviceID(deviceId)
        local deviceName = hub.getName(deviceId)
        table.insert(report_data, "💡\t" .. roomName .. ": " .. deviceName)
        notFound = false
    end
end

if notFound then
    table.insert(report_data, "none")
end

notFound = true
table.insert(report_data, "<b>Open doors/windows</b>")
for i = 1, # sensorIds do
    local deviceValue = hub.getValue(sensorIds[i], "value")
    if deviceValue then
        local deviceName = hub.getName(sensorIds[i])
        if sensorIds[i] == priorityWarningId then
            table.insert(report_data, "⚠️\t" .. deviceName)
        else
            table.insert(report_data, "🪟\t" .. deviceName)
        end
        notFound = false
    end
end

if notFound then
    table.insert(report_data, "none")
end

sendMessage(user, table.concat(report_data, "\n"))
