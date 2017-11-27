#!/bin/bash
export COLOR="\[\033[0;32m\]"

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
wget -c https://github.com/telegramdesktop/tdesktop/releases/download/v1.1.23/tsetup.1.1.23.tar.xz
tar -xf tsetup*
mkdir -p ~/.local/share/TelegramDesktop/
cp -R Telegram ~/.local/share/TelegramDesktop/
timeout 10s ~/.local/share/TelegramDesktop/Telegram/Telegram

echo -e "${COLOR}Download and install QMPlay2"; tput sgr0
wget -c https://github.com/zaps166/QMPlay2/releases/download/17.10.24/qmplay2-ubuntu-amd64-17.10.24-1.deb
sudo dpkg -i qmplay2*.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install SmartGit"; tput sgr0
wget -c http://www.syntevo.com/static/smart/download/smartgit/smartgit-17_1_2.deb
sudo dpkg -i smartgit-*.deb
sudo apt -y install -f

echo -e "${COLOR}Add PPA's"; tput sgr0
sudo add-apt -y-repository ppa:andreas-angerer89/sni-qt-patched
sudo add-apt -y-repository ppa:varlesh-l/ubuntu-tools
sudo add-apt -y-repository ppa:papirus/papirus
sudo apt -y update

echo -e "${COLOR}Install packages"; tput sgr0
sudo apt -y install latte-dock lm-sensors p7zip-full clementine qbittorrent kate muon apt -y-xapian-index caffeine arc-theme arc-kde adapta-gtk-theme adapta-kde kvantum papirus-icon-theme hardcode-tray sni-qt dnsmasq plasma-applet-weather-widget plasma-widget-playbar2 plasma-widget-gmailfeed ubuntu-restricted-extras phonon-backend-gstreamer phonon4qt5-backend-gstreamer gstreamer1.0-libav sox libqt5quick5 yakuake qml-module-qtquick-localstorage

echo -e "${COLOR}Install dev tools"; tput sgr0
sudo apt -y install dput dh-make devscripts gnome-keyring git curl gimp inkscape kcolorchooser imagemagick
sudo apt -y-get purge nodejs npm
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt -y-get install -y nodejs
sudo npm install -g npm svgo

echo -e "${COLOR}Ddownload and install widgets"; tput sgr0
wget -c https://dl.opendesktop.org/api/files/download/id/1487367255/rss-indicator-v0.1.6.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1503273190/plasma-applet-thermal-monitor.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1499544340/netspeed-widget-1.4.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1509159451/eventcalendar-v50-plasma5.6.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1509532288/simplemenu-1.0.4.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1491427786/commandoutput-v3.plasmoid
plasmapkg2 -i rss-indicator-v0.1.6.plasmoid
plasmapkg2 -i plasma-applet-thermal-monitor.plasmoid
plasmapkg2 -i netspeed-widget-1.4.plasmoid
plasmapkg2 -i eventcalendar-v50-plasma5.6.plasmoid
plasmapkg2 -i simplemenu-1.0.4.plasmoid
plasmapkg2 -i commandoutput-v3.plasmoid

echo -e "${COLOR}Apply new icon theme"; tput sgr0
sed -i s/Theme=breeze/Theme=Papirus-Adapta-Nokto/g ~/.config/kdeglobals

echo -e "${COLOR}Clear system cache"; tput sgr0
rm -rf ~/.cache/plasm* ~/.cache/ico*
sudo apt -y clean

echo -e "${COLOR}Restart Plasma Desktop"; tput sgr0
kquitapp5 plasmashell
sleep 3
kstart5 plasmashell
sleep 3

echo -e "${COLOR}Fix hardcode tray icons"; tput sgr0
sudo -E hardcode-tray -s 22 -ct RSVGConvert --theme Papirus-Adapta-Nokto -a

echo -e "${COLOR}Fix hardcode apps icons"; tput sgr0
wget https://raw.githubusercontent.com/Foggalong/hardcode-fixer/master/fix.sh
sudo bash fix.sh

echo -e "${COLOR}Fix StartupWMClass"; tput sgr0
wget https://raw.githubusercontent.com/bil-elmoussaoui/StartupWMClassFixer/master/fix
sudo bash fix
cd
sleep 3

kdialog --passivepopup "KDE Neon After Install Finished!" --icon "kde" 10
