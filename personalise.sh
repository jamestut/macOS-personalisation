#!/usr/bin/env zsh
# env
cd "${0:a:h}"
PREF_DIR=~/Library/Preferences

if [[ `id -u` -eq 0 ]]
then
    echo "Do not run this script as root!"
    exit 1
fi

echo "Adjusting trackpad settings ..."
defaults write -g com.apple.trackpad.scaling -int 3
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0

echo "Adjusting mouse settings ..."
defaults write -g com.apple.mouse.scaling 3
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton

echo "Adjusting keyboard settings ..."
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

echo "Adjusting keyboard text settings ..."
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g ApplePressAndHoldEnabled -bool false
echo "Note: please manually delete default text replacement entries!"
defaults write -g NSUserDictionaryReplacementItems ""

echo "Adjusting Finder settings ..."
defaults write -g AppleShowAllExtensions true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle Nlsv
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "Adjusting Dock and Mission Control settings ..."
defaults write com.apple.Dock mru-spaces -bool false
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.dock mineffect -string scale

echo "Adjusting window manager settings ..."
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

echo "Adjusting menubar settings ..."
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true
defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

echo "Adjusting Terminal settings ..."
defaults write com.apple.Terminal NSWindowTabbingShoudShowTabBarKey-TTWindow-TTWindowController-TTWindowController-VT-FS 1
open prefs/MyTerm.terminal
defaults write com.apple.terminal "Default Window Settings" -string "MyTerm"
defaults write com.apple.Terminal "Startup Window Settings" -string "MyTerm"

echo "Adjusting font smoothing settings ..."
defaults -currentHost write -g AppleFontSmoothing -int 0

echo "Preparing other scripts in this repo ..."
chmod a+x disablesudopasswd.py

echo "Setting up preferences ..."
for PREF_FILE in com.apple.symbolichotkeys.plist com.lwouis.alt-tab-macos.plist
do
    rm -f $PREF_DIR/$PREF_FILE
    if defaults read $PREF_FILE
    then
        echo "Preference reset failed!"
        exit 1
    fi
    cp prefs/$PREF_FILE $PREF_DIR/$PREF_FILE
    defaults read $PREF_FILE &> /dev/null
done

echo "Done! Please logoff now!"
