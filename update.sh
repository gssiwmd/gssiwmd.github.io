#!/bin/bash

# 定义拷贝并清理函数
function cpdir() {
    cp -rf `find $1/* -maxdepth 0 -type d` ./
    rm -rf $1
}

# 1. 同步主仓库代码
git pull

# 2. 清理环境：保留特定文件，删除其余内容
find * -maxdepth 0 | grep -v '\<iptv\|README.md\|update.sh\|_config.yml\>' | xargs rm -rf 

# --- 插件更新 (标准 Git Clone 方式) ---

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

# --- 特殊提取 (使用通配符解压方式，确保路径 100% 匹配) ---

# 代理前缀（如果在国内服务器下载慢，可以把下面这行改为 PROXY="https://ghproxy.com/"）
PROXY=""

# 提取 luci-app-zerotier (从 immortalwrt/luci 仓库)
curl -L -o luci_tmp.tar.gz ${PROXY}https://github.com/immortalwrt/luci/archive/refs/heads/master.tar.gz
tar -xzf luci_tmp.tar.gz --strip-components=2 --wildcards "*/applications/luci-app-zerotier"
rm -f luci_tmp.tar.gz

# 提取 zerotier 核心程序 (从 immortalwrt/packages 仓库)
curl -L -o pkg_tmp.tar.gz ${PROXY}https://github.com/immortalwrt/packages/archive/refs/heads/master.tar.gz
tar -xzf pkg_tmp.tar.gz --strip-components=3 --wildcards "*/net/zerotier"
rm -f pkg_tmp.tar.gz

# --- 提交并推送 ---
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push

