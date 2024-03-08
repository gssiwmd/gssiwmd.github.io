#!/bin/bash

function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

# Update passwall
git clone  https://github.com/xiaorouji/openwrt-passwall.git
rm -rf ./openwrt-passwall/.git
rm -rf ./openwrt-passwall/.github
cp -rf ./openwrt-passwall/* .
rm -rf ./openwrt-passwall

git clone  https://github.com/xiaorouji/openwrt-passwall-packages.git
rm -rf ./openwrt-passwall-packages/.git
rm -rf ./openwrt-passwall-packages/.github
cp -rf ./openwrt-passwall-packages/* .
rm -rf ./openwrt-passwall-packages

# update helloworld
git clone  https://github.com/fw876/helloworld.git
rm -rf ./helloworld/.git
rm -rf ./helloworld/.github
rm -rf ./helloworld/LICENSE
rm -rf ./helloworld/README.md
cp -rf ./helloworld/* .
rm -rf ./helloworld

# update istore
# git clone --depth 1 https://github.com/linkease/istore.git
# mv -f istore/luci ./
# rm -rf ./istore

# update ddnsto etc.
# git clone --depth 1 https://github.com/linkease/nas-packages nas
# mv -f nas/multimedia ./
# mv -f nas/network/services ./
# rm -rf nas
# git clone --depth 1 https://github.com/linkease/nas-packages-luci nasluci
# mv -f nasluci/luci ./
# rm -rf nasluci

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
