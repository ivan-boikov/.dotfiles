#!/bin/sh

echo "Installing ProtonMail Bridge OpenRC service file"
ln -s "$HOME/.local/bin/protonmail-bridge" "/etc/init.d/protonmail-bridge"
