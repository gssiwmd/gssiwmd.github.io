#!/bin/bash

function cpdir() {
cp -rf  `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
git pull

#先删除除保留文件和目录以外的所有子目录及其文件、
find * | grep -v '\<iptv\|README.md\|update.sh\|_config.yml\>' | xargs rm -rf 


# update passwall/passwall2 & openwrt-passwall-packages
git clone https://github.com/xiaorouji/openwrt-passwall && cpdir openwrt-passwall
# git clone https://github.com/xiaorouji/openwrt-passwall2 && cpdir openwrt-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall-packages && cpdir openwrt-passwall-packages

# update OpenClash
 git clone -b master --depth 1 https://github.com/vernesong/OpenClash  && cpdir OpenClash

# update istore
git clone https://github.com/linkease/istore.git && cp -rf istore/luci/* . ; rm -rf ./istore

# update ddnsto etc.
git clone https://github.com/linkease/nas-packages.git && cp -rf ./nas-packages/multimedia/* . ; cp -rf ./nas-packages/network/services/* . ; rm -rf ./nas-packages

git clone  https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/* . ; rm -rf ./nas-packages-luci

# update argon theme
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git && rm -rf ./luci-theme-argon/.git; rm -rf  ./luci-theme-argon/.github
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git && rm -rf ./luci-app-argon-config/.git; rm -rf ./luci-app-argon-config/.github

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
