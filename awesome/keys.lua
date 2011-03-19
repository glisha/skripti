--koristi gi keys od rc.lua plus ovie tuka shto gi definiram

globalkeys = awful.util.table.join(globalkeys,
    -- Zakluchi go ekranot
    awful.key({ modkey }, "l", function () awful.util.spawn("/usr/bin/slock") end),
    
    -- Za zvuk gore dolu i mute
    awful.key({ }, "XF86AudioRaiseVolume", 
        function () 
            awful.util.spawn("/usr/bin/amixer -q set Master unmute", false)
            awful.util.spawn("/usr/bin/amixer -q set Master 5+", false)
        end),
    awful.key({ }, "XF86AudioLowerVolume", 
        function () 
            awful.util.spawn("/usr/bin/amixer -q set Master unmute", false)
            awful.util.spawn("/usr/bin/amixer -q set Master 5-", false) 
        end),
    awful.key({ }, "XF86AudioMute", 
        function () 
            awful.util.spawn("/usr/bin/amixer -q set Master mute") 
        end),

    -- Shaltaj se megju prozorite levo/desno vo ovoj tag
    awful.key({           "Shift" }, "Left", 
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({           "Shift" }, "Right", 
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ }, "Print",
        function () 
            awful.util.spawn("/usr/bin/gnome-screenshot -i", false)
        end)

)

root.keys(globalkeys)
