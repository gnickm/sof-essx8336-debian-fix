#!/bin/bash

if [ -L /usr/lib/firmware/intel/sof ]; then
    echo "--- Removing old sof-bin firmware links"
    rm /usr/lib/firmware/intel/sof
    rm /usr/lib/firmware/intel/sof-tplg
fi

echo "--- Installing latest sof-bin firmware"
git clone https://github.com/thesofproject/sof-bin /tmp/sof-bin

(
    cd /tmp/sof-bin || exit 1
    ./install.sh v2.1.x/v2.1.1
);

echo "--- Installing custom ESSX8336 topologies"
tar xf ./dist/es8336-topologies-2.tar.gz -C /usr/lib/firmware/intel/sof-tplg/

echo "--- Cleaning up"
rm -rf /tmp/sof-bin

echo "=== Done!"
exit 0
