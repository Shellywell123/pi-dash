# this must be ran from inside the scripts dir

#install curl
sudo apt install curl -y

# instal nslookup
sudo apt-get install dnsutils -y

# install mcstatus
sudo apt-get install python3-pip
pip install --user mcstatus --break-system-packages

# install wtfutil
curl -s https://api.github.com/repos/wtfutil/wtf/releases/latest|grep browser_download_url|grep linux_amd64|cut -d '"' -f 4|wget -i  -
tar xvzf wtf_*_linux_amd64.tar.gz
sudo mv wtf_*_linux_amd64/wtfutil /usr/local/bin/
rm -rf wtf_*
sudo chmod a+x /usr/local/bin/wtfutil

# make it callable from terminal
sudo cp pi-dash /usr/local/bin

# run pi-dash on boot
cp gnome-terminal.desktop ~/.config/autostart/gnome-terminal.desktop
