#!/usr/bin/env bash

source $HOME/.bashrc

FirefoxPath="$HOME/Library/Application Support/Firefox"
operateId=`mktemp -u XXXXXXXXXX`
tempFile="`date -Idate`.$operateId.tbz2"

echo "========================================="
echo "Progress start"
echo "========================================="

osascript -e 'display notification "Started" with title "Firefox profiles backup"'

echo "========================================="
echo "Start archive files"
echo "========================================="

tar -cjvf "/tmp/backup-firefox-profiles-$tempFile" -C "$FirefoxPath" profiles.ini Profiles 2>&1

echo "========================================="
echo "Start encrypt file"
echo "========================================="

gpg --batch --encrypt -r 'bolasblack@gmail.com' -o ~/OneDrive/Backups/Firefox/$tempFile.gpg /tmp/backup-firefox-profiles-$tempFile 2>&1

if [ $? -eq 0 ]; then
  osascript -e 'display notification "Succeed" with title "Firefox profiles backup"'
else
  osascript -e 'display notification "Failed" with title "Firefox profiles backup"'
fi

echo "========================================="
echo "All finished"
echo "========================================="
