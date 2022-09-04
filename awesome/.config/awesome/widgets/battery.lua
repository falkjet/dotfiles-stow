local wibox = require"wibox"
local awful = require"awful"
local gears = require"gears"


local battery_widget = { mt = {} }

local function new()
    local w = wibox.widget.textbox()
    gears.table.crush(w, battery_widget, true)
    local icons = {" "," "," "," "}

    return awful.widget.watch(
        "acpi -b", 1,
        function(widget, stdout, stderr, exitreason, exitcode)
            widget.text = stdout
            for status, charge in stdout:gmatch"Battery %d: ([%w%s]+), (%d+)%%,?" do
                local c = tonumber(charge)
                widget.text=icons[1 + (c >= 20 and 1 or 0) + (c >= 50 and 1 or 0) + (c >= 90 and 1 or 0)] .. charge
            end
        end,
        w
    )
end

function battery_widget.mt:__call(...)
    return new(...)
end

return setmetatable(battery_widget, battery_widget.mt)
