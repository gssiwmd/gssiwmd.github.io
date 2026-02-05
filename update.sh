#!/bin/bash

function cpdir() {
    # 查找指定目录下所有子目录并拷贝到当前目录，然后删除源目录
    cp -rf `find $1/* -maxdepth 0 -type d` ./
    rm -rf $1
}

# 同步主仓库代码
git pull

# 1. 清理环境
find * -maxdepth 0 | grep -v '\<iptv\|README.md\|update.sh\|_config.yml\>' | xargs rm -rf 

# --- 插件更新 (Git Clone 方式) ---
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall && cpdir openwrt-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages && cpdir openwrt-passwall-packages
git clone -b master --depth 1 https://github.com/vernesong/OpenClash && cpdir OpenClash
git clone --depth 1 https://github.com/linkease/nas-packages.git && cp -rf ./nas-packages/network/services/ddnsto . ; rm -rf ./nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/luci-app-ddnsto . ; rm -rf ./nas-packages-luci
git clone --depth 1 https://github.com/sbwml/luci-app-openlist2 oplist && cpdir oplist
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git && rm -rf ./luci-theme-argon/.git ./luci-theme-argon/.github
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git && rm -rf ./luci-app-argon-config/.git ./luci-app-argon-config/.github
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-momo OpenWrt-momo && mv -n OpenWrt-momo/*momo ./ ; rm -rf OpenWrt-momo
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki OpenWrt-nikki && mv -n OpenWrt-nikki/*nikki ./ ; rm -rf OpenWrt-nikki

# --- 特殊提取 (Tar 方式：直接从压缩包提取特定目录) ---
# 提取界面：luci-app-zerotier
curl -L https://github.com/immortalwrt/luci/archive/refs/heads/master.tar.gz | tar -xz --strip-components=2 immortalwrt-luci-master/applications/luci-app-zerotier

# 提取核心：zerotier
curl -L https://github.com/immortalwrt/packages/archive/refs/heads/master.tar.gz | tar -xz --strip-components=3 immortalwrt-packages-master/net/zerotier

# --- 提交并推送 ---
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
