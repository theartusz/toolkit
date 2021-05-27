#!/bin/sh

apt update

# curl
apt install curl
curl --version

# git
apt install git
git --version

# gnome-tweak-tool
add-apt-repository universe
apt install gnome-tweak-tool
apt install gnome-shell-extensions

# tela icons
if [ ! -d ~/.themes && -d ~/.icons ];
    then mkdir -v ~/.{themes,icons}
fi
git clone https://github.com/vinceliuice/Tela-icon-theme.git ~/Downloads/tela-icons
mv ~/Downloads/tela-icons ~/.icons

# openconnect VPN
apt install openconnect network-manager-openconnect network-manager-openconnect-gnome

# MS Teams
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
apt install teams

snap install tela-icons

# vs code
snap install code --classic

# slack
snap install slack --classic

# spotify
snap install spotify

# bitwrden
snap install bitwarden

# vlc
snap install vlc

#discord
snap install discord

# terraform


# fish shell
apt install fish
chsh -s /usr/bin/fish $USER

# azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

# kubectx
# fzf
# git hub cli
# yk
# docker

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb