#
#  This is a piece of code for personal use. 
#  I am not responsible for any unauthorized calls 
#  and all possible consequences.   
#  Copyright (C) 2023-2025 WangMingde
#

include $(TOPDIR)/rules.mk

PKG_NAME:=iptv-live
PKG_VERSION:=2024
PKG_RELEASE:=0223

include $(INCLUDE_DIR)/package.mk

define Package/iptv-live
  SECTION:=gssiwmd
  CATEGORY:=Private Packages
  TITLE:=IPTV LiveSources
  PKGARCH:=all
endef

define Package/iptv/description
	GssiRouter IPTV Live Channel
endef

define Build/Compile
endef

define Package/iptv-live/install
  mkdir -p $(1)/www/iptv
  
	$(CP)  ./*.m3u $(1)/www/iptv
	$(CP)  ./*.txt $(1)/www/iptv
	$(CP)  ./update_xiaoya.sh $(1)/www/iptv
endef

$(eval $(call BuildPackage,iptv-live))
