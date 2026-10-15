local mod = {}

local speakerName = 'OS-10'
local script = os.getenv('HOME') .. '/.hammerspoon/connect-speakers.sh'

-- Hammerspoon has no Bluetooth permission (macOS kills blueutil with SIGABRT),
-- so the connection runs inside Ghostty, which does.
local function makeDefaultOutput(attemptsLeft)
  local device = hs.audiodevice.findOutputByName(speakerName)
  if device then
    device:setDefaultOutputDevice()
    hs.alert.show(speakerName .. ' connected')
  elseif attemptsLeft > 0 then
    hs.timer.doAfter(1, function() makeDefaultOutput(attemptsLeft - 1) end)
  else
    local names = {}
    for _, d in ipairs(hs.audiodevice.allOutputDevices()) do table.insert(names, d:name()) end
    print('outputs: ' .. table.concat(names, ', '))
    hs.alert.show(speakerName .. ' did not show up as an audio output (see /tmp/connect-speakers.log)', 5)
  end
end

function mod.connectSpeakers()
  local previous = hs.window.frontmostWindow()
  hs.alert.show('Connecting ' .. speakerName .. ' ...')
  hs.task.new('/usr/bin/open', function(code, out, err)
    print('open exit', code, out, err)
  end, {
    '-n', '-a', 'Ghostty', '--args',
    '--quit-after-last-window-closed=true',
    '--confirm-close-surface=false',
    '-e', script, speakerName,
  }):start()
  -- Ghostty only starts the script when launched in the foreground, so hand focus back afterward
  hs.timer.doAfter(3, function()
    if previous then previous:focus() end
    makeDefaultOutput(10)
  end)
end

return mod
