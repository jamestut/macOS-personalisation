#!/usr/bin/env zsh
if [[ `id -u` -ne 0 ]]
then
    echo "Please run this script as root!"
    exit 1
fi

echo "Disabling search indexer ..."
mdutil -a -i off
touch /System/Volumes/Data/.metadata_never_index

echo "Disabling automatic updates ..."
defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool false
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool false
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool false
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool false
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool false
defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool false

echo "Disabling font smoothing ..."
sudo defaults -currentHost write -g AppleFontSmoothing -int 0

echo "Setting root shell to zsh ..."
chsh -s /bin/zsh root

echo "Installing key remapping LaunchDaemon ..."
SCRIPT_DIR="${0:A:h}"
PLIST_SRC="$SCRIPT_DIR/payloads/com.local.KeyRemapping.plist"
PLIST_DST="/Library/LaunchDaemons/com.local.KeyRemapping.plist"
cp "$PLIST_SRC" "$PLIST_DST"
chown root:wheel "$PLIST_DST"
chmod 644 "$PLIST_DST"
launchctl load -w "$PLIST_DST"
