################################################################################
#
# freerdp
#
################################################################################

# Changeset on the stable-1.1 branch
FREERDP_VERSION = b21ff842ef3de5837513042dc30488b12bd9cf9d
FREERDP_SITE = $(call github,FreeRDP,FreeRDP,$(FREERDP_VERSION))
FREERDP_DEPENDENCIES = openssl zlib \
	xlib_libX11 xlib_libXt xlib_libXext xlib_libXcursor
FREERDP_LICENSE = Apache-2.0
FREERDP_LICENSE_FILES = LICENSE

FREERDP_CONF_OPTS = -DWITH_MANPAGES=OFF -Wno-dev

ifeq ($(BR2_PACKAGE_GSTREAMER),y)
FREERDP_CONF_OPTS += -DWITH_GSTREAMER=ON
FREERDP_DEPENDENCIES += gstreamer
else
FREERDP_CONF_OPTS += -DWITH_GSTREAMER=OFF
endif

ifeq ($(BR2_PACKAGE_CUPS),y)
FREERDP_CONF_OPTS += -DWITH_CUPS=ON
FREERDP_DEPENDENCIES += cups
else
FREERDP_CONF_OPTS += -DWITH_CUPS=OFF
endif

ifeq ($(BR2_PACKAGE_FFMPEG),y)
FREERDP_CONF_OPTS += -DWITH_FFMPEG=ON
FREERDP_DEPENDENCIES += ffmpeg
else
FREERDP_CONF_OPTS += -DWITH_FFMPEG=OFF
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB_MIXER),y)
FREERDP_CONF_OPTS += -DWITH_ALSA=ON
FREERDP_DEPENDENCIES += alsa-lib
else
FREERDP_CONF_OPTS += -DWITH_ALSA=OFF
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
FREERDP_CONF_OPTS += -DWITH_PULSEAUDIO=ON
FREERDP_DEPENDENCIES += pulseaudio
else
FREERDP_CONF_OPTS += -DWITH_PULSEAUDIO=OFF
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXI),y)
FREERDP_CONF_OPTS += -DWITH_XI=ON
FREERDP_DEPENDENCIES += xlib_libXi
else
FREERDP_CONF_OPTS += -DWITH_XI=OFF
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXINERAMA),y)
FREERDP_CONF_OPTS += -DWITH_XINERAMA=ON
FREERDP_DEPENDENCIES += xlib_libXinerama
else
FREERDP_CONF_OPTS += -DWITH_XINERAMA=OFF
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXKBFILE),y)
FREERDP_CONF_OPTS += -DWITH_XKBFILE=ON
FREERDP_DEPENDENCIES += xlib_libxkbfile
else
FREERDP_CONF_OPTS += -DWITH_XKBFILE=OFF
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXRENDER),y)
FREERDP_CONF_OPTS += -DWITH_XRENDER=ON
FREERDP_DEPENDENCIES += xlib_libXrender
else
FREERDP_CONF_OPTS += -DWITH_XRENDER=OFF
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXV),y)
FREERDP_CONF_OPTS += -DWITH_XV=ON
FREERDP_DEPENDENCIES += xlib_libXv
else
FREERDP_CONF_OPTS += -DWITH_XV=OFF
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
FREERDP_CONF_OPTS += -DWITH_NEON=ON
else
FREERDP_CONF_OPTS += -DWITH_NEON=OFF
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
FREERDP_CONF_OPTS += -DWITH_SSE2=ON
else
FREERDP_CONF_OPTS += -DWITH_SSE2=OFF
endif

ifeq ($(BR2_arm)$(BR2_armeb),y)
FREERDP_CONF_OPTS += -DARM_FP_ABI=$(call qstrip,$(BR2_GCC_TARGET_FLOAT_ABI))
endif

$(eval $(cmake-package))
