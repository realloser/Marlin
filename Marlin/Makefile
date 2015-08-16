PROJECT_DIR = .
ARDMK_DIR = ~/Arduino-Makefile
ARDUINO_DIR = /usr/share/arduino
USER_LIB_PATH := $(PROJECT_DIR)/lib
BOARD_TAG = mega2560
MONITOR_BAUDRATE = 115200
AVR_TOOLS_DIR = /usr
AVRDDUDE = /usr/bin/avrdude
CPPFLAGS = -pedantic -Wall -Wextra
MONITOR_PORT = /dev/ttyACM*
CURRENT_DIR = $(shell basename $(CURDIR))
OBJDIR = $(PROJECT_DIR)/bin/$(BOARD_TAG)/$(CURRENT_DIR)
TARGET=Marlin
ARDUINO_PORT=/dev/ttyACM0
include $(ARDMK_DIR)/Arduino.mk