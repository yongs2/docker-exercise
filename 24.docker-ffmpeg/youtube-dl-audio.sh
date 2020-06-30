#!/bin/sh

echo "Downloading...$1"
/usr/local/bin/youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 ${1}
echo "Done."
