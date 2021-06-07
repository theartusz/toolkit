#!/bin/bash

DOWNLOAD_PATH=$HOME/Downloads

# set IFS variable for word splitting to whitesapce
IFS=' '

# snaps to dawnload
snapArray=("vlc" "discord" "spotify" "bitwarden" "code --classic" "slack --classic" "yq")

for snap in "${snapArray[@]}"; do
    # split array items
    read -a APP <<< "$snap"
    # heck if app is already installed
    if ! type ${APP[0]} > /dev/null; then
            # check if name of app consists of more then 1 word
            if [ ${#APP[@]} -gt 1 ]; then
                APP="${APP[0]} ${APP[1]}"
            fi
        echo "installing $APP"
        sudo snap install $APP
        echo -e "\e[32m$APP successfully installed\e[0m"
        else
        echo -e "$APP already installed"
    fi
done

apt update

# add gnome-tweak-tool repository
sudo add-apt-repository universe

aptArray=("curl" "git" "openconnect" "network-manager-openconnect" "network-manager-openconnect-gnome" "gnome-tweak-tool" "gnome-shell-extensions")

for APP in "${aptArray[@]}"; do
    if ! type $APP > /dev/null; then
        echo "installing $APP"
        sudo apt install $APP
        echo -e "\e[32m$APP successfully installed\e[0m"
        else
        echo -e "$APP already installed"
    fi
done

# tela icons
if [ ! -d ~/.themes && -d ~/.icons ];
    then mkdir -v ~/.{themes,icons}
fi
git clone https://github.com/vinceliuice/Tela-icon-theme.git ~/Downloads/tela-icons
mv ~/Downloads/tela-icons ~/.icons

# MS Teams
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
apt install teams

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
if ! type gh > /dev/null; then
    echo "installing GitHub cli"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    echo -e "\e[32mgh successfully installed\e[0m"
    else
    echo "GitHub cli is aready installed"
fi

# docker

# chrome
if ! type google-chrome > /dev/null; then
    echo "installing google-chrome"
    wget -P $DOWNLOAD_PATH https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    echo -e "\e[32mgoogle-chrome successfully installed\e[0m"
    else
    echo "google-chrome is already installed"
fi