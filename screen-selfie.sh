#!/bin/bash

# place this file in your home directory:
# wget -P ~ https://raw.githubusercontent.com/vlazic/screen-selfie/master/screen-selfie.sh
# chmod +x ~/screen-selfie.sh

# install dependencies with: 
# sudo apt install -y scrot 

# create ~/.Xauthority link
# ln -s -f "$XAUTHORITY" ~/.Xauthority

# check if everything works with:
# sh -c 'XAUTHORITY=~/.Xauthority DISPLAY=:0 ~/screen-selfie.sh'
# ls ~/screen-selfie/*

# add to your crontab file:
# */5 * * * * XAUTHORITY=~/.Xauthority DISPLAY=:0 ~/screen-selfie.sh >> ~/screen-selfie.log 2>&1
# if DISPLAY=:0 doesn't work, get your display number with: 
# ps e | sed -rn 's/.* DISPLAY=(:[0-9]*).*/\1/p' | head -1

# you can overwrite default configuration variables by prefixing Cron command
# available configuration variables: SCREENSHOTS_DIR, JPEG_QUALITY, FILE_TEMPLATE

# TODO: create installation script

DEFAULT_JPEG_QUALITY=25
DEFAULT_SCREENSHOTS_DIR=~/screen-selfie
DEFAULT_FILE_TEMPLATE="%Y-%m-%d_%H-%M-%S.jpeg"

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

# take screen-shoot
scrot	-m -z \
		-q "$JPEG_QUALITY" \
		-b "${SCREENSHOTS_TODAY_DIR}/${FILE_TEMPLATE}"

# if there is a lot of black images you can delete with this line
# (replace image size to match your black image size)
# find "$SCREENSHOTS_DIR" -type f -size -130k -exec rm {} \;
# TODO: if there is env variable REMOVE_FILES_SMALLER_THEN automatically perform this step..