#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=Scientific-Internet-Access
PKG_VERSION:=2024
PKG_RELEASE:=0218
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/Scientific-Internet-Access
  SECTION:=gssiwmd
  CATEGORY:=GssiWMD
  TITLE:=SSR Plus/Mosdns Components
  PKGARCH:=all
  DEPENDS:=+luci-app-ssr-plus +luci-app-mosdns
endef

define Package/Scientific-Internet-Access/description
	GssiRouter SSR Plus/Mosdns Components
endef

define Build/Compile
endef

define Package/Scientific-Internet-Access/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,Scientific-Internet-Access))
