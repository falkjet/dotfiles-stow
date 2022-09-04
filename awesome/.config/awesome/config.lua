local M = {
    modkey = "Mod4",
    terminal = "xfce4-terminal",
    editor = os.getenv("EDITOR") or "vi",
    editor_cmd = "kitty -e " .. (os.getenv("EDITOR") or "vi"),
    browser = "firefox",
}

return M
