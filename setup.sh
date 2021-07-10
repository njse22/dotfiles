#!/bin/bash

# SOFTWAE LIST
# Development
# - Postman (manual)
# - bpython 
# - vscode 
# - android studio (manual)
# - neovim
# - mathlab (manual)
# - PyCharm (manual)
# - Seamcat (manual)
# - gnuradio 
# - jupyter 
# - ansible 
# - vagrant 
# - docker 
# - kubernetes
# Graphics
# - Flameshot
# - Inkscape 
# - peek 
# - OBS
# Internet 
# - Telegram 
# - Chromium 
# - Teams 
# - Zoom 
# - signal 
# - skype
# Office
# - zotero 
# - Latex (manual)
# Utility
# - Ulauncher 
# - conky 
# - virtualbox 
# - vmware (manual)
# Other
# - Spotify
# GNU Radio
# - GQRX 
# - UHD
# - osmosdr

echo "==> Updating list of repositories"
sudo apt-get -y update

echo "==> Upgrading Packages"
sudo apt-get -y upgrade

echo "==> Creating User Disrs"
mkdir -p ~/Software
mkdir -p ~/Workspace
mkdir -p ~/ISOs
mkdir -p ~/Git
mkdir -p ~/Software/gnuradio38

echo "==> Copy Files"
cp ./zsh/zshrc ~/.zshrc
cp ./tmux/tmux.conf ~/.tmux.conf
cp ./nvim/init.vim ~/.config/nvim/init.vim
cp ./nvim/coc-settings.json ~/.config/nvim/coc-settings.json
cp -r ./nvim/site/* ~/.local/share/nvim/site

echo "==> Install commond tools"
sudo apt-get -y install clang cmake curl cppunit libcppunit-dev \
	git htop libboost-all-dev meld ca-certificates \
	open-vm-tools-desktop apt-transport-https gnupg lsb-release \
	tig tmux tree virtualbox-guest-dkms virtualbox-guest-utils wget \
	g++ libgmp-dev swig doxygen libfftw3-dev xclip xxd\
	libsdl1.2-dev libgsl-dev libqwt-qt5-dev libqt5opengl5-dev  \
	liblog4cpp5-dev libzmq3-dev gir1.2-gtk-3.0 \
	libcodec2-dev libgsm1-dev libiio-dev libad9361-dev \
	libsoapysdr-dev soapysdr-tools libusb-1.0-0-dev \
	build-essential vim ctags vim-scripts neovim flameshot chromium-browser \
	apt-transport-https neofetch zsh ffmpeg v4l2loopback-dkms conky

## Python depencies 
sudo apt-get -y install python3-numpy python3-setuptools python3-ruamel.yaml \
	python3-requests python3-docutils python3-zmq python3-scipy python3-gi \
	python3-gi-cairo python3-yaml python3-click python3-click-plugins \
	python3-pyqt5 python3-mako python3-sphinx python3-lxml python3-matplotlib \
	python3-ipython python3-pip python3-neovim 

## Jupyter 
sudo apt-get -y install jupyter jupyter-qtconsole jupyter-notebook

## pip packages
pip install --upgrade pip
pip install bpython
pip install tensorflow

echo "==> Install Snap"
sudo apt-get -y install snapd
sudo snap install urh
sudo snap install microk8s --classic

echo "==> Install Flatpack"
sudo apt-get -y install flatpak
sudo apt install plasma-discover-flatpak-backend
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo ldconfig
flatpak install flathub org.telegram.desktop
flatpak install flathub us.zoom.Zoom

echo "==> Install Personal Software <=="
echo "==> ppa repositories"
## Ansible
sudo apt-get -y install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible

## Vagrant
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

## Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.l

## vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

## signal 
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

## Inkscape
sudo add-apt-repository ppa:inkscape.dev/stable

## peek
sudo add-apt-repository ppa:peek-developers/stable

## OBS 
sudo add-apt-repository ppa:obsproject/obs-studio

sudo apt-get update
sudo apt-get -y install ansible vagrant docker-ce docker-ce-cli containerd.io \
	inkscape peek spotify-client code signal-desktop obs-studio

sudo usermod -aG docker $USER

echo "==> deb packages"
cd ~/Downloads/

# Teams
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.4.00.7556_amd64.deb
sudo dpkg -i teams_1.4.00.7556_amd64.deb

# Skype
wget https://repo.skype.com/latest/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

# Zotero
wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
sudo apt update
sudo apt install zotero

# Ulauncher
wget https://github.com/Ulauncher/Ulauncher/releases/download/5.11.0/ulauncher_5.11.0_all.deb
sudo apt install ulauncher_5.11.0_all.deb

# virtualbox
wget https://download.virtualbox.org/virtualbox/6.1.22/virtualbox-6.1_6.1.22-144080~Ubuntu~eoan_amd64.deb
sudo dpkg -i virtualbox-6.1_6.1.22-144080~Ubuntu~eoan_amd64.deb

echo "==> Install GNU Radio and SDR Tools <=="
cd
# CPU Freq
sudo apt-get -y install cpufrequtils
sudo systemctl stop ondemand
sudo systemctl disable ondemand
echo "GOVERNOR=\"performance\"" | sudo tee -a /etc/default/cpufrequtils

# Paths 
cd
echo 'export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib' >> ~/.profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3/dist-packages' >> ~/.profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3/site-packages' >> ~/.zshrc
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3.8/dist-packages' >> ~/.profile
echo 'export PYTHONPATH=${PYTHONPATH}:/usr/local/lib/python3.8/site-packages' >> ~/.zshrc

sudo apt-get -y install multimon-ng sox liborc-dev swig3.0
sudo add-apt-repository -y ppa:gnuradio/gnuradio-releases
sudo add-apt-repository -y ppa:mormj/gnuradio-oot3
sudo apt-get update
sudo apt-get -y install gr-fcdproplus gr-fosphor gr-iqbal gr-limesdr gr-osmosdr
sudo apt-get -y install gqrx-sdr inspectrum

sudo usermod -aG usrp $USER
sudo apt-get -y install clinfo mesa-utils
sudo usermod -aG video $USER
sudo usermod -aG dialout $USER 
sudo usermod -aG lpadmin $USER 

sudo apt-get -y install intel-opencl-icd lsb-core
sudo /usr/lib/uhd/utils/uhd_images_downloader.py

echo "==> Install and Configure OhMyZsh"
cd 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
	${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
	chsh -s $(which zsh)
# descargar y configurar fuentes ...

echo "==> Git Configurations"
git config --global user.name = "njse22"
git config --global user.email = "1144202885@u.icesi.edu.co"

echo "==> Clean Machine <=="
rm -rf /tmp/*
rm -rf ~/Downloads/*

echo "==> Cleanup apt cache"
apt-get -y autoremove --purge
apt-get -y clean
apt-get -y autoclean

echo "Sync"
sync;sync;sync
sudo ldconfig
