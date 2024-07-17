#! /usr/bin/bash

# ------------------------------------------
# Functions
# ------------------------------------------
format_docker_server() {
	status=$1
	if [[ $status == "running" ]]; then
        	status="\e[0;32mONLINE \e[0m"
	else
        	status="\e[0;31mOFFLINE\e[0m"
	fi
	echo $status
}

format_users_number() {
	users=$1
	if [[ $users == "" ]]; then
        	users="-"
	elif  [[ $users != "0" ]]; then
       		users="\e[0;32m$users\e[0m"
	else
        	users="\e[0;31m$users\e[0m"
	fi
	echo $users
}

get_ip_from_hostname() {
	hostname=$1
	if [[ $(nslookup $hostname | grep -c "No answer") != "0" ]]; then
		echo "\e[0;31mNOT FOUND\e[0m"
	else
		echo $(nslookup $hostname | grep Address | tail -n 1 | cut -d " " -f2)
	fi
}

# ------------------------------------------
# IPs
# ------------------------------------------
public_ip=$(curl https://ipinfo.io/ip)
local_ip=$(hostname -I | cut -d' ' -f1)
berry_ip=$(get_ip_from_hostname berry )
the_server_ip=$(get_ip_from_hostname the-server)

# ------------------------------------------
# Minecraft
# ------------------------------------------
mine_status=$(ssh the-server docker container inspect -f "{{.State.Health.Status}}" minecraft)

if   [[ $mine_status == "healthy" ]]; then
	mine_status="\e[0;32mONLINE \e[0m"
elif [[ $mine_status == "starting" ]]; then
	mine_status="\e[0;32mBOOTING\e[0m"
elif [[ $mine_status != "" ]]; then
        mine_status="\e[0;31m$mine_status\e[0m"
else
	mine_status="\e[0;31mOFFLINE\e[0m"
fi

mine_port=25565
mine_users=$(python3 scripts/minecraft-get-number-of-players.py $the_server_ip)
mine_users=$(format_users_number $mine_users)

# ------------------------------------------
# Factorio
# ------------------------------------------
fact_status=$(ssh the-server docker container inspect -f "{{.State.Status}}" factorio)
fact_status=$(format_docker_server $fact_status)
fact_port=34197
fact_users=$(ssh the-server 'rcon -a the-server:27015 -p $(cat ../../docker/factorio-storage/config/rconpw) "/players online" | cut -d "(" -f2 | cut -d ")" -f1 | head -n 1')
fact_users=$(format_users_number $fact_users)

# ------------------------------------------
# Asseto Corsa (yet to setup)
# ------------------------------------------
asse_status="-      "
asses_status=$(format_docker_server $asse_status)
asse_port="-    "
asse_users=""
asse_users=$(format_users_number $asse_users)

# ------------------------------------------
# Grafana
# ------------------------------------------
graf_status=$(ssh the-server docker container inspect -f "{{.State.Status}}" grafana)
graf_status=$(format_docker_server $graf_status)
graf_port="3000"
graf_users=$(curl -s "$grafana_user:$grafana_password@$the_server_ip:$graf_port/api/users" | jq -r 'length')
graf_users=$(format_users_number $graf_users)

# -------------------------------------------
# Autocorreet
# ------------------------------------------
auto_status=$(ssh the-server docker container inspect -f "{{.State.Status}}" autocorreet)
auto_status=$(format_docker_server $auto_status)
auto_port="8080"
auto_users=""
auto_users=$(format_users_number $auto_users)

# -------------------------------------------
# Satisfactory
# ------------------------------------------
sati_status=$(ssh the-server docker container inspect -f "{{.State.Status}}" satisfactory)
sati_status=$(format_docker_server $sati_status)
sati_port="15777"
sati_users=""
sati_users=$(format_users_number $sati_users)

# ------------------------------------------
# Print Report
# ------------------------------------------
echo -e "\e[0;33mMachine      Address\e[0m"
echo -e "berry        \e[0;36m$berry_ip\e[0m"
echo -e "the-server   \e[0;36m$the_server_ip\e[0m"
echo -e "Router       \e[0;36m$public_ip\e[0m"
echo -e ""
echo -e "\e[0;33mServer       Port  Status  Users\e[0m"
echo -e "\e[0mAsseto Corsa \e[0;36m$asse_port\e[0m $asse_status $asse_users"
echo -e "\e[0mAutocorreet  \e[0;36m$auto_port \e[0m $auto_status $auto_users"
echo -e "\e[0mFactorio     \e[0;36m$fact_port\e[0m $fact_status $fact_users"
echo -e "\e[0mGrafana      \e[0;36m$graf_port \e[0m $graf_status $graf_users"
echo -e "\e[0mMinecraft    \e[0;36m$mine_port\e[0m $mine_status $mine_users"
echo -e "\e[0mSatisfactory \e[0;36m$sati_port\e[0m $sati_status $sati_users"
