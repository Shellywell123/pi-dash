# pi-dash
Small info panel for my development needs, built to run on a small LCD screen on Ubuntu 24.

## Features
- Lists active GitHub user PRs
- [wtfutil](https://wtfutil.com/) to display various bits of info including hacker news
- a hacky bash script to monitor some containers hosted on another machine

![image](https://github.com/Shellywell123/pi-dash/blob/main/docs/photo.png)

## setup
To get going clone the repo and run the setup script.
```
git clone git@github.com:Shellywell123/pi-dash.git ~/pi-dash
cd ~/pi-dash/scripts && ./setup.sh
```
To see your PRs you will need to install [gh-cli](https://cli.github.com/) and authorize it with the following command 
```
sudo gh auth login --with-token < token.txt
```

## run 
The setup script should make the `pi-dash` program globally callable in the terminal.
```
pi-dash
```
