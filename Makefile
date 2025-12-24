# Comando mestre para ignorar erros de avisos
GO_EASY_ON_ME = 1
DEBUG = 0
FINALPACKAGE = 1

ARCHS = arm64
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MenuESP
MenuESP_FILES = MenuESP.mm
MenuESP_FRAMEWORKS = UIKit Foundation QuartzCore
MenuESP_CFLAGS = -fobjc-arc -w

include $(THEOS)/makefiles/tweak.mk
