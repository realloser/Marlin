# Hi all,
# I've been playing around with firmware lately (mostly just trying some of the features of Marlin, nothing exciting - yet). I got frustrated dealing with having to open the e-tray, turn everything off, plug into the RUMBA, turn the RUMBA on, upload, turn off the RUMBA, unplug the RUMBA, turn everything back on and wait to find out that I messed up a setting. So I came up with the following method to do upgrades from the printer's onboard computer (the BBB). It makes the upgrades faster and simpler. It also has the advantage of being something you can do remotely.
# 
# Here's what you'll need:
# - An SSH client
# - Marlin source code (Fetch official TAM with config included from https://bitbucket.org/typeamachines/ser ... /downloads)
# 
# Steps:
# 1. Log into the printer with the ssh client. If you reach your printer's web interface at series1-1121.local:5000, you want to ssh to series1-1121.local. Your username and password are both ubuntu.
# 
# 2. Install required packages:
# $ sudo apt-get install arduino-mk make libyaml-perl libdevice-serialport-perl
# 
# 3. Fetch the Marlin source. Due to some formatting issue, it can't be unzipped on the series1 itself. Unzip it elsewhere and use scp or sftp to copy it over. (I'm still working on this one - if I can make it work, the entire upgrade can be scripted)
# 
# 4. Change into the (inner) Marlin folder, and put the appropriate text into a Makefile
# $ cd Marlin*/Marlin
# $ echo 'PROJECT_DIR = .
# ARDMK_DIR = /usr/share/arduino
# ARDUINO_DIR = /usr/share/arduino
# USER_LIB_PATH := $(PROJECT_DIR)/lib
# BOARD_TAG = mega2560
# MONITOR_BAUDRATE = 115200
# AVR_TOOLS_DIR = /usr
# AVRDDUDE=/usr/bin/avrdude
# CFLAGS_STD= -std=gnu11
# CXXFLAGS_STD= -std=gnu++11
# CXXFLAGS+= -pedantic -Wall -Wextra
# MONITOR_PORT=/dev/tty.usbmodem*
# CURRENT_DIR=$(shell basename $(CURDIR))
# OBJDIR=$(PROJECT_DIR)/bin/$(BOARD_TAG)/$(CURRENT_DIR)
# TARGET=Marlin
# ARDUINO_PORT=/dev/ttyACM0
# include $(ARDMK_DIR)/Arduino.mk' > Makefile
# 
# 5. Actually build the project:
# $ PATH=$PATH:/usr/share/arduino/ make
# 
# 6. Disconnect Octoprint from the RUMBA. There are two ways of doing this. In the web interface, pull down the "Connection" box on the left and hit "Disconnect" Alternatively run:
# $ sudo service octoprint stop
# 
# Frankly, disconnecting octoprint in the web interface is the better option. You don't have to wait for the whole thing to start back up afterwards if you use the web interface.
# 
# 7. Upload to the RUMBA:
# $ sudo PATH=$PATH:/usr/share/arduino/ make upload
# 
# 8. Reconnect octoprint. Either press "Connect" in the web interface or run:
# $ sudo service octoprint start
# 
# 9. Sometimes the whole system will require a restart afterwards because something got whacky. If you're having issues after uploading new firmware, running this will restart the whole machine, hopefully resetting away the issue. (It hasn't failed for me yet):
# $ sudo shutdown -r now
# 
# Please let me know if this is useful, needs more detail, clarification or correction.
# 
# Steve
# 
# Sources used:
# https://github.com/sudar/Arduino-Makefile (Main arduino-mk documentation)
# https://github.com/sudar/Arduino-Makefi ... example.mk (Makefile contents)
# http://www.martyndavis.com/?p=335 (Verification and guidance on ard-parse-boards not being found, though solution is my own
# http://www.deanmao.com/2012/08/10/uploa ... on-the-pi/

PATH=$PATH:/usr/share/arduino/ make

sudo PATH=$PATH:/usr/share/arduino/ make upload