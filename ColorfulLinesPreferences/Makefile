ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ColorfulLinesPreferences

ColorfulLinesPreferences_FILES = CFLRootListController.m CFLSwitchCell.m
ColorfulLinesPreferences_INSTALL_PATH = /Library/PreferenceBundles
ColorfulLinesPreferences_FRAMEWORKS = UIKit
ColorfulLinesPreferences_PRIVATE_FRAMEWORKS = Preferences
ColorfulLinesPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ColorfulLinesPreferences.plist$(ECHO_END)