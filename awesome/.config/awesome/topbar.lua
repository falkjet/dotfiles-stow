local awful = require"awful";
local wibox = require"wibox";
local gears = require"gears";
local widgets = require"widgets"

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({}, 3, awful.tag.viewtoggle)
)

local tasklist_buttons = gears.table.join(
    awful.button(
        {}, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end
    )
)


local keyboardlayout = awful.widget.keyboardlayout()
local textclock = wibox.widget.textclock()

local M = {};
M.setup = function(s)
    local topbar = awful.wibar({
        screen = s,
        position = "top",
        height = 32,
    });
    s.topbar = topbar

    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(
        gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )

    s.promptbox = awful.widget.prompt()

    s.tasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        widget_template = {
            widget = wibox.container.constraint,
            forced_width = 250,
            {
                id = "background_role",
                widget = wibox.container.background,
                {
                    left = 5,
                    right = 5,
                    top = 5,
                    bottom = 5,
                    widget = wibox.container.margin,
                    {
                        layout = wibox.layout.fixed.horizontal,
                        {
                            widget = wibox.container.margin,
                            right = 10,
                            top = 3,
                            bottom = 3,
                            left = 5,
                            {
                                id = "icon_role",
                                widget = wibox.widget.imagebox,
                            }
                        },
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox,
                        }
                    },
                },
            }
        },
    }

    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
        widget_template = {
            id     = 'background_role',
            widget = wibox.container.background,
            {
                left  = 10,
                right = 10,
                widget = wibox.container.margin,
                {
                        margins = 4,
                        widget  = wibox.container.margin,
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                },
            },
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args

            end,
            update_callback = function(self, c3, index, objects) --luacheck: no unused args

            end,
        },
    }

    s.topbar:setup({
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.promptbox,
            s.taglist,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            s.tasklist,
        },
        {
            widget = wibox.container.margin, margins = 5,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 10,
                keyboardlayout,
                widgets.mpris(),
                widgets.battery(),
                widgets.volume{invert_scroll=true},
                textclock,
                wibox.widget.systray(),
                s.layoutbox,
            },
        },
    });


end;
return M;
