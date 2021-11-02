#!/usr/bin/env bash

DEFAULT_JPEG_QUALITY=25
DEFAULT_SCREENSHOTS_DIR="${HOME}/screen-selfie"
DEFAULT_FILE_TEMPLATE="%Y-%m-%d_%H-%M-%S.jpeg"
CRON_FILE="/etc/cron.d/screen-selfie"

# if values of following variables are not passed to the
# script use default ones
SCREENSHOTS_DIR="${SCREENSHOTS_DIR:-$DEFAULT_SCREENSHOTS_DIR}"
JPEG_QUALITY="${JPEG_QUALITY:-$DEFAULT_JPEG_QUALITY}"
FILE_TEMPLATE="${FILE_TEMPLATE:-$DEFAULT_FILE_TEMPLATE}"

command -v scrot >/dev/null 2>&1 || {
	sudo apt install -y scrot
}

# if ~/.Xauthority file is missing create it
if [ ! -f ~/.Xauthority ]; then
	echo "Creating ~/.Xauthority file"
	ln -s -f "$XAUTHORITY" "${HOME}/.Xauthority"
fi

if [ ! -f $CRON_FILE ]; then
	echo "Creating cron file"

	# you can overwrite default configuration variables by prefixing Cron command
	# available configuration variables: SCREENSHOTS_DIR, JPEG_QUALITY, FILE_TEMPLATE
	echo "*/5 * * * * ${USER} XAUTHORITY=${HOME}/.Xauthority DISPLAY=$(ps e | sed -rn 's/.* DISPLAY=(:[0-9]*).*/\1/p' | head -1)  ${0} | logger -t screen-selfie 2>&1" |
		sudo tee $CRON_FILE && echo "Cron file created"

	sudo chmod +x $CRON_FILE
fi

# directory where image will be placed
# every day new folder will be created
SCREENSHOTS_TODAY_DIR="${SCREENSHOTS_DIR}/$(date +%F)"

# create directory
mkdir -p "$SCREENSHOTS_TODAY_DIR"

# take screen-shoot
scrot -m -z \
	-q "$JPEG_QUALITY" \
	-b "${SCREENSHOTS_TODAY_DIR}/${FILE_TEMPLATE}"

# if there is a lot of black images you can delete with this line
# (replace image size to match your black image size)
# find "$SCREENSHOTS_DIR" -type f -size -130k -exec rm {} \;
# TODO: if there is env variable REMOVE_FILES_SMALLER_THEN automatically perform this step..
