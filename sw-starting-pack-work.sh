#!/bin/bash

DOWNLOAD_PATH=$HOME/Downloads

# set IFS variable for word splitting to whitesapce
IFS=' '

# add gnome-tweak-tool repository
sudo add-apt-repository universe

sudo apt update

# snaps to dawnload
snapArray=("vlc" "spotify" "bitwarden" "code --classic" "slack --classic" "yq" "helm --classic")
# apt programs to be installed
aptArray=("curl" "git" "openconnect" "network-manager-openconnect" "network-manager-openconnect-gnome" "gnome-tweaks" "gnome-shell" "terminator" "fzf" "kubectx")

install_loop()
{
    type="$1"
    shift
    appArray=("$@")
    for app_name in "${appArray[@]}"; do
        # split array items
        read -a APP <<< "$app_name"
        # heck if app is already installed
        if ! type ${APP[0]} > /dev/null; then
                # check if name of app consists of more then 1 word
                if [ ${#APP[@]} -gt 1 ]; then
                    APP="${APP[0]} ${APP[1]}"
                fi
            echo "installing $APP"
            sudo $type install $APP
            echo -e "\e[32m$APP successfully installed\e[0m"
            else
            echo -e "\e[33m$APP already installed\e[0m"
        fi
    done
}

install_loop snap "${snapArray[@]}"
install_loop apt "${aptArray[@]}"

## tela icons
#if [ ! -d ~/.themes && -d ~/.icons ];
#    then mkdir -v ~/.{themes,icons}
#fi
#git clone https://github.com/vinceliuice/Tela-icon-theme.git ~/Downloads/tela-icons
#mv ~/Downloads/tela-icons ~/.icons
#
## MS Teams
#curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
#sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
#apt install teams
#
# terraform
if ! type terraform > /dev/null; then
    echo "installing terraform"
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
    curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
    sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    sudo apt-get update && sudo apt-get install terraform
    echo -e "\e[32mterraform successfully installed\e[0m"
    else
    echo -e "\e[33mterraform already installed\e[0m"
fi

# fish shell
if ! type fish > /dev/null; then
    echo "installing fish"
    sudo apt install fish
    chsh -s /usr/bin/fish $USER
    echo -e "\e[32mfish successfully installed\e[0m"
    else
    echo -e "\e[33mfish is already insatlled\e[0m"
fi

# azure CLI
if ! type az > /dev/null; then
    echo "installing az"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    echo -e "\e[32maz successfully installed\e[0m"
    else
    echo -e "\e[33maz is aready installed\e[0m"
fi

# kubectl
if ! type kubectl > /dev/null; then
    echo "installing kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
    echo "$(<kubectl.sha256) kubectl" | sha256sum --check
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    if type kubectl version --client > /dev/null; then
        echo -e "\e[32mkubectl successfully installed\e[0m"
        else
        echo -e "\e[31mkubectl installation failed\e[0m"
    fi
    else
    echo -e "\e[33mkubectl is aready installed\e[0m"
fi

# git hub cli
if ! type gh > /dev/null; then
    echo "installing GitHub cli"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
    sudo apt update
    sudo apt install gh
    echo -e "\e[32mgh successfully installed\e[0m"
    else
    echo -e "\e[33mGitHub cli is aready installed\e[0m"
fi

# docker

# chrome
if ! type google-chrome > /dev/null; then
    echo "installing google-chrome"
    wget -P $DOWNLOAD_PATH https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb
    echo -e "\e[32mgoogle-chrome successfully installed\e[0m"
    else
    echo -e "\e[33mgoogle-chrome is already installed\e[0m"
fi

# gnome extensions
# - Sound Input & Output Device Chooser