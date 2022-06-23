#!/bin/bash

if [ ! -f ./old-config ]; then
    echo "*** Old kernel config file ./old-config does not exist"
    exit 1
fi

echo "deb http://http.us.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://http.us.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list

apt-get -qq update
apt-get -qq --yes install libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf bc rsync
apt-get -qq --yes -t buster-backports install dwarves

wget http://ftp.us.debian.org/debian/pool/main/l/linux/linux-source-5.18_5.18.5-1_all.deb
dpkg -i linux-source-5.18_5.18.5-1_all.deb

tar xaf /usr/src/linux-source-5.18.tar.xz

cp old-config linux-source-5.18/.config

cd linux-source-5.18 || exit 1

make olddefconfig
make -j8 deb-pkg
