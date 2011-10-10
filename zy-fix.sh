#!/system/bin/sh
mount -o rw,remount /system
cd /system/usr/keylayout/
mv trout-keypad-v3.kl trout-keypad-qwertz.kl
mount -o ro,remount /system
