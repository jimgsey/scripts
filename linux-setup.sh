#!/bin/bash
echo "Running script as $(whoami)"
cd ${HOME}
echo "Installing Platform Tools..."
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
mkdir -p ~/bin/
unzip platform-tools-latest-linux.zip -d ~/bin/
printf '\n# add Android SDK platform tools to path \nif [ -d "$HOME/platform-tools" ] \
  ; then \n    PATH="$HOME/bin/platform-tools:$PATH" \nfi\n' >> ~/.profile

echo "Installing packages for building android..."
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \
  lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush \
  rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libwxgtk3.0-dev -y

echo "Installing repo..."
mkdir -p ~/android/
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
printf '# set PATH so it includes the bin directory if it exists \nif [ -d "$HOME/bin" ] ; then \n    PATH="$HOME/bin:$PATH" \nfi\n'

echo "Configuring git..."
git config --global user.email "danimoral1001@gmail.com"
git config --global user.name "daniml3"

echo "Cloning some repos and finishing..."
cd ~/android
git clone https://github.com/daniml3/android
git clone https://github.com/daniml3/android_build_tool build
