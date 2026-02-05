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

# --- 特殊提取 (使用更稳健的目录匹配逻辑) ---

# 代理前缀（如果在国内下载慢，可改为 PROXY="https://ghproxy.com/"）
PROXY=""

# 提取 luci-app-zerotier
# 逻辑：跳过 2 层，直接匹配 applications 路径下的目标
curl -L ${PROXY}https://github.com/immortalwrt/luci/archive/refs/heads/master.tar.gz | tar -xz --strip-components=2 --wildcards "*/applications/luci-app-zerotier/"

# 提取 zerotier 核心
# 逻辑：跳过 2 层，匹配 net 路径，这样会解压出名为 zerotier 的目录
# 注意：这里改用 strip=2，匹配模式设为 "*/net/zerotier/"，能确保文件夹结构正确提取
curl -L ${PROXY}https://github.com/immortalwrt/packages/archive/refs/heads/master.tar.gz | tar -xz --strip-components=2 --wildcards "*/net/zerotier/"

# --- 提交并推送 ---
git add -A
git commit -am "update: $(date "+%Y-%m-%d %H:%M:%S")"
git push

