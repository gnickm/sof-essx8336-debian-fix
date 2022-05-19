#!/bin/bash

DEVICE="hw:0,0"

sed -i "s|^#load-module module-alsa-sink.*|load-module module-alsa-sink device=\"$DEVICE\"|" /etc/pulse/default.pa
sed -i "s|^#load-module module-alsa-source.*|load-module module-alsa-source device=\"$DEVICE\"|" /etc/pulse/default.pa

echo "=== Done!"
exit 0
