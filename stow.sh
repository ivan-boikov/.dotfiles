#!/bin/sh

rm ~/.config/mimeapps.list
rm ~/.config/user-dirs.dirs

stow -R $(ls -d */)

doas ln -s "$HOME/.local/bin/protonmail-bridge" "/etc/init.d/protonmail-bridge"
