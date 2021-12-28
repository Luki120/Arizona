export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:latest

TWEAK_NAME = Arizona

Arizona_FILES = Arizona.x
Arizona_CFLAGS = -fobjc-arc

SUBPROJECTS += ArizonaPrefs

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "sbreload"
