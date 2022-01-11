#!/data/data/com.termux/files/usr/bin/bash

banner() {
	echo -e "\033[1m"
	echo -e "+---------------------+"
	echo -e "| Linux Installer     |"
	echo -e "+=====================+"
	echo -e "| script by           |"
	echo -e "|      dmdhrumilmistry|"
	echo -e "+=====================+"
	echo -e "\033[0m"
}

check_raise_exception() {
	local arg=$1
	local err_message=$2

	if [ $arg != 0 ]; then
		echo -e "\n\033[1m\033[31m[X] Error : $err_message\033[0m" 
		exit 1
	fi
}

get_distro_name() {
	echo -e "====================="
	echo -e "\033[1m\033[32mDistro List\033[0m"
	echo -e "====================="

	local distros=("alpine" "archlinux" "debian" "fedora" "manjaro-aarch64" "opensuse" "ubuntu" "void")
	for distro in ${distros[*]}; do
		echo -e "$distro"
	done
	read -p "Enter distro name : " distro_name
	if [ "$distro_name" == "" ]; then
		check_raise_exception 1 "Distro Name cannot be empty"
	fi
	# check if distro name is valid
	for distro in "${distros[@]}"
	do
		if [ "$distro" == "$distro_name" ]; then
			# if distro name found in distros array then return 1
			return 1
		fi
	done
	return 0
}

install_distro(){
	local dist_name=$1
	echo -e "\033[1m\033[33m[*] Updating packages...\033[0m"
	pkg update -y
	check_raise_exception $? "Error occured while updating packages"
	
	echo -e "\033[1m\033[33m[*] Upgrading packages...\033[0m"
	pkg upgrade -y
	check_raise_exception $? "Error occured while upgrading packages"

	echo -e "\033[1m\033[33m[*] Installing requirements...\033[0m"
	pkg install proot-distro -y
	check_raise_exception $? "Error occured while installing required packages"


	printf "\033[1m\n\033[33m[*] Installing %s...\n\033[0m\n" $dist_name
	proot-distro install $dist_name
	check_raise_exception $? "Error occured while installing $dist_name"
	echo -e "\033[1m\033[32m[*]  Installation Completed...\033[0m"
	
	echo -e "\033[1m\033[33m[*] Creating aliases\033[0m"
	# Files
	local ALIAS_FILE="$HOME/.$dist_name-aliases"
	local BASHRC_FILE=$HOME/.bashrc

	# Commands
	local START_DIST="start-$dist_name"
	local RM_DIST="rm-$dist_name"
	
	# delete alias file if already exists
	if [ -f "$ALIAS_FILE" ]; then 
		rm -f $ALIAS_FILE
	fi
	touch $ALIAS_FILE
	echo "########################################" >> $ALIAS_FILE
	echo "### Aliases for $dist_name in Termux" >> $ALIAS_FILE 
	echo "########################################" >> $ALIAS_FILE
	echo "" >> $ALIAS_FILE
	echo "alias $START_DIST=\"proot-distro login $dist_name\"" >> $ALIAS_FILE
	echo "alias $RM_DIST=\"proot-distro remove $dist_name\"" >> $ALIAS_FILE
	echo "" >> $ALIAS_FILE

	# create .bashrc file if does not exist
	if [ ! -f "$BASHRC_FILE" ]; then
		touch $BASHRC_FILE
	fi
	echo "source $ALIAS_FILE" >> $BASHRC_FILE
	echo "" >> $BASHRC_FILE

	# echos to user
	echo -e "\033[1m\033[32m[*] $dist_name has been installed...\033[0m"
	echo "========================================================="
	echo -e "\033[1m\033[33m[*] To start $dist_name use:\n$START_DIST\033[0m\n"
	echo -e "\033[1m\033[33m[*] To remove $dist_name use:\n$RM_DIST\033[0m\n"
	echo "========================================================="

	echo -e "\033[1m\033[33m[*] if you face any issues, do consider creating a issue on GitHub: https://github.com/dmdhrumilmistry/TermuxScripts/issues\033[0m"
	echo -e "\033[1m\033[33m[*] Running this script again, might fix issues in some cases.\033[0m"

	echo "========================================================="
	echo -e "\033[1m\033[32m[*] Do Restart Termux before using commands.\033[0m"
	echo "========================================================="

	# load alias file
	source $ALIAS_FILE
}


# Start script
banner

get_distro_name
is_distro_valid=$?


if [ "$is_distro_valid" == "1" ]; then
	echo -e "\033[1m\033[33m\n[*] $distro_name will be installed.\033[0m\n"
	install_distro $distro_name
else
	echo -e "\033[1m\033[31m[!] No distro named $distro_name found.\033[0m\n"
	exit 1
fi
exit 0
