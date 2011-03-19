myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

myxrandrmenu = {
   {"clone", "xrandr --output VGA1 --same-as LVDS1 --auto" },
   {"left-of", "xrandr --output VGA1 --left-of LVDS1 --preferred" },
   {"right-of", "xrandr --output LVDS1 --primary --output VGA1 --right-of LVDS1 --preferred" },
   {"above", "xrandr --output VGA1 --above LVDS1 --preferred" },
   {"below", "xrandr --output VGA1 --below LVDS1 --preferred" },
   {"off", "xrandr --output VGA1 --off" }
}

mymenu = {
    {"awesome", myawesomemenu, beautiful.awesome_icon },
    {"xrandr", myxrandrmenu },
    {"Debian", debian.menu.Debian_menu.Debian },
    {"open terminal", terminal },
    {"Lock screen", "slock", "/usr/share/icons/oxygen/16x16/actions/system-lock-screen.png" },
    {"Reboot", "sudo /sbin/reboot", "/usr/share/icons/oxygen/16x16/actions/system-reboot.png" },
    {"Poweroff", "sudo /sbin/poweroff", "/usr/share/icons/oxygen/16x16/actions/system-shutdown.png" }
}

mymainmenu = awful.menu({ items = mymenu })
