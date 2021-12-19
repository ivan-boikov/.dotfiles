#!/bin/sh

SRCDIR="$HOME/.local/src/"

rm ~/.config/mimeapps.list
rm ~/.local/share/wallpapers/bg
mkdir -p "$SRCDIR"

stow $(ls -d */)

# Update Make Install
umi() { \
    branch=${2:-master}
    echo "[UPDATE] $1 $branch"
    cd "$SRCDIR/$1"
    git pull
    git checkout "$branch"
    make -j
    sudo checkinstall --nodoc -y sudo make "$3" install
}

umi_all() { \
    umi "ly"
    umi "dwm" "master"
    umi "dwmblocks"
    umi "st"
    umi "neovim"
    umi "nnn" "master" "strip"
    umi "devour"
    umi "dragon"

    cd "$SRCDIR/digimend-kernel-drivers"
    git pull
    # TODO is it necessary to uninstall?
    sudo make dkms_uninstall
    sudo make dkms_install

    cd "$SRCDIR/xournalpp"
    mkdir build ; cd build
    rm -rf packages
    cmake ..
    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo --build . -- -j 6
    cmake --build . --target translations -- -j 6
    cmake .. -DCPACK_GENERATOR="DEB"
    cmake --build . --target package -- -j 6
    cd packages
    sudo dpkg -i xournalpp*
}

if [ "$1" = "i" ]; then
    # system
    sudo apt-get -y install libnotify-bin jmtpfs maim xwallpaper python3-pip xfce4-power-manager redshift i3lock dmenu suckless-tools pass git picom
    # media
    sudo apt-get -y install sxiv mpv ncmpcpp mpd ffmpeg pulseeffects
    # web
    sudo apt-get -y install firefox chromium thunderbird
    # office
    sudo apt-get -y install git unrar unzip p7zip-full zathura texlive virt-manager
    # theming
    sudo apt-get -y install oxygen-icon-theme sox imagemagick
    pip3 install pywal

    # required for ly
    sudo apt-get -y install build-essential libpam0g-dev libxcb-xkb-dev

    # required for st and dwm
    sudo apt-get -y install libfontconfig-dev libx11-dev libxft-dev

    # required for nvim
    sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl

    # required for devour
    sudo apt-get -y install libx11-dev

    # required for dragon
    sudo apt-get -y install libgtk-3-dev

    # required for digimend drives
    sudo apt-get -y install -y "linux-headers-$(uname -r)"

    # required for xournalpp
    sudo apt-get -y install -y "linux-headers-$(uname -r)" dkms
    sudo apt-get -y install cmake libgtk-3-dev libpoppler-glib-dev portaudio19-dev libsndfile-dev libcppunit-dev dvipng texlive libxml2-dev liblua5.3-dev libzip-dev librsvg2-dev gettext lua-lgi

    # required for nnn
    sudo apt-get -y install pkg-config libncursesw5-dev libreadline-dev

    cd "$SRCDIR"
    git clone https://github.com/nullgemm/ly
    git clone https://github.com/ivan-boikov/dwm
    git clone https://github.com/ivan-boikov/dwmblocks
    git clone https://github.com/lukesmithxyz/st
    git clone https://github.com/neovim/neovim
    git clone https://github.com/jarun/nnn
    # is it necessary with dwm swallow patch?
    git clone https://github.com/salman-abedin/devour
    git clone https://github.com/mwh/dragon
    git clone https://github.com/DIGImend/digimend-kernel-drivers
    git clone https://github.com/xournalpp/xournalpp

    umi_all
fi

if [ "$1" = "u" ]; then
    umi_all
fi
