#!/bin/bash
#******************************************************************************
# ZYNTHIAN PROJECT: Zynthian Environment Vars
# 
# Setup Zynthian Environment Variables
# 
# Copyright (C) 2015-2016 Fernando Moyano <jofemodo@zynthian.org>
#
#******************************************************************************
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# For a full copy of the GNU General Public License see the LICENSE.txt file.
# ****************************************************************************

#Audio Config
export SOUNDCARD_NAME="HifiBerry DAC+"
export SOUNDCARD_CONFIG="dtoverlay=hifiberry-dacplus"
export JACKD_OPTIONS="-P 70 -t 2000 -s -d alsa -d hw:0 -r 44100 -p 256 -n 2 -X raw"

#Display Config
export DISPLAY_NAME="PiScreen 3.5 (v2)"
export DISPLAY_CONFIG="dtoverlay=piscreen2r-notouch,rotate=270\ndtoverlay=ads7846,speed=2000000,cs=1,penirq=17,penirq_pull=2,swapxy=1,xohms=100,pmax=255"
export DISPLAY_WIDTH="480"
export DISPLAY_HEIGHT="320"
export FRAMEBUFFER="/dev/fb1"

# Zynthian Features Flags
export ZYNTHIAN_AUBIONOTES="1"
export ZYNTHIAN_TOUCHOSC="1"

# Zynthian Wiring Config
export ZYNTHIAN_WIRING_LAYOUT="MCP23017_ENCODERS"
export ZYNTHIAN_WIRING_ENCODER_A=""
export ZYNTHIAN_WIRING_ENCODER_B=""
export ZYNTHIAN_WIRING_SWITCHES=""

# Zynthian UI Config
export ZYNTHIAN_UI_COLOR_BG="#000000"
export ZYNTHIAN_UI_COLOR_TX="#ffffff"
export ZYNTHIAN_UI_COLOR_ON="#ff0000"
export ZYNTHIAN_UI_COLOR_PANEL_BG="#3a424d"
export ZYNTHIAN_UI_FONT_FAMILY="Audiowide"
export ZYNTHIAN_UI_FONT_SIZE="14"
export ZYNTHIAN_UI_ENABLE_CURSOR="0"
export ZYNTHIAN_UI_RESTORE_LAST_STATE="1"

# MIDI system configuration
export ZYNTHIAN_SCRIPT_MIDI_PROFILE="/zynthian/zynthian-my-data/midi-profiles/default.sh"

# Extra features
export ZYNTHIAN_AUBIONOTES_OPTIONS="-O complex -t 0.5 -s -88  -p yinfft -l 0.5"

# Directory Paths
export ZYNTHIAN_DIR="/zynthian"
export ZYNTHIAN_CONFIG_DIR="$ZYNTHIAN_DIR/config"
export ZYNTHIAN_SW_DIR="$ZYNTHIAN_DIR/zynthian-sw"
export ZYNTHIAN_UI_DIR="$ZYNTHIAN_DIR/zynthian-ui"
export ZYNTHIAN_SYS_DIR="$ZYNTHIAN_DIR/zynthian-sys"
export ZYNTHIAN_DATA_DIR="$ZYNTHIAN_DIR/zynthian-data"
export ZYNTHIAN_MY_DATA_DIR="$ZYNTHIAN_DIR/zynthian-my-data"
export ZYNTHIAN_RECIPE_DIR="$ZYNTHIAN_SYS_DIR/scripts/recipes"
export ZYNTHIAN_PLUGINS_DIR="$ZYNTHIAN_DIR/zynthian-plugins"
export ZYNTHIAN_MY_PLUGINS_DIR="$ZYNTHIAN_DIR/zynthian-my-plugins"
export ZYNTHIAN_PLUGINS_SRC_DIR="$ZYNTHIAN_SW_DIR/plugins"
export LV2_PATH="$ZYNTHIAN_PLUGINS_DIR/lv2:$ZYNTHIAN_MY_PLUGINS_DIR/lv2:$ZYNTHIAN_MY_DATA_DIR/presets/lv2"

# Hardware Architecture & Optimization Options
machine=`uname -m 2>/dev/null`
if [ ${machine} = "armv7l" ]; then
	# default is: RPi3
	CPU="-mcpu=cortex-a53 -mtune=cortex-a53"
	FPU="-mfpu=neon-fp-armv8 -mneon-for-64bits"
	if [ -e "/sys/firmware/devicetree/base/model" ]
	then
		model=$(tr -d '\0' </sys/firmware/devicetree/base/model)
		if [[ ${model} =~ [2] ]]; then
			CPU="-mcpu=cortex-a7 -mtune=cortex-a7"
			FPU="-mfpu=neon-vfpv4"
		fi
	else
		model=""
	fi
	FPU="${FPU} -mfloat-abi=hard -mvectorize-with-neon-quad -ftree-vectorize"
	CFLAGS_UNSAFE="-funsafe-loop-optimizations -funsafe-math-optimizations -ffast-math"
fi
export MACHINE_HW_NAME=$machine
export RBPI_VERSION=$model
export CFLAGS="${CPU} ${FPU}"
export CXXFLAGS=${CFLAGS}
export CFLAGS_UNSAFE
#echo "Hardware Architecture: ${machine}"
#echo "Hardware Model: ${model}"

# Setup / Build Options
export ZYNTHAIN_SETUP_APT_CLEAN="TRUE" # Set TRUE to clean /var/cache/apt during build, FALSE to leave alone
