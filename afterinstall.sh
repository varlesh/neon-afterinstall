echo "Remove packages"
sudo apt purge firefox* kwrite vim
sudo apt autoremove

echo "Upgrade system"
sudo apt update
sudo apt dist-upgrade

echo "Download and install Google Chrome"
cd /tmp
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt install -f

echo "Download and install Telegram"
cd /tmp
wget -c https://github.com/telegramdesktop/tdesktop/releases/download/v1.1.23/tsetup.1.1.23.tar.xz
tar -xf tsetup*
mkdir -p ~/.local/share/TelegramDesktop/
cp -R Telegram ~/.local/share/TelegramDesktop/
timeout 10s ~/.local/share/TelegramDesktop/Telegram/Telegram

echo "Download and install QMPlay2"
cd /tmp
wget -c https://github.com/zaps166/QMPlay2/releases/download/17.10.24/qmplay2-ubuntu-amd64-17.10.24-1.deb
sudo dpkg -i qmplay2*.deb
sudo apt install -f

echo "Download and install SmartGit"
cd /tmp
wget -c http://www.syntevo.com/static/smart/download/smartgit/smartgit-17_0_5.deb
sudo dpkg -i smartgit-*.deb
sudo apt install -f

echo "Download and install Latte Dock"
cd /tmp
wget -c https://raw.githubusercontent.com/varlesh/neon-afterinstall/master/latte-dock_0.7.1+p16.04+git20171108.0157-0_amd64.deb
sudo dpkg -i latte*.deb
sudo apt install -f

echo "Add repos"
sudo add-apt-repository ppa:andreas-angerer89/sni-qt-patched
sudo add-apt-repository ppa:tista/adapta
sudo add-apt-repository ppa:varlesh-l/ubuntu-tools
sudo add-apt-repository ppa:papirus/papirus
sudo apt update

echo "Install packages"
sudo apt install lm-sensors p7zip-full cantata qbittorrent kate muon apt-xapian-index caffeine arc-theme arc-kde adapta-gtk-theme adapta-kde kvantum papirus-icon-theme hardcode-tray sni-qt dnsmasq plasma-applet-weather-widget plasma-widget-playbar2 plasma-widget-gmailfeed phonon-backend-gstreamer phonon4qt5-backend-gstreamer sox libqt5quick5

echo "Install dev tools"
cd /tmp
sudo apt install dput dh-make devscripts gnome-keyring git curl gimp inkscape kcolorchooser imagemagick
sudo apt-get purge nodejs npm
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm svgo

echo "Install widgets"
cd /tmp
wget -c https://dl.opendesktop.org/api/files/download/id/1487367255/rss-indicator-v0.1.6.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1503273190/plasma-applet-thermal-monitor.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1499544340/netspeed-widget-1.4.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1509159451/eventcalendar-v50-plasma5.6.plasmoid
wget -c https://dl.opendesktop.org/api/files/download/id/1509532288/simplemenu-1.0.4.plasmoid
plasmapkg2 -i *.plasmoid

echo "Apply new icon theme"
sed -i s/Theme=breeze/Theme=Papirus-Adapta-Nokto/g ~/.config/kdeglobals
rm -rf ~/.cache/plasm* ~/.cache/ico*

echo "Fix hardcode tray icons"
sudo -E hardcode-tray --size 22 --conversion-tool RSVGConvert

echo "Fix hardcode apps icons"
cd /tmp
wget https://raw.githubusercontent.com/varlesh/hardcode-fixer/master/fix.sh
sudo bash fix.sh

echo "Fix StartupWMClass"
cd /tmp
wget https://raw.githubusercontent.com/bil-elmoussaoui/StartupWMClassFixer/master/fix
sudo bash fix
cd

kdialog --msgbox "KDE Neon After Install Finished!"
