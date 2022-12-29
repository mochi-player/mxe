# This file is part of MXE. See LICENSE.md for licensing information.

# lconvert and lupdate are not provided by MXE for Qt4,
# so for Debian/Ubuntu you need install packages qt4-linguist-tools
# (this package contains lupdate and lrelease) and qt4-dev-tools
# (this package contains lconvert):
# apt-get install qt4-linguist-tools qt4-dev-tools
# Or you may use lupdate, lrelease, lconvert from Qt5:
# apt-get install qttools5-dev-tools
# TODO: CONFIG+=embed_translations

PKG             := baka-mplayer
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := aaef02f
$(PKG)_CHECKSUM := a6c1e6c6c0670ba33cec3a12d22d608859f72a8d843caea5bffb212f97dcd302
$(PKG)_GH_CONF  := u8sand/Baka-MPlayer/branches/master
$(PKG)_WEBSITE  := https://u8sand.github.io/Baka-MPlayer/
$(PKG)_DEPS     := cc qt5 qtsvg qtwinextras mpv libzip pthreads

define $(PKG)_BUILD
   cd '$(BUILD_DIR)' && $(TARGET)-qmake-qt5 $(SOURCE_DIR)/src/Baka-MPlayer.pro "PREFIX=$(PREFIX)/$(TARGET)/bin/" CONFIG+=release DESTDIR=$(BUILD_DIR)
   $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
   $(INSTALL) '$(BUILD_DIR)/baka-mplayer.exe' '$(PREFIX)/$(TARGET)/bin'
endef
