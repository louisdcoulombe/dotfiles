local logger = hs.logger.new('usb', 'debug')
local http = require "hs.http"
local apps = require "apps"
local audio = require "audio"
local process = require "utils/process"
local screen = require 'screen'

local mod = {
  switchLights = 'switch.desk_lights',
  switchDesk = 'switch.office_desk'
}

-- Global USB handler to workaround.
-- There seems to be a bug where the USB handler will stop responding after the first invocation.
local globalHandler = nil

-- Event Example
-- usb: {
--   eventType = "removed",
--   productID = 33107,
--   productName = "USB 10/100/1000 LAN",
--   vendorID = 3034,
--   vendorName = "Realtek"
-- }
-- usb: {
--   eventType = "added",
--   productID = 33107,
--   productName = "USB 10/100/1000 LAN",
--   vendorID = 3034,
--   vendorName = "Realtek"
-- }
-- usb: {
--   eventType = "added",
--   productID = 3140,
--   productName = "ZV-1",
--   vendorID = 1356,
--   vendorName = "Sony"
-- }

function mod.toggleOfficeLight()
  -- read from config because hammerspoon doesn't load environment variable
  local hassKey = hs.json.read("/Users/louis-davidcoulombe/.hammerspoon.json").HOME_ASSISTANT_API_KEY
  local headers = {
    ["Authorization"] = "Bearer " .. hassKey,
    ["Content-Type"] = "application/json"
  }
  local devices = { "switch.smart_switch_2001085862680225188448e1e9168eee_outlet", "switch.petite_lampe_bureau_outlet" }
  local url = "http://homeassistant.local:8123/api/services/switch/toggle"
  for _, device in pairs(devices) do
    local data = {
      entity_id = device,
    }

    local response, body, _ = hs.http.post(url, hs.json.encode(data), headers)
    if response ~= 200 then
      hs.notify.new({title=response, informativeText=body}):send()
    end
    -- print(body)
  end
  -- hs.dialog.alert(200, 200, function() end, "Response", response, "Done")
end

function mod.officeAutomation(scene, command)
  return function()
    if scene == 'office_call' then
      if command == 'on' then
        hs.spotify.pause()
        hs.urlevent.openURL("neewerlite://turnOnLight")
      else
        audio.setVolume('default')()
        hs.urlevent.openURL("neewerlite://turnOffLight")
      end
    end
    process.start(apps.getExecPath('office-automation'), {'--scene', scene, command }, nil, 10)
    if scene == 'desk' and command == 'off' then
      hs.spotify.pause()
      hs.caffeinate.systemSleep()
    end
  end
end

function mod.switchToggler(entityId)
  return mod.officeAutomation('toggle', entityId)
end

local function buildGlobalHandler(watchedEvents)
  local function buildHandler(watchedEvent)
    return function(event)
      local isEventType = event.eventType == watchedEvent.eventType
      local isProductID = event.productID == watchedEvent.productID
      local isVendorID = event.vendorID == watchedEvent.vendorID

      -- Trying to prevent too many executions
      local currentEpoch = process.getEpoch()
      local hasBeenDebounced = (watchedEvent.lastExecuted or 0) + 2 < currentEpoch

      if isEventType and isProductID and isVendorID and hasBeenDebounced then
        logger.df("event matched %s", hs.inspect(watchedEvent))
        watchedEvent.lastExecuted = currentEpoch
        watchedEvent.fn()
      end
    end
  end

  local handlers = hs.fnutils.map(watchedEvents, buildHandler)

  local lastExecuted = 0

  return function(event)
    logger.d(hs.inspect(event))
    hs.fnutils.each(handlers, function(handler) handler(event) end)

    -- Trying to prevent too many executions
    local currentEpoch = process.getEpoch()
    -- Workaround the watcher hanging after a few execution.
    if lastExecuted + 2 <  currentEpoch then
      logger.d('Restarting USB event handler...')
      globalHandler:stop():start()
      lastExecuted = currentEpoch
    end
  end
end

local watchedEvents = {
  -- Network adapter on office Thunderbolt dock
  -- {eventType = "added", productID = 33107, productName = "USB 10/100/1000 LAN", vendorID = 3034, vendorName = "Realtek", fn = mod.officeAutomation("off", mod.switchDesk)},

  -- ZV-1 with in USB mass storage mode
  -- {eventType = "added", productID = 3140, productName = "ZV-1", vendorID = 1356, vendorName = "Sony", fn = mod.officeAutomation("on")},
  -- {eventType = "removed", productID = 3140, productName = "ZV-1", vendorID = 1356, vendorName = "Sony", fn = mod.officeAutomation("off")},

  -- ZV-1 with webcam in USB streaming mod
  {eventType = "added", productID = 3556, productName = "ZV-1", vendorID = 1356, vendorName = "Sony", fn = mod.officeAutomation("office_call", "on")},
  {eventType = "removed", productID = 3556, productName = "ZV-1", vendorID = 1356, vendorName = "Sony", fn = mod.officeAutomation("office_call", "off")},
}

function mod.init()
  local handlers = buildGlobalHandler(watchedEvents)
  globalHandler = hs.usb.watcher.new(handlers)
  globalHandler:start()
end

return mod
