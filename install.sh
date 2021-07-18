#!/bin/sh
rm ~/.config/mimeapps.list
stow $(ls -d */)
