# Screen Selfie

Bash script that takes screenshoots in regular intervals

## Installation

```bash
cd ~
wget https://raw.githubusercontent.com/vlazic/screen-selfie/master/screen-selfie.sh
chmod +x screen-selfie.sh
./screen-selfie.sh
# check if everything works with:
sh -c 'XAUTHORITY=~/.Xauthority DISPLAY=:0 ~/screen-selfie.sh'
ls ~/screen-selfie/*
```

## TODO

- add REMOVE_FILES_SMALLER_THEN variable
