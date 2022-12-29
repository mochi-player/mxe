# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := avisynthplus
$(PKG)_WEBSITE  := https://github.com/AviSynth/AviSynthPlus.git
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.7.2
$(PKG)_CHECKSUM := 6159fd976dffa62d5db5277cbb0b3b7f7a4ee92fc8667edd32da9840a669ccc1
$(PKG)_GH_CONF  := AviSynth/AviSynthPlus/tags,v
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && $(TARGET)-cmake '$(SOURCE_DIR)' \
        -DCMAKE_BUILD_TYPE=Release \
        -DHEADERS_ONLY=ON \
        -DCMAKE_INSTALL_PREFIX='$(PREFIX)/$(TARGET)'
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)'
    $(MAKE) -C '$(BUILD_DIR)' -j 1 VersionGen install
endef
