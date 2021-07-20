#!/bin/sh

rm ~/.config/mimeapps.list
rm ~/.local/share/wallpapers/bg

stow $(ls -d */)

# Update Make Install
umi() { \
    echo "[UPDATE] $1"
    cd ~/soft/"$1"
    git pull
    sudo checkinstall --nodoc -y sudo make install -j
}

umi_all() { \
    umi "devour"
    umi "dragon"
    umi "neovim"
    umi "st"
    
    cd ~/soft/xournalpp
    mkdir build ; cd build
    rm -rf packages
    cmake ..
    cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo --build . -- -j 6
    cmake --build . --target translations -- -j 6
    cmake .. -DCPACK_GENERATOR="DEB"
    cmake --build . --target package -- -j 6
    cd packages
    sudo dpkg -i xournalpp*

    cd ~/soft/digimend-kernel-drivers
    git pull
    # TODO is it necessary to uninstall?
    sudo make dkms_uninstall
    sudo make dkms_install

    cd ~/soft/nnn
    sudo checkinstall --nodoc -y sudo make strip install -j
}

if [ "$1" = "i" ]; then 
    # stuff I use
    sudo apt-get -y install git libnotify-bin jmtpfs unrar unzip p7zip-full maim xwallpaper python3-pip sxiv mpv zathura nnn xfce4-power-manager redshift   

    # theming
    sudo apt-get -y install oxygen-icon-theme   
    pip3 install pywal

    # required for devour
    sudo apt-get -y install libx11-dev

    # required for dragon
    sudo apt-get -y install libgtk-3-dev

    # required for nvim
    sudo apt-get -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl

    # required for st
    sudo apt-get -y install libfontconfig-dev libx11-dev libxft-dev
    
    # required for digimend drives
    sudo apt-get -y install -y "linux-headers-$(uname -r)"

    # required for xournalpp
    sudo apt-get -y install -y "linux-headers-$(uname -r)" dkms
    sudo apt-get -y install cmake libgtk-3-dev libpoppler-glib-dev portaudio19-dev libsndfile-dev libcppunit-dev dvipng texlive libxml2-dev liblua5.3-dev libzip-dev librsvg2-dev gettext lua-lgi

    # required for nnn
    sudo apt-get -y install pkg-config libncursesw5-dev libreadline-dev

    mkdir ~/soft ; cd ~/soft
    git clone https://github.com/salman-abedin/devour/
    git clone https://github.com/mwh/dragon
    git clone https://github.com/neovim/neovim
    git clone https://github.com/lukesmithxyz/st
    git clone https://github.com/DIGImend/digimend-kernel-drivers
    git clone https://github.com/xournalpp/xournalpp
    git clone https://github.com/jarun/nnn

    umi_all
fi

if [ "$1" = "u" ]; then
    umi_all
fi
