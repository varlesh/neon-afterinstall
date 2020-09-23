#!/bin/bash
# For KDE Neon UE (Ubuntu 20.04)
export COLOR="\e[32m"

echo -e "${COLOR}Remove packages"; tput sgr0
sudo apt -y purge firefox kwrite vim kwalletmanager libkf5wallet-bin vlc
sudo apt -y autoremove

echo -e "${COLOR}Upgrade system"; tput sgr0
sudo apt -y update
sudo apt -y dist-upgrade

echo -e "${COLOR}Install drivers"; tput sgr0
sudo ubuntu-drivers install

echo -e "${COLOR}Download and install Google Chrome"; tput sgr0
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install Telegram"; tput sgr0
wget -c https://github.com/telegramdesktop/tdesktop/releases/download/v2.3.2/tsetup.2.3.2.tar.xz
tar -xf tsetup*
mkdir -p ~/.local/share/TelegramDesktop/
cp -R Telegram ~/.local/share/TelegramDesktop/
timeout 20s ~/.local/share/TelegramDesktop/Telegram/Telegram

echo -e "${COLOR}Fix Telegram tray icons"; tput sgr0
echo "export TDESKTOP_FORCE_PANEL_ICON=1" >> ~/.profile
echo "export TDESKTOP_DISABLE_TRAY_COUNTER=1" >> ~/.profile

echo -e "${COLOR}Download and install Mellow Player"; tput sgr0
wget -c https://download.opensuse.org/repositories/home:/ColinDuquesnoy/xUbuntu_20.04/amd64/mellowplayer_3.6.6-0_amd64.deb
sudo dpkg -i mellowplayer*.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install Jellyfin"; tput sgr0
wget -c https://repo.jellyfin.org/releases/server/ubuntu/stable/server/jellyfin-server_10.6.4-1_amd64.deb
wget -c https://repo.jellyfin.org/releases/server/ubuntu/stable/web/jellyfin-web_10.6.4-1_all.deb
wget -c https://github.com/jellyfin/jellyfin-ffmpeg/releases/download/v4.3.1-1/jellyfin-ffmpeg_4.2.1-7-focal_amd64.deb
sudo dpkg -i jellyfin*.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install GitHub Desktop"; tput sgr0
wget -c https://github.com/shiftkey/desktop/releases/download/release-2.5.4-linux1/GitHubDesktop-linux-2.5.4-linux1.deb
sudo dpkg -i GitHubDesktop*.deb
sudo apt -y install -f

echo -e "${COLOR}Add PPA's"; tput sgr0
sudo add-apt-repository -y ppa:varlesh-l/focal
sudo add-apt-repository -y ppa:papirus/papirus
sudo add-apt-repository -y ppa:papirus/hardcode-tray
sudo apt -y update

echo -e "${COLOR}Install packages"; tput sgr0
sudo apt -y install git latte-dock lm-sensors p7zip-full qbittorrent kate muon qapt-deb-installer apt-xapian-index qt5-style-kvantum materia-gtk-theme hardcode-tray plasma-applet-weather-widget plasma-applet-thermal-monitor plasma-widget-playbar2 sox libqt5quick5 yakuake qml-module-qtquick-localstorage bomi

echo -e "${COLOR}Install dev tools"; tput sgr0
sudo apt -y install dput dh-make devscripts gnome-keyring curl gimp inkscape kcolorchooser imagemagick
sudo apt -y purge nodejs npm
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt -y install nodejs
sudo npm install -g npm svgo asar

echo -e "${COLOR}Install bomi skin Native Mini"; tput sgr0
cd /tmp
git clone https://github.com/varlesh/bomi-skin-native-mini.git
cd bomi-skin-native-mini
sudo make install

echo -e "${COLOR}Install Papirus Icon Theme"; tput sgr0
wget -qO- https://git.io/papirus-icon-theme-install | sh

echo -e "${COLOR}Install Materia KDE"; tput sgr0
cd /tmp
git clone https://github.com/PapirusDevelopmentTeam/materia-kde.git
cd materia-kde
make PREFIX=~/.local install
mv ~/.local/share/Kvantum ~/.config/

echo -e "${COLOR}Download and install widgets"; tput sgr0
cd /tmp/neon-afterinstall/widgets
plasmapkg2 -i rss-indicator*.plasmoid
plasmapkg2 -i netspeed-widget*.plasmoid
plasmapkg2 -i eventcalendar*.plasmoid
plasmapkg2 -i minimalmenu*.plasmoid
plasmapkg2 -i commandoutput*.plasmoid
plasmapkg2 -i org.kde.plasma.calendar.wl.plasmoid
plasmapkg2 -i org.kde.plasma.digitalclock.wl.plasmoid
plasmapkg2 -i org.kde.plasma.advancedradio.plasmoid

cat AUTHORS
sleep 5
cd /tmp

echo -e "${COLOR}Apply new icon theme"; tput sgr0
sed -i s/Theme=breeze/Theme=Papirus-Dark/g ~/.config/kdeglobals

echo -e "${COLOR}Clear system cache"; tput sgr0
rm -rf ~/.cache/plasm* ~/.cache/ico*
sudo apt -y clean

echo -e "${COLOR}Fix hardcode tray icons"; tput sgr0
sudo -E hardcode-tray -s 22 -ct RSVGConvert --theme Papirus-Dark -a

echo -e "${COLOR}Fix hardcode apps icons"; tput sgr0
wget https://raw.githubusercontent.com/Foggalong/hardcode-fixer/master/fix.sh
chmod +x fix.sh 
sudo bash fix.sh

echo -e "${COLOR}Fix StartupWMClass"; tput sgr0
wget https://raw.githubusercontent.com/bil-elmoussaoui/StartupWMClassFixer/master/fix
chmod +x fix
sudo bash fix
cd
sleep 3

kdialog --passivepopup "KDE Neon After Install Finished!" --icon "kde" 10
play /usr/share/sounds/freedesktop/stereo/complete.oga
