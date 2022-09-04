local wibox = require"wibox"
local awful = require"awful"
local gears = require"gears"


local mpris_widget = { mt = {} }

function mpris_widget:force_update()
    self._timer:emit_signal("timeout")
end

local function strip_string(s)
    return string.gsub(string.gsub(s, "^%s+", ""), "%s+$", "")
end

local function new()
    local w = wibox.widget.textbox()
    gears.table.crush(w, mpris_widget, true)
    w:buttons(
        gears.table.join(
            awful.button({}, 1, nil, function()
                awful.spawn[[playerctl play-pause]]
            end)
        )
    )
    local timer;
    local icons = {
        Playing  = "",
        Paused  = "",
        Stopped  = "",
    }
    w, timer = awful.widget.watch(
        [[sh -c "playerctl status; playerctl metadata"]], 1,
        function(widget, stdout, stderr, exitreason, exitcode)
            if stdout == "" then widget.text = ""; return; end
            local firstnl = stdout:find"\n"
            local status = strip_string(stdout:sub(1, firstnl-1))
            local info_text = stdout:sub(firstnl + 1, stdout:len())

            local metadata = {}
            for k,v in info_text:gmatch"ncspot ([%w:]+)%s+([^\n]+)" do
                if metadata[k] == nil then
                    metadata[k] = {}
                end
                table.insert(metadata[k], v)
            end

            local artists_text = ""
            for i, artist in pairs(metadata['xesam:artist']) do
                if i == 1 then
                    artists_text = artists_text .. artist
                else
                    artists_text = artists_text .. ", " .. artist
                end
            end

            widget.text = (icons[status] or status) .. " " .. artists_text .. " - " .. metadata['xesam:title'][1]
        end,
        w
    )
    w._timer = timer

    return w
end

function mpris_widget.mt:__call(...)
    return new(...)
end

return setmetatable(mpris_widget, mpris_widget.mt)
