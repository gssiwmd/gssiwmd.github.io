#!/bin/bash

# 定义快捷拷贝函数
function cpdir() {
  cp -rf `find $1/* -maxdepth 0 -type d` ./
  rm -rf $1
  }
#0 git pull
git pull

# 1. 安全清理：排除掉 .git, .github 以及你的保留文件/目录
# 使用 ls -A 配合 grep 是为了防止 find 命令在某些环境下误触隐藏的 .github 文件夹
ls -A | grep -vE '\.git|\.github|iptv|README.md|update.sh' | xargs rm -rf

# --- 开始下载插件 ---

# Passwall & Packages
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall && cpdir openwrt-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages && cpdir openwrt-passwall-packages

# OpenClash
git clone -b master --depth 1 https://github.com/vernesong/OpenClash && cpdir OpenClash

# ddnsto
git clone --depth 1 https://github.com/linkease/nas-packages.git && cp -rf ./nas-packages/network/services/ddnsto . ; rm -rf ./nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages-luci.git && cp -rf ./nas-packages-luci/luci/luci-app-ddnsto . ; rm -rf ./nas-packages-luci

# luci-app-openlist2
git clone --depth 1 https://github.com/sbwml/luci-app-openlist2 oplist && cpdir oplist

# Argon Theme (清理其自带的 git/github 记录)
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git && rm -rf ./luci-theme-argon/.git ./luci-theme-argon/.github
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git && rm -rf ./luci-app-argon-config/.git ./luci-app-argon-config/.github

# momo & nikki
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-momo OpenWrt-momo && mv -n OpenWrt-momo/*momo ./ ; rm -rf OpenWrt-momo
git clone --depth 1 https://github.com/nikkinikki-org/OpenWrt-nikki OpenWrt-nikki && mv -n OpenWrt-nikki/*nikki ./ ; rm -rf OpenWrt-nikki

# 提取 luci-app-zerotier (界面)
# --strip-components=2 用于跳过压缩包内的 'luci-master/applications/' 路径层级
curl -L https://github.com/immortalwrt/luci/archive/refs/heads/master.tar.gz | tar -xz --strip-components=2 --wildcards "*/applications/luci-app-zerotier/"
sed -i 's|../../luci.mk|$(TOPDIR)/feeds/luci/luci.mk|g' ./luci-app-zerotier/Makefile
# 2. 提取 zerotier (核心程序)
# 压缩包内路径是: packages-master/net/zerotier/
# 我们剥离前两层 (packages-master 和 net)，保留 zerotier 目录
curl -L https://github.com/immortalwrt/packages/archive/refs/heads/master.tar.gz | tar -xz --strip-components=2 --wildcards "*/net/zerotier/"

# 4. 提交并强制推送
git add -A
git commit -m "Auto Update: $(date "+%Y-%m-%d %H:%M:%S")"
git push
