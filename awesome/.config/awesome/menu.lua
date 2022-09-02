local awful = require"awful"
local beautiful = require"beautiful"
local hotkeys_popup = require"awful.hotkeys_popup"
local config = require"config"

local awesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", config.terminal .. " -e man awesome" },
   { "edit config", config.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local mainmenu = awful.menu({
    items = {
        { "awesome", awesomemenu, beautiful.awesome_icon },
        { "open terminal", config.terminal },
    }
})

local launcher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mainmenu,
})

return mainmenu
