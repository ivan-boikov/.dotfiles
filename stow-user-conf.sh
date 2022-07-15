#!/bin/sh

echo "Cleaning old mimeapps.list"
rm ~/.config/mimeapps.list
echo "Cleaning old user-dirs.dirs"
rm ~/.config/user-dirs.dirs

echo "Stowing configs"
stow -R $(ls -d */)
