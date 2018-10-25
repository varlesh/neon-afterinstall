#!/bin/bash
export COLOR="\e[32m"

echo -e "${COLOR}Remove packages"; tput sgr0
cd /tmp
sudo apt -y purge firefox* kwrite vim
sudo apt -y autoremove

echo -e "${COLOR}Upgrade system"; tput sgr0
sudo apt -y update
sudo apt -y dist-upgrade

echo -e "${COLOR}Download and install Google Chrome"; tput sgr0
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install Telegram"; tput sgr0
wget -c https://github.com/telegramdesktop/tdesktop/releases/download/v1.4.3/tsetup.1.4.3.tar.xz
tar -xf tsetup*
mkdir -p ~/.local/share/TelegramDesktop/
cp -R Telegram ~/.local/share/TelegramDesktop/
timeout 20s ~/.local/share/TelegramDesktop/Telegram/Telegram

echo -e "${COLOR}Download and install Mellow Player"; tput sgr0
wget -c http://widehat.opensuse.org/opensuse/repositories/home:/ColinDuquesnoy/xUbuntu_18.04/amd64/mellowplayer_3.4.0-1_amd64.deb
sudo dpkg -i mellowplayer*.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install SmartGit"; tput sgr0
wget -c https://www.syntevo.com/downloads/smartgit/smartgit-18_1_5.deb
sudo dpkg -i smartgit-*.deb
sudo apt -y install -f

echo -e "${COLOR}Add PPA's"; tput sgr0
sudo add-apt-repository -y ppa:varlesh-l/bionic
sudo add-apt-repository -y ppa:papirus/papirus
sudo apt -y update

echo -e "${COLOR}Install packages"; tput sgr0
sudo apt -y install git latte-dock lm-sensors p7zip-full qbittorrent kate muon qapt-deb-installer apt-xapian-index qt4-style-kvantum qt5-style-kvantum papirus-icon-theme materia-kde materia-gtk-theme hardcode-tray sni-qt plasma-applet-weather-widget plasma-widget-playbar2 plasma-widget-gmailfeed sox libqt5quick5 yakuake qml-module-qtquick-localstorage

echo -e "${COLOR}Install dev tools"; tput sgr0
sudo apt -y install dput dh-make devscripts gnome-keyring curl gimp inkscape kcolorchooser imagemagick
sudo apt -y purge nodejs npm
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt -y install nodejs
sudo npm install -g npm svgo

echo -e "${COLOR}Ddownload and install widgets"; tput sgr0
git clone https://github.com/varlesh/neon-afterinstall.git
cd widgets
plasmapkg2 -i rss-indicator*.plasmoid
plasmapkg2 -i plasma-applet-thermal-monitor.plasmoid
plasmapkg2 -i netspeed-widget*.plasmoid
plasmapkg2 -i eventcalendar*.plasmoid
plasmapkg2 -i simplemenu*.plasmoid
plasmapkg2 -i commandoutput*.plasmoid
cd ..

echo -e "${COLOR}Apply new icon theme"; tput sgr0
sed -i s/Theme=breeze/Theme=Papirus-Dark/g ~/.config/kdeglobals

echo -e "${COLOR}Clear system cache"; tput sgr0
rm -rf ~/.cache/plasm* ~/.cache/ico*
sudo apt -y clean

echo -e "${COLOR}Fix hardcode tray icons"; tput sgr0
sudo -E hardcode-tray -s 22 -ct RSVGConvert --theme Papirus-Dark -a

echo -e "${COLOR}Fix hardcode apps icons"; tput sgr0
wget https://raw.githubusercontent.com/Foggalong/hardcode-fixer/master/fix.sh
sudo bash fix.sh

echo -e "${COLOR}Fix StartupWMClass"; tput sgr0
wget https://raw.githubusercontent.com/bil-elmoussaoui/StartupWMClassFixer/master/fix
sudo bash fix
cd
sleep 3

kdialog --passivepopup "KDE Neon After Install Finished!" --icon "kde" 10
