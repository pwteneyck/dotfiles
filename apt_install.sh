#! /bin/bash

# configure Sublime's repository - see
# https://www.sublimetext.com/docs/linux_repositories.html
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text

cat apt_installs.list | xargs apt -y install

git config --global credential.helper store
git config --global core.editor "vim"

# install 1Password CLI
mkdir op_stuff
wget https://cache.agilebits.com/dist/1P/op/pkg/v1.12.2/op_linux_amd64_v1.12.2.zip -P op_stuff
unzip -d op_stuff op_stuff/op_linux_amd64_v1.12.2.zip
mv op_stuff/op /usr/local/bin
rm -rf op_stuff
echo "Run 'op signin my.1password.com teneyck.shared@gmail.com' to set up 1PasswordCLI"