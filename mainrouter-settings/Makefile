#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mainrouter-settings
PKG_VERSION:=2024
PKG_RELEASE:=0128
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/mainrouter-settings
  SECTION:=gssiwmd
  CATEGORY:=GssiWMD
  TITLE:=MainRouter Settings
  PKGARCH:=all
endef

define Package/mainrouter-settings/description
	GssiRouter MainRouter Settings Support Packages.
endef

define Build/Compile
endef

define Package/mainrouter-settings/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,mainrouter-settings))
