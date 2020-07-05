#!/bin/bash
echo "Running script as $(whoami)"
cd ${HOME}

echo "Installing needed packages..."
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev \
  lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush \
  rsync schedtool squashfs-tools xsltproc zip zlib1g-dev default-jre default-jdk python python3 adb fastboot unzip wget -y

echo "Installing repo..."
sudo su -c 'curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo && chmod +x /usr/bin/repo'

echo "Configuring git..."
git config --global user.email "danimoral1001@gmail.com"
git config --global user.name "daniml3"

echo "Generating SSH key..."
ssh-keygen -t rsa -C "danimoral1001@gmail.com"
cat ${HOME}/.ssh/id_rsa.pub
export key_added="false"
read -p "Add the SSH key to your GitHub account and press enter to continue..."

while [[ $key_added != "true" ]]; do
read -p "Write 'true' to confirm: " key_added
done

echo "Creating directories..."
mkdir -p ${HOME}/android/

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
