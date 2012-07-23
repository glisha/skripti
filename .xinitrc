#!/bin/bash

#Terminalite vo Awesome da se zakachuvaat na ovoj daemon. Troshi pomalku memorija.
#vo awesome terminal e urxvtc
/usr/bin/urxvtd -q -o -f

#network manager applet
#/usr/bin/nm-applet &
/usr/bin/wicd-gtk --tray &

#da go zakluchi ekranot posle edna minuta
/usr/bin/xautolock -time 10 -locker '/usr/bin/slock' &

#tastaturata so Capslock go menuva, so desen alt dur e stisnat
setxkbmap -layout us,mk -option grp:switch -option grp:caps_toggle -option grp_led:scroll

exec /usr/bin/awesome
