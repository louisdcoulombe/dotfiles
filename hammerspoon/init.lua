-- Numeric keypad values
-- pad., pad*, pad+, pad/, pad-, pad=,
--   pad0, pad1, pad2,
-- pad3, pad4, pad5,
-- pad6, pad7, pad8, pad9,
-- padclear, padenter


hs.notify.new({title="Hammerspoon", informativeText="Config reloaded"}):send()

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
  hs.reload()
end)


hs.hotkey.bind({"cmd", "alt", "ctrl"}, "H", function()
    local win = hs.window.focusedWindow()
    local f = win:frame()

    f.x = f.x - 10
    win:setFrame(f)
end)
-- Function to open a browser with the currently selected text as a URL
local function searchJiraIssue()
    -- Capture the currently selected text
    local selectedText = hs.pasteboard.getContents()

    -- Check if there is any selected text
    if selectedText and selectedText ~= "" then
        -- Construct the full URL
        local url = "https://nestoca.atlassian.net/issues/" .. hs.http.encodeForQuery(string.upper(selectedText))

        -- Open the URL in the default browser
        hs.execute("open "..url)
    else
        hs.alert.show("No text selected!")
    end
end


local function openWave3()
    hs.execute("open https://nestoca.atlassian.net/browse/SERV-6782")
end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "pad3", openWave3)
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", searchJiraIssue)
