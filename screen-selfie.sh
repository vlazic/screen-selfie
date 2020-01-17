#!/bin/bash

# install dependencies with: sudo apt install -y scrot ; ln -s -f "$XAUTHORITY" ~/.Xauthority

# test with: sh -c 'XAUTHORITY=~/.Xauthority DISPLAY=:0 ~/scrot.sh'

# add to your cron file 
# */5 * * * * SCREENSHOTS_DIR=~/scrot XAUTHORITY=~/.Xauthority DISPLAY=:0 ~/scrot.sh >> ~/scrot.log 2>&1
# if DISPLAY=:0 doesent work, get your display number with: 
# ps e | sed -rn 's/.* DISPLAY=(:[0-9]*).*/\1/p' | head -1

DEFAULT_JPEG_QUALITY=25
DEFAULT_SCREENSHOTS_DIR=~/scrot
DEFAULT_FILE_TEMPLATE="%Y-%m-%d_%H-%M-%S.jpg"

# if values of following variables are not passed to the 
# script use default ones
SCREENSHOTS_DIR="${SCREENSHOTS_DIR:-$DEFAULT_SCREENSHOTS_DIR}"
JPEG_QUALITY="${JPEG_QUALITY:-$DEFAULT_JPEG_QUALITY}"
FILE_TEMPLATE="${FILE_TEMPLATE:-$DEFAULT_FILE_TEMPLATE}"

# directory where image will be placed
# every day new folder will be created
SCREENSHOTS_TODAY_DIR="${SCREENSHOTS_DIR}/$(date +%F)"

# create directory
mkdir -p "$SCREENSHOTS_TODAY_DIR"

# take screenshoot
scrot	-m -z \
		-q "$JPEG_QUALITY" \
		-b "${SCREENSHOTS_TODAY_DIR}/${FILE_TEMPLATE}"

# if there is a lot of black images you can delete with this line
# (replace image size to match your black image size)
# find "$SCREENSHOTS_DIR" -type f -size -130k -exec rm {} \;