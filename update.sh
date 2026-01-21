#!/bin/bash

function cpdir() {
cp -rf  `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

git pull

#先删除除保留文件和目录以外的所有子目录及其文件、
find * | grep -v '\<iptv\|README.md\|update.sh\|_config.yml\>' | xargs rm -rf 


# update passwall & openwrt-passwall-packages
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall && cpdir openwrt-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages && cpdir openwrt-passwall-packages

# update OpenClash
 git clone -b master --depth 1 https://github.com/vernesong/OpenClash  && cpdir OpenClash


# update istore
# git clone https://github.com/linkease/istore.git && cp -rf istore/luci/* . ; rm -rf ./istore

# update ddnsto etc.
git clone --depth 1 https://github.com/linkease/nas-packages.git &&  cp -rf ./nas-packages/network/services/ddnsto . ; rm -rf ./nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/luci-app-ddnsto . ; rm -rf ./nas-packages-luci

#update  luci-app-openlist2
git clone --depth 1 https://github.com/sbwml/luci-app-openlist2 oplist && cpdir oplist

# update argon theme
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git && rm -rf ./luci-theme-argon/.git; rm -rf  ./luci-theme-argon/.github
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git && rm -rf ./luci-app-argon-config/.git; rm -rf ./luci-app-argon-config/.github


# update momo and  nikiki
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-momo OpenWrt-momo && mv -n OpenWrt-momo/*momo ./ ; rm -rf OpenWrt-momo
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki OpenWrt-nikki && mv -n OpenWrt-nikki/*nikki ./ ; rm -rf OpenWrt-nikki

# push to github
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
