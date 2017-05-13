#!/bin/bash

###############################################################################
# Post-install Setup
###############################################################################
#
# Usage: sudo sh setup.sh <username>
#
# Run from your home!
#
# 1. Script Setup
# 2. Utilities
#
###############################################################################

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

################################################################################
# Script Setup
################################################################################
# Package Manager setup
# Rather than separating package managers by nanme and using a global
# PKG_MGR variable that would need specialized options (for example -S
# for pacman or install -y for apt-get) multiple variables will be created
# according to the functionality required

# Debian (apt-get)
if [ `uname -a | awk '{print $6}'` ]
then
    PKG_INSTALL='apt-get install -y'
fi

# Usage: install-package <package-name>
install_package () {
    if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null |  \
           grep -c "ok installed")  -eq 0 ];
    then
        $PKG_INSTALL $1
        echo "$1 has been installed!"
    else
        echo "$1 has already been installed, skipping..."
    fi
}

# Usage: check_config <config-file-name>
check_config () {
    if [ -e $1 ];
    then
        PROMPT="Config file $1 already exists, do you want to overwrite it? [y/N]"
        echo -n "$PROMPT "
        read confirmation

        while true;
        do
            if [ "$confirmation" = "y"  -o "$confirmation" = "Y" ];
            then
                mv $1 $1.old
                echo "$1 has been backed up to $1.old"
                mv dotfiles/$1 .
                echo '$1 has been overwritten'
                break
            elif [ "$confirmation" = "n" -o "$confirmation" = "N" ];
            then
                echo "Skipping $1 config..."
                break
            else
                echo "Please enter a valid option (y or N)"
                echo -n "$PROMPT "
                read confirmation
            fi
        done
    else
        mv dotfiles/$1 .
        echo '$1 has installed!'
    fi
}

################################################################################
# Utilities
################################################################################
# Vim (custom build)
# Must update python and ncurses for compilation
install_package python-dev
install_package ncurses-dev wget
if [ ! `vim --version | grep +python | wc -l` -eq 1 ]
then
    wget "ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2" && tar xvjf vim-7.4.tar.bz2
    cd vim74
    ./configure --with-features=huge --enable-pythoninterp \
                --with-python-config-dir=/usr/lib/python2.7/\
                config-x86_64-linux-gnu/
    make && make install
    cd && rm -rf vim74
    echo "Vim 7.4 has been installed!"
else
    echo "Vim 7.4 has already been installed, skipping..."
fi
# pip
install_package python-pip
# Powerline
if [ ! `pip freeze | grep powerline | wc -l` -eq 1 ]
then
    sudo -H -u $1 -c 'pip install --user git+git://github.com/powerline/powerline'
    echo "powerline has been installed!"
else
    echo "powerline is already present, skipping..."
fi

# Tmux
install_package tmux
# Tmux tpm
if [ -d $USER_HOME/.tmux/plugins/tpm ]
then
    echo "tpm is already present, skipping..."
else
    echo "Installing tpm..."
    git clone --quiet https://github.com/tmux-plugins/tpm \
                      $USER_HOME/.tmux/plugins/tpm 2>&1
    echo "tpm has been installed!"
fi
# urlview for tmux-urlview
install_package urlview

# Git
install_package git
# urxvt (the nice one)
install_package rxvt-unicode-256color
# urxvt-perl extensions
URXVT_EXTENSIONS="/usr/lib/urxvt/perl/clipboard \
                  /usr/lib/urxvt/perl/keyboard-select \
                  /usr/lib/urxvt/perl/url-select"
if [ `ls $URXVT_EXTENSIONS 2>/dev/null | wc -l` -eq 3 ]
then
    echo "urxvt extensions have been installed, skipping..."
else
    git clone --quiet https://github.com/muennich/urxvt-perls 2>&1
    mv urxvt-perls/clipboard \
       urxvt-perls/keyboard-select \
       urxvt-perls/url-select /usr/lib/urxvt/perl/
    rm -fr urxvt-perls
    echo "urxvt-perls installed!"
fi

################################################################################
# WM
################################################################################
install_package i3
install_package i3blocks
# Default to .xinitrc as the WM init file
if [ -f /etc/slim.conf ]
then
    sed -i -e 's/^login_cmd/#login_cmd/' /etc/slim.conf
    echo "slim detected, login_cmd has been disabled in order to start session from .xinitrc"
fi

# Install i3 gaps
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
mkdir -p build && cd build/
../configure
make && make install

################################################################################
# Configs
################################################################################
# The concept for the configs is get the repo and then determine what files are
# needed, then remove it once all of the files have been copied
sudo -H -u $1 /bin/bash -c 'git clone --quiet https://github.com/pmjonesg/dotfiles 2>&1'

# .vimrc
if [ ! -d $USER_HOME/.vim/bundle/vundle ]
then
    git clone --quiet https://github.com/VundleVim/Vundle.vim.git $USER_HOME/.vim/bundle/vundle 2>&1
    echo "Vundle was installed!"
fi
check_config .vimrc
# Install plugins
#vim +PluginInstall
#.tmux.conf
check_config .tmux.conf
# .Xresources
check_config .Xresources
# .xinitrc
check_config .xinitrc
# .i3
if [ ! -d $USER_HOME/.i3 ]
then
    mkdir $USER_HOME/.i3
    mv dotfiles/.i3/* $USER_HOME/.i3
    echo 'deb http://ftp.de.debian.org/debian sid main' >> /etc/apt/sources.list
    apt-get update
    install_package rofi
fi

# Cleanup
rm -rf dotfiles


################################################################################
# Appearance
################################################################################
# Font
# Inconsolata
install_package fonts-inconsolata
# Powerline
if [ ! -d $USER_HOME/.fonts ]
then
    sudo -H -u $1 /bin/bash -c 'git clone --quiet https://github.com/powerline/fonts $USER_HOME/fonts 2>&1'
    cd $USER_HOME/fonts && sudo -H -u $1 /bin/bash -c './install.sh'
    cd $USER_HOME && rm -rf fonts
    echo "Powerline fonts installed!"
else
    echo "Powerline fonts already installed, skipping..."
fi

################################################################################
# Post script input
################################################################################
echo "Remember to install your tmux plugins [prefix + I]"
