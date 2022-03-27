#!/bin/bash

SRCDIR="$HOME/.local/src/"

rm ~/.config/mimeapps.list
rm ~/.config/user-dirs.dirs
mkdir -p "$SRCDIR"

if [ -z $(command -v stow) ]; then
    sudo apt-get -y install stow
fi

stow -R -v $(ls -d */)

ln -sf ~/.local/share/wallpapers/mountains.jpg ~/.local/share/wallpapers/bg

# yes/no dialog
# https://gist.github.com/davejamesmiller/1965569
ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}


# Update Make Install
umi() { \
    if [[ ! -d "$SRCDIR/$1" ]]; then
        echo "$1 not found, skipping"
        return
    fi

    branch=${2:-master}
    makeargs=${4:-}
    echo "[UPDATE] $1 $branch"
    cd "$SRCDIR/$1"
    git pull
    git checkout "$branch"
    make "$makeargs" -j
    if [ -z "$3" ]; then
        sudo checkinstall --nodoc -y sudo make install
    else
        sudo checkinstall --nodoc -y sudo make "$3" install
    fi
}

umi_pamixer() { \
    if [[ ! -d "$SRCDIR/pamixer" ]]; then
        echo "pamixer not found, skipping"
        return
    fi
    cd "$SRCDIR/pamixer"
    git pull
    meson setup build
    meson compile -C build
    sudo meson install -C build
}

umi_digimend() { \
    if [[ ! -d "$SRCDIR/digimend-kernel-drivers" ]]; then
        echo "digimend not found, skipping"
        return
    fi
    cd "$SRCDIR/digimend-kernel-drivers"
    git pull
    # TODO is it necessary to uninstall?
    sudo make dkms_uninstall
    sudo make dkms_install
}

umi_xournalpp() { \
    if [[ ! -d "$SRCDIR/xournalpp" ]]; then
        echo "xournalpp not found, skipping"
        return
    fi
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

umi_oomox() { \
    if [[ ! -d "$SRCDIR/oomox" ]]; then
        echo "oomox not found, skipping"
        return
    fi
    cd "$SRCDIR/oomox"
    make -f po.mk install
}

umi_all() { \
    umi "ly"
    umi "dwm" "patched-config"
    umi "dwmblocks"
    umi "st"
    umi "neovim"
    umi "nnn" "master" "strip" "O_CTX8=1"
    umi "devour"
    umi "dragon"

    umi_pamixer
    umi_digimend
    umi_xournalpp
    umi_oomox
}

if [ "$1" = "-i" ]; then
    # system
    #dbus-x11 -> dbus-broker
    sudo apt-get install xserver-xorg dbus-broker lm-sensors xclip python2 python3 python3-pip gdebi virtualenv gawk xdotool zsh libnotify-bin jmtpfs maim xfce4-power-manager redshift i3lock dmenu suckless-tools pass pass-git-helper git trash-cli htop network-manager rsync ncdu shellcheck net-tools arp-scan resolvconf
    python3 -m pip install --user --upgrade pynvim
    # media
    sudo apt-get install alsa-tools sxiv mpv ncmpcpp mpd mpv ffmpeg syncthing playerctl fzf mediainfo samba smbclient
    # TODO migrate to pipewire for good
    sudo apt-get install pulseaudio
    # sudo apt-get install pipewire wireplumber pipewire-pulse
    sudo apt-get install pulseeffects
    # web
    sudo apt-get install firefox
    sudo apt-get install chromium
    sudo apt-get install thunderbird
    # office
    sudo apt-get install git unrar unzip p7zip-full zathura zathura-pdf zathura-ps texlive latexmk virt-manager gnome-keyring
    # theming
    sudo apt-get install oxygen-icon-theme sox imagemagick lxappearance xwallpaper fonts-symbola fonts-liberation fonts-font-awesome compton dunst
    pip3 install pywal


    cd "$SRCDIR"

    # required for ly
    sudo apt-get install build-essential libpam0g-dev libxcb-xkb-dev
    if [ ! -d ly ]; then
	git clone --recurse-submodules https://github.com/nullgemm/ly.git
    fi

    # required for st, dwm and dwmblocks
    sudo apt-get install libfontconfig-dev libx11-dev libxft-dev
    # required for dwm
    sudo apt-get install libx11-xcb-dev libxcb-res0-dev
    if [ ! dwm ]; then
    	git clone https://github.com/ivan-boikov/dwm
    fi
    if [ ! dwmblocks ]; then
	git clone https://github.com/ivan-boikov/dwmblocks
    fi
    if [ ! st ]; then
    	git clone https://github.com/lukesmithxyz/st
    fi

    # required for neovim
    sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curlgit
    if [! -d neovim ]; then
	git clone https://github.com/neovim/neovim
    fi

    # required for nnn
    sudo apt-get install pkg-config libncursesw5-dev libreadline-dev
    if [ ! -d nnn ]; then
    	git clone https://github.com/jarun/nnn
    fi

    # required for pamixer
    sudo apt-get install meson libboost-dev libpulse0 libpulse-dev
    if [ ! -d pamixer ]; then
    	git clone https://github.com/cdemoulins/pamixer
    fi

    # required for devour
    sudo apt-get install libx11-dev
    # is it necessary with dwm swallow patch?
    if [ ! -d devour ]; then
    	git clone https://github.com/salman-abedin/devour
    fi

    # dragon
    sudo apt-get install libgtk-3-dev
    if [ ! -d dragon ]; then
    	git clone https://github.com/mwh/dragon
    fi

    # digimend drivers
    if ask "Install DIGImend drivers?"; then
        sudo apt-get install "linux-headers-$(uname -r)"
	if [ ! -d digimend-kernel-drivers ]; then
            git clone https://github.com/DIGImend/digimend-kernel-drivers
	fi
    fi

    # xournalpp
    if ask "Install xournalpp?"; then
        sudo apt-get install "linux-headers-$(uname -r)" dkms
        sudo apt-get install cmake libgtk-3-dev libpoppler-glib-dev portaudio19-dev libsndfile-dev libcppunit-dev dvipng texlive libxml2-dev liblua5.3-dev libzip-dev librsvg2-dev gettext lua-lgi
	if [ ! -d xournalpp ]; then
            git clone https://github.com/xournalpp/xournalpp
	fi
    fi

    # required for oomox
    if ask "Install oomox theming engine?"; then
        sudo apt-get install python3-gi python3-gi-cairo libglib2.0-bin libgdk-pixbuf2.0-dev libxml2-utils x11-xserver-utils gir1.2-gtk-3.0 gir1.2-glib-2.0 gir1.2-pango-1.0 gir1.2-gdkpixbuf-2.0 gtk2-engines gtk2-engines-murrine gtk2-engines-pixbuf bash bc sed grep parallel sassc libsass1 imagemagick optipng librsvg2-bin inkscape python3-pillow python3-pystache python3-yaml make automake libgtk-3-dev
	if [ ! -d oomox ]; then
             git clone https://github.com/themix-project/oomox --recursive
	fi
    fi

    umi_all
fi

if [ "$1" = "-u" ]; then
    umi_all
fi

if [ "$1" = "-f" ]; then
    # cleaning Firefox, schizo-style
    # https://12bytes.org/articles/tech/firefox/firefoxgecko-configuration-guide-for-privacy-and-performance-buffs/
    if ask "Schizofy firefox?"; then
        sudo cd /usr/lib/firefox/browser/features
        sudo rm *.xpi

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
fi

if [ "$1" = "nvim" ]; then
    # update nvim plugins
    nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
fi
