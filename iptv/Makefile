#
# Copyright (C) 2010-2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=iptv
PKG_VERSION:=2024
PKG_RELEASE:=0223
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/iptv
  SECTION:=gssiwmd
  CATEGORY:=GssiWMD
  TITLE:=IPTV Live Channel
  PKGARCH:=all
endef

define Package/iptv/description
	GssiRouter IPTV Live Channel
endef

define Build/Compile
endef

define Package/iptv/install
  mkdir -p $(1)/www/iptv
  
	$(CP)  *.m3u $(1)/www/iptv
	$(CP)  *.txt $(1)/www/iptv
	$(CP)  update_xiaoya.sh $(1)
endef

$(eval $(call BuildPackage,iptv))
