#!/bin/bash

SRCDIR="$HOME/.local/src/"

if [ "$1" = "-f" ]; then
  # cleaning Firefox, schizo-style
  # https://12bytes.org/articles/tech/firefox/firefoxgecko-configuration-guide-for-privacy-and-performance-buffs/
  doas rm -v /usr/lib/firefox/browser/features/*.xpi

  cp -r ~/.mozilla ~/.mozilla.bak

  cd ~/.mozilla
  FFPATH=$(dirname $(find ~/.mozilla -wholename "*release/prefs.js"));
  cd "$FFPATH"
  rm -f updater.sh prefsCleaner.sh user-overrides.js
  wget https://raw.githubusercontent.com/arkenfox/user.js/master/updater.sh
  wget https://raw.githubusercontent.com/arkenfox/user.js/master/prefsCleaner.sh
  wget https://raw.githubusercontent.com/ivan-boikov/user-overrides.js/master/user-overrides.js
  chmod +x updater.sh
  chmod +x prefsCleaner.sh
  bash updater.sh
  bash prefsCleaner.sh
fi
