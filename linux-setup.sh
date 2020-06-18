#!/bin/bash
echo "Running script as $(whoami)"
cd ${HOME}

echo "Installing needed packages for running the script..."
sudo apt install unzip wget -y

echo "Installing Platform Tools..."
rm -rf platform-tools-latest-linux.zip ${HOME}/bin/platform-tools/
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
mkdir -p ${HOME}/bin/
unzip platform-tools-latest-linux.zip -d ${HOME}/bin/
printf '\n# add Android SDK platform tools to path \nif [ -d "$HOME/platform-tools" ] ; then \n PATH="$HOME/bin/platform-tools:$PATH" \nfi\n' >> ${HOME}/.profile
echo "Installing packages for building android..."
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \
  lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush \
  rsync schedtool squashfs-tools xsltproc zip zlib1g-dev default-jre default-jdk -y

echo "Installing repo..."
mkdir -p ${HOME}/android/
curl https://storage.googleapis.com/git-repo-downloads/repo > ${HOME}/bin/repo
chmod a+x ${HOME}/bin/repo
printf '# set PATH so it includes the bin directory if it exists \nif [ -d "$HOME/bin" ] ; then \n    PATH="$HOME/bin:$PATH" \nfi\n' >> ${HOME}/.profile

echo "Configuring git..."
git config --global user.email "danimoral1001@gmail.com"
git config --global user.name "daniml3"

echo "Generating SSH key..."
ssh-keygen -t rsa -C "danimoral1001@gmail.com"
cat ${HOME}/.ssh/id_rsa.pub
read -p "Add the SSH key to your GitHub account and press enter to continue..."

echo "Cloning some repos and finishing..."
cd ${HOME}/android
if [ ! -d android ]; then
git clone git@github.com:daniml3/android
fi
if [ ! -d build ]; then
git clone git@github.com:daniml3/android_build_tool build
fi

echo "Cleaning up..."
cd ${HOME}
rm -rf platform-tools-latest-linux.zip
