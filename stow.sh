#!/bin/sh

rm ~/.config/mimeapps.list
rm ~/.config/user-dirs.dirs

stow -R $(ls -d */)
