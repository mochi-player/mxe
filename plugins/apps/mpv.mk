# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := mpv
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.35.0
$(PKG)_CHECKSUM := dc411c899a64548250c142bf1fa1aa7528f1b4398a24c86b816093999049ec00
$(PKG)_GH_CONF  := mpv-player/mpv/tags,v
$(PKG)_WEBSITE  := https://mpv.io/
$(PKG)_DEPS     := gcc ffmpeg libass lua luajit jpeg pthreads

define $(PKG)_BUILD
  cd '$(SOURCE_DIR)' \
    && chmod +x ./waf \
    && DEST_OS=win32 TARGET=$(TARGET) ./waf configure -v \
      -o '$(BUILD_DIR)' $(if $(BUILD_STATIC), --enable-libmpv-static) 2>&1 > $(BUILD_DIR)/build.log \
    && ./waf build -v -o '$(BUILD_DIR)' -j '$(JOBS)' 2>&1 >> $(BUILD_DIR)/build.log

  $(INSTALL) '$(BUILD_DIR)/mpv.exe' '$(PREFIX)/$(TARGET)/bin'
  $(if $(BUILD_STATIC),
    $(INSTALL) '$(BUILD_DIR)/libmpv.a' '$(PREFIX)/$(TARGET)/lib'
  )
  $(INSTALL) -d '$(PREFIX)/$(TARGET)/include/mpv'
  $(INSTALL) '$(SOURCE_DIR)/libmpv/client.h' '$(PREFIX)/$(TARGET)/include/mpv/client.h'
  cat $(BUILD_DIR)/libmpv/mpv.pc \
    | sed "s,^prefix=.*$$,prefix=$(PREFIX)/$(TARGET),g" \
    | sed "s,^exec_prefix=.*$$,exec_prefix=\$${prefix},g" \
    | sed "s,^libdir=.*$$,libdir=\$${prefix}/lib,g" \
    | sed "s,^includedir=.*$$,includedir=\$${prefix}/include,g" \
    > '$(PREFIX)/$(TARGET)/lib/pkgconfig/mpv.pc'
endef
