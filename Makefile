ARCHS = arm64 arm64e

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorfulLines

ColorfulLines_FILES = Tweak.x
ColorfulLines_CFLAGS = -fobjc-arc
ColorfulLines_LIBRARIES = sparkcolourpicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += colorfullinespreferences
include $(THEOS_MAKE_PATH)/aggregate.mk
