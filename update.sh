#!/bin/bash


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
git clone https://github.com/linkease/istore.git
cp -rf istore/luci/* .
rm -rf ./istore

# update ddnsto etc.
git clone https://github.com/linkease/nas-packages.git
cp -rf nas-packages/multimedia/* .
cp -rf nas-packages/network/services/* .
rm -rf nas-packages

# git clone  https://github.com/linkease/nas-packages-luci.git
# cp -rf nas-packages-luci/luci/* .
# rm -rf ./nas-packages-luci

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
