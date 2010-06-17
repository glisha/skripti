#!/bin/bash
# Da go mi go izgasi touchpad-ot na laptopot, za da mi raboti samo trackpointot 
# (go menuva id-to pri restart zatoa so list go fakjam koe e sega).
# plus srednoto dugme + trackpointot da mi skrola.

#### scroll horizontalen so trackpoint-ot
divajsot=`xinput --list | grep -i "DualPoint Stick" | awk -F"id=" '{print $2}' | cut -f1`
xinput --set-prop --type=int --format=8 $divajsot "Evdev Wheel Emulation" 1
xinput --set-prop --type=int --format=8 $divajsot "Evdev Middle Button Emulation" 0 
xinput --set-prop --type=int --format=8 $divajsot "Evdev Wheel Emulation Button" 2

#### scroll vertikalen
xinput --set-prop --type=int --format=8 $divajsot "Evdev Wheel Emulation Axes" 6 7 4 5

#### izgasi go touchpad-ot
divajsot=`xinput --list | grep -i touchpad|awk -F"id=" '{print $2}'| cut -f1`
xinput --set-prop --type=int --format=8 $divajsot "Device Enabled" 0

#georgis@georgis:~$ xinput list-props 12
#Device 'DualPoint Stick':
#    Device Enabled (145):   1
#    Device Accel Profile (265): 0
#    Device Accel Constant Deceleration (266):   1.000000
#    Device Accel Adaptive Deceleration (268):   1.000000
#    Device Accel Velocity Scaling (269):    10.000000
#    Evdev Reopen Attempts (263):    10
#    Evdev Axis Inversion (270): 0, 0
#    Evdev Axes Swap (272):  0
#    Axis Labels (273):  "Rel X" (153), "Rel Y" (154)
#    Button Labels (274):    "Button Left" (146), "Button Middle" (147), "Button Right" (148), "Button Wheel Up" (149), "Button Wheel Down" (150)
#    Evdev Middle Button Emulation (275):    0
#    Evdev Middle Button Timeout (276):  50
#    Evdev Wheel Emulation (277):    1
#    Evdev Wheel Emulation Axes (278):   6, 7, 4, 5
#    Evdev Wheel Emulation Inertia (279):    10
#    Evdev Wheel Emulation Timeout (280):    200
#    Evdev Wheel Emulation Button (281): 2
#    Evdev Drag Lock Buttons (282):  0
#
