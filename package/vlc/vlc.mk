################################################################################
#
# vlc
#
################################################################################

VLC_VERSION = 2.1.5
VLC_SITE = http://download.videolan.org/pub/videolan/vlc/$(VLC_VERSION)
VLC_SOURCE = vlc-$(VLC_VERSION).tar.xz
VLC_LICENSE = GPLv2+ LGPLv2.1+
VLC_LICENSE_FILES = COPYING COPYING.LIB
VLC_DEPENDENCIES = host-pkgconf
VLC_AUTORECONF = YES

# VLC defines two autoconf functions which are also defined by our own pkg.m4
# from pkgconf. Unfortunately, they are defined in a different way: VLC adds
# --enable- options, but pkg.m4 adds --with- options. To make sure we use
# VLC's definition, rename these two functions.
define VLC_OVERRIDE_PKG_M4
	$(SED) 's/PKG_WITH_MODULES/VLC_PKG_WITH_MODULES/g' \
		-e 's/PKG_HAVE_WITH_MODULES/VLC_PKG_HAVE_WITH_MODULES/g' \
		$(@D)/configure.ac $(@D)/m4/with_pkg.m4
endef
VLC_POST_PATCH_HOOKS += VLC_OVERRIDE_PKG_M4

VLC_CONF_OPTS += \
	--disable-a52 \
	--disable-shout \
	--disable-twolame \
	--disable-dca \
	--disable-dirac \
	--disable-schroedinger \
	--disable-quicksync \
	--disable-fluidsynth \
	--disable-zvbi \
	--disable-kate \
	--disable-caca \
	--disable-jack \
	--disable-samplerate \
	--disable-chromaprint \
	--disable-goom \
	--disable-projectm \
	--disable-vsxu \
	--disable-mtp \
	--disable-opencv

# Building static and shared doesn't work, so force static off.
ifeq ($(BR2_PREFER_STATIC_LIB),)
VLC_CONF_OPTS += --disable-static
endif

ifeq ($(BR2_POWERPC_CPU_HAS_ALTIVEC),y)
VCL_CONF_OPTS += --enable-altivec
else
VLC_CONF_OPTS += --disable-altivec
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
VLC_CONF_OPTS += --enable-alsa
VLC_DEPENDENCIES += alsa-lib
else
VLC_CONF_OPTS += --disable-alsa
endif

# bonjour support needs avahi-client, which needs avahi-daemon and dbus
ifeq ($(BR2_PACKAGE_AVAHI)$(BR2_PACKAGE_AVAHI_DAEMON)$(BR2_PACKAGE_DBUS),yyy)
VLC_CONF_OPTS += --enable-bonjour
VLC_DEPENDENCIES += avahi dbus
else
VLC_CONF_OPTS += --disable-bonjour
endif

ifeq ($(BR2_PACKAGE_DBUS),y)
VLC_CONF_OPTS += --enable-dbus
VLC_DEPENDENCIES += dbus
else
VLC_CONF_OPTS += --disable-dbus
endif

ifeq ($(BR2_PACKAGE_DIRECTFB),y)
VLC_CONF_OPTS += --enable-directfb
VLC_DEPENDENCIES += directfb
else
VLC_CONF_OPTS += --disable-directfb
endif

ifeq ($(BR2_PACKAGE_FAAD2),y)
VLC_CONF_OPTS += --enable-faad
VLC_DEPENDENCIES += faad2
else
VLC_CONF_OPTS += --disable-faad
endif

ifeq ($(BR2_PACKAGE_FFMPEG),y)
VLC_CONF_OPTS += --enable-avcodec
VLC_DEPENDENCIES += ffmpeg
else
VLC_CONF_OPTS += --disable-avcodec
endif

ifeq ($(BR2_PACKAGE_FFMPEG_POSTPROC),y)
VLC_CONF_OPTS += --enable-postproc
else
VLC_CONF_OPTS += --disable-postproc
endif

ifeq ($(BR2_PACKAGE_FFMPEG_SWSCALE),y)
VLC_CONF_OPTS += --enable-swscale
else
VLC_CONF_OPTS += --disable-swscale
endif

ifeq ($(BR2_PACKAGE_FLAC),y)
VLC_CONF_OPTS += --enable-flac
VLC_DEPENDENCIES += flac
else
VLC_CONF_OPTS += --disable-flac
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
VLC_CONF_OPTS += --enable-glx
VLC_DEPENDENCIES += libgl
else
VLC_CONF_OPTS += --disable-glx
endif

ifeq ($(BR2_PACKAGE_OPUS),y)
VLC_CONF_OPTS += --enable-opus
VLC_DEPENDENCIES += libvorbis opus
else
VLC_CONF_OPTS += --disable-opus
endif

ifeq ($(BR2_PACKAGE_LIBASS),y)
VLC_CONF_OPTS += --enable-libass
VLC_DEPENDENCIES += libass
else
VLC_CONF_OPTS += --disable-libass
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
VLC_CONF_OPTS += --enable-libgcrypt
VLC_DEPENDENCIES += libgcrypt
VLC_CONF_ENV += \
	GCRYPT_CONFIG="$(STAGING_DIR)/usr/bin/libgcrypt-config"
else
VLC_CONF_OPTS += --disable-libgcrypt
endif

ifeq ($(BR2_PACKAGE_LIBMAD),y)
VLC_CONF_OPTS += --enable-mad
VLC_DEPENDENCIES += libmad
else
VLC_CONF_OPTS += --disable-mad
endif

ifeq ($(BR2_PACKAGE_LIBMODPLUG),y)
VLC_CONF_OPTS += --enable-mod
VLC_DEPENDENCIES += libmodplug
else
VLC_CONF_OPTS += --disable-mod
endif

ifeq ($(BR2_PACKAGE_LIBMPEG2),y)
VLC_CONF_OPTS += --enable-libmpeg2
VLC_DEPENDENCIES += libmpeg2
else
VLC_CONF_OPTS += --disable-libmpeg2
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
VLC_CONF_OPTS += --enable-png
VLC_DEPENDENCIES += libpng
else
VLC_CONF_OPTS += --disable-png
endif

ifeq ($(BR2_PACKAGE_LIBRSVG),y)
VLC_CONF_OPTS += --enable-svg
VLC_DEPENDENCIES += librsvg
else
VLC_CONF_OPTS += --disable-svg
endif

ifeq ($(BR2_PACKAGE_LIBTHEORA),y)
VLC_CONF_OPTS += --enable-theora
VLC_DEPENDENCIES += libtheora
else
VLC_CONF_OPTS += --disable-theora
endif

ifeq ($(BR2_PACKAGE_LIBUPNP),y)
VLC_CONF_OPTS += --enable-upnp
VLC_DEPENDENCIES += libupnp
else
VLC_CONF_OPTS += --disable-upnp
endif

ifeq ($(BR2_PACKAGE_LIBVORBIS),y)
VLC_CONF_OPTS += --enable-vorbis
VLC_DEPENDENCIES += libvorbis
else
VLC_CONF_OPTS += --disable-vorbis
endif

ifeq ($(BR2_PACKAGE_LIBV4L),y)
VLC_CONF_OPTS += --enable-v4l2
VLC_DEPENDENCIES += libv4l
else
VLC_CONF_OPTS += --disable-v4l2
endif

ifeq ($(BR2_PACKAGE_LIBXCB),y)
VLC_CONF_OPTS += --enable-xcb
VLC_DEPENDENCIES += libxcb
else
VLC_CONF_OPTS += --disable-xcb
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
VLC_CONF_OPTS += --enable-libxml2
VLC_DEPENDENCIES += libxml2
else
VLC_CONF_OPTS += --disable-libxml2
endif

# live555 installs a static library only, and vlc tries to link it into a
# shared library - which doesn't work. So only enable live555 if static.
ifeq ($(BR2_PACKAGE_LIVE555)$(BR2_PREFER_STATIC_LIB),yy)
VLC_CONF_OPTS += --enable-live555
VLC_DEPENDENCIES += live555
VLC_CONF_ENV += \
	LIVE555_CFLAGS="\
		-I$(STAGING_DIR)/usr/include/live \
		-I$(STAGING_DIR)/usr/include/live/BasicUsageEnvironment \
		-I$(STAGING_DIR)/usr/include/live/groupsock \
		-I$(STAGING_DIR)/usr/include/live/liveMedia \
		-I$(STAGING_DIR)/usr/include/live/UsageEnvironment \
		" \
	LIVE555_LIBS="-L$(STAGING_DIR)/usr/lib -lliveMedia"
else
VLC_CONF_OPTS += --disable-live555
endif

ifeq ($(BR2_PACKAGE_LUA),y)
VLC_CONF_OPTS += --enable-lua
VLC_DEPENDENCIES += lua host-lua
else
VLC_CONF_OPTS += --disable-lua
endif

ifeq ($(BR2_PACKAGE_QT_GUI_MODULE),y)
VLC_CONF_OPTS += --enable-qt
VLC_CONF_ENV += \
       ac_cv_path_MOC=$(HOST_DIR)/usr/bin/moc \
       ac_cv_path_RCC=$(HOST_DIR)/usr/bin/rcc \
       ac_cv_path_UIC=$(HOST_DIR)/usr/bin/uic
VLC_DEPENDENCIES += qt
else
VLC_CONF_OPTS += --disable-qt
endif

ifeq ($(BR2_PACKAGE_SDL_X11),y)
VLC_CONF_OPTS += --enable-sdl
VLC_DEPENDENCIES += sdl
else
VLC_CONF_OPTS += --disable-sdl
endif

ifeq ($(BR2_PACKAGE_SDL_IMAGE),y)
VLC_CONF_OPTS += --enable-sdl-image
VLC_DEPENDENCIES += sdl_image
else
VLC_CONF_OPTS += --disable-sdl-image
endif

ifeq ($(BR2_PACKAGE_SPEEX),y)
VLC_CONF_OPTS += --enable-speex
VLC_DEPENDENCIES += speex
else
VLC_CONF_OPTS += --disable-speex
endif

ifeq ($(BR2_PACKAGE_TREMOR),y)
VLC_CONF_OPTS += --enable-tremor
VLC_DEPENDENCIES += tremor
else
VLC_CONF_OPTS += --disable-tremor
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
VLC_CONF_OPTS += --enable-udev
VLC_DEPENDENCIES += udev
else
VLC_CONF_OPTS += --disable-udev
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
VLC_CONF_OPTS += --with-x
VLC_DEPENDENCIES += xlib_libX11
else
VLC_CONF_OPTS += --without-x
endif

$(eval $(autotools-package))
