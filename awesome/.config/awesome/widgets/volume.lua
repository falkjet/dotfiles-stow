local wibox = require"wibox"
local awful = require"awful"
local gears = require"gears"


local volume_widget = { mt = {} }

function volume_widget:force_update()
    self._timer:emit_signal("timeout")
end

local function new(args)
    args = args or {}
    local invert_scroll = args.invert_scroll or false
    local w = wibox.widget.textbox()
    gears.table.crush(w, volume_widget, true)
    local icons = {muted="婢 ", "奄 ", "奔 ", "墳 "}

    w:buttons(
        gears.table.join(
            awful.button(
                {}, 1,
                function()
                    awful.spawn[[pamixer -t]]
                    w:force_update()
                end
            ),
            awful.button(
                {}, 4,
                function()
                    if invert_scroll then
                        awful.spawn[[pamixer -d 1]]; w:force_update()
                    else
                        awful.spawn[[pamixer -i 1]]; w:force_update()
                    end
                end
            ),
            awful.button(
                {}, 5,
                function()
                    if invert_scroll then
                        awful.spawn[[pamixer -i 1]]; w:force_update()
                    else
                        awful.spawn[[pamixer -d 1]]; w:force_update()
                    end
                end
            )
        )
    )

    local timer
    w, timer = awful.widget.watch(
        "pamixer --get-mute --get-volume", 1,
        function(widget, stdout, stderr, exitreason, exitcode)
            w.text = "volume"
            for muted_t, vol_t in stdout:gmatch("(%w+) (%d+)") do
                local muted = muted_t == "true"
                local vol = tonumber(vol_t)
                if muted then
                    w.text = icons.muted .. "muted"
                else
                    local icon = vol >= 90 and 3 or vol >=30 and 2 or 1
                    w.text = icons[icon] .. tostring(vol)
                end
            end
        end,
        w
    )
    w._timer = timer
    return w
end

function volume_widget.mt:__call(...)
    return new(...)
end

return setmetatable(volume_widget, volume_widget.mt)
