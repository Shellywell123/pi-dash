# pi-dash
Small info panel for my development needs, built to run on a small LCD screen on Ubuntu 24.
(Code is currently rather hacky bash scripts) 
![image](https://github.com/Shellywell123/pi-dash/blob/main/docs/photo.png)

## setup
To get going clone the repo and run the setup script.
```
git clone git@github.com:Shellywell123/pi-dash.git ~/
cd ~/pi-dash
./setup.sh
```
```
sudo gh auth login --with-token < token.txt
```

## run 
The setup script should make the `pi-dash` program globally callable in the terminal.
```
pi-dash
```
