ARCHS = arm64 arm64e

TARGET = iphone:clang:13.5::12.0

INSTALL_TARGET_PROCESSES = backboardd

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ColorfulLines

ColorfulLines_FILES = Tweak.x Swift/Extensions/UIImageColor.swift
ColorfulLines_CFLAGS = -fobjc-arc
ColorfulLines_LIBRARIES = sparkcolourpicker

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += ColorfulLinesPreferences
include $(THEOS_MAKE_PATH)/aggregate.mk