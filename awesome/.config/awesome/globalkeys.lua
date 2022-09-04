local gears = require"gears"
local awful = require"awful"
local menubar = require"menubar"
local menu = require"menu"
local config = require"config"
local hotkeys_popup = require"awful.hotkeys_popup"

local modkey = config.modkey

local mediakeys = gears.table.join(
    awful.key(
        {}, "XF86MonBrightnessUp",
        function()
            awful.spawn.with_shell[[xbacklight +5 && notify-send "Brightness - $(xbacklight -get | cut -d '.' -f 1)%"]]
        end
    ),
    awful.key(
        {}, "XF86MonBrightnessDown",
        function()
            awful.spawn.with_shell[[xbacklight -5 && notify-send "Brightness - $(xbacklight -get | cut -d '.' -f 1)%"]]
        end
    ),
    awful.key(
        {}, "XF86AudioRaiseVolume",
        function()
            awful.spawn[[pamixer -i 10]]
        end
    ),
    awful.key(
        {}, "XF86AudioLowerVolume",
        function()
            awful.spawn[[pamixer -d 10]]
        end
    ),
    awful.key(
        {}, "XF86AudioMute",
        function()
            awful.spawn[[pamixer -t]]
        end
    ),
    awful.key(
        {}, "XF86AudioPlay",
        function()
            awful.spawn[[playerctl play]]
        end
    ),
    awful.key(
        {}, "XF86AudioPause",
        function()
            awful.spawn[[playerctl pause]]
        end
    ),
    awful.key(
        {}, "XF86AudioNext",
        function()
            awful.spawn[[playerctl next]]
        end
    ),
    awful.key(
        {}, "XF86AudioPrev",
        function()
            awful.spawn[[playerctl previous]]
        end
    )
)

local globalkeys = gears.table.join(
    mediakeys,
    awful.key(
        { modkey }, "s",
        hotkeys_popup.show_help,
        { description="show help", group="awesome" }
    ),
    awful.key(
        { modkey }, "b",
        function() awful.spawn(config.browser) end,
        { description = "Open a browser", group = "launcher" }
    ),
    awful.key(
        { modkey }, "j",
        function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key(
        { modkey }, "k",
        function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }
    ),
    awful.key(
        { modkey }, "w",
        function () menu:show() end,
        { description = "show main menu", group = "awesome" }
    ),

    -- Layout manipulation
    awful.key(
        { modkey, "Shift" }, "j",
        function () awful.client.swap.byidx(  1) end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key(
        { modkey, "Shift" }, "k",
        function () awful.client.swap.byidx( -1) end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key(
        { modkey, "Control" }, "j",
        function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}
    ),
    awful.key(
        { modkey, "Control" }, "k",
        function () awful.screen.focus_relative(-1) end,
        {description = "focus the previous screen", group = "screen"}
    ),
    awful.key(
        { modkey }, "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),
    awful.key(
        { modkey }, "Tab",
        function ()
            awful.spawn("rofi -show window")
        end,
        {description = "go back", group = "client"}
    ),
    awful.key(
        { 'Mod1' }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),

    -- Standard program
    awful.key(
        { modkey }, "Return",
        function () awful.spawn(config.terminal) end,
        { description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        { modkey, "Control" }, "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key(
        { modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key(
        { modkey }, "l",
        function () awful.tag.incmwfact( 0.05) end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key(
        { modkey }, "h",
        function () awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift"   }, "h",
        function () awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift"   }, "l",
        function () awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key(
        { modkey, "Control" }, "h",
        function () awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key(
        { modkey, "Control" }, "l",
        function () awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key(
        { modkey,           }, "space",
        function () awful.layout.inc(1) end,
        {description = "select next", group = "layout"}
    ),
    awful.key(
        { modkey, "Shift"   }, "space",
        function () awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"}
    ),
    awful.key(
        { modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
              c:emit_signal(
                  "request::activate", "key.unminimize", {raise = true}
              )
            end
        end,
        {description = "restore minimized", group = "client"}
    ),

    -- Prompt
    awful.key(
        { modkey }, "r",
        function()
            awful.spawn("rofi -modi drun -show drun")
        end,
        {description = "run prompt", group = "launcher"}
    ),
    awful.key(
        { modkey }, "x",
        function ()
            awful.prompt.run {
              prompt       = "Run Lua code: ",
              textbox      = awful.screen.focused().promptbox.widget,
              exe_callback = awful.util.eval,
              history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }
    ),
    -- Menubar
    awful.key(
        { modkey }, "p",
        function() menubar.show() end,
        { description = "show the menubar", group = "launcher" }
    )
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
    awful.key(
        { modkey }, "#" .. i + 9,
        function ()
              local screen = awful.screen.focused()
              local tag = screen.tags[i]
              if tag then
                 tag:view_only()
              end
        end,
        {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
    awful.key(
        { modkey, "Control" }, "#" .. i + 9,
        function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
               awful.tag.viewtoggle(tag)
            end
        end,
        {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
    awful.key(
        { modkey, "Shift" }, "#" .. i + 9,
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
           end
        end,
        {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
    awful.key(
        { modkey, "Control", "Shift" }, "#" .. i + 9,
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
        {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

return globalkeys