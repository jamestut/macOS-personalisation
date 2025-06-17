#!/usr/bin/env zsh
if [[ `id -u` -ne 0 ]]
then
    echo "Please run this script as root!"
    exit 1
fi

echo "Disabling search indexer ..."
mdutil -a -i off

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
