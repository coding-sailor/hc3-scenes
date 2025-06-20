-- Configuration
local acDeviceId = "<DEVICE_ID>"
local smartThingsToken = "<TOKEN>"
local sceneId = "<SCENE_ID>"

local smartThingsAPIUrl = "https://api.smartthings.com/v1/devices/" .. acDeviceId

local http = net.HTTPClient()

function switchOff()
  http:request(smartThingsAPIUrl .. "/commands", {
    options = {
      method = "POST",
      headers = {
        ["Authorization"] = "Bearer " .. smartThingsToken,
        ["Content-Type"] = "application/json"
      },
      data = json.encode({
        commands = {
          {
            component = "main",
            capability = "switch",
            command = "off"
          }
        }
      })
    },
    success = function(response)
      hub.debug(sceneId, response.data)
    end,
    error = function(message)
      hub.error(sceneId, message)
    end
  })
end

http:request(smartThingsAPIUrl .. "/status", {
  options = {
    method = "GET",
    headers = {
      ["Authorization"] = "Bearer " .. smartThingsToken
    }
  },
  success = function(response)
    if response.status == 200 then
      local data = json.decode(response.data)
      if data.components.main.switch.switch.value == "on" then
        switchOff()
      end
    else
      hub.error(sceneId, "Error. Status: " .. response.status)
    end
  end,
  error = function(message)
    hub.error(sceneId, message)
  end
})
