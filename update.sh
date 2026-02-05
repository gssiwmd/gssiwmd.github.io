#!/bin/bash

function cpdir() {
    # 查找指定目录下所有子目录并拷贝到当前目录，然后删除源目录
    cp -rf `find $1/* -maxdepth 0 -type d` ./
    rm -rf $1
}

# 同步主仓库代码
git pull

# 1. 清理环境：删除除保留文件和目录以外的所有内容
# 保留 iptv, README.md, update.sh, _config.yml
find * -maxdepth 0 | grep -v '\<iptv\|README.md\|update.sh\|_config.yml\>' | xargs rm -rf 

# --- 开始更新各插件 ---

# update passwall & openwrt-passwall-packages
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall && cpdir openwrt-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages && cpdir openwrt-passwall-packages

# update OpenClash
git clone -b master --depth 1 https://github.com/vernesong/OpenClash && cpdir OpenClash

# update ddnsto etc.
git clone --depth 1 https://github.com/linkease/nas-packages.git && cp -rf ./nas-packages/network/services/ddnsto . ; rm -rf ./nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/luci-app-ddnsto . ; rm -rf ./nas-packages-luci

# update luci-app-openlist2
git clone --depth 1 https://github.com/sbwml/luci-app-openlist2 oplist && cpdir oplist

# update argon theme
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git && rm -rf ./luci-theme-argon/.git ./luci-theme-argon/.github
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git && rm -rf ./luci-app-argon-config/.git ./luci-app-argon-config/.github

# update momo and nikiki
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-momo OpenWrt-momo && mv -n OpenWrt-momo/*momo ./ ; rm -rf OpenWrt-momo
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki OpenWrt-nikki && mv -n OpenWrt-nikki/*nikki ./ ; rm -rf OpenWrt-nikki

# --- 特殊处理：提取 luci-app-zerotier ---
# 使用独立的临时目录避免污染主目录的 .git 配置
git clone --depth 1 --filter=blob:none --sparse https://github.com/immortalwrt/luci temp-zt
cd temp-zt
git sparse-checkout set applications/luci-app-zerotier
cd ..
# 拷贝目标文件夹到根目录
cp -rf temp-zt/applications/luci-app-zerotier ./
# 彻底删除带 .git 稀疏配置的临时目录
rm -rf temp-zt

# --- 提交并推送 ---
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push

