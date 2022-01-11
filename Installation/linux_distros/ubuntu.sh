#!/data/data/com.termux/files/usr/bin/bash

echo -e "\033[33m[*] Script downloaded from https://github.com/dmdhrumilmistry/TermuxScripts\033[0m"
echo -e "\033[33m---- Written by dmdhrumilmistry ----\033[0m"

echo -e "\033[33m[*] Updating packages...\033[0m"
pkg update -y

echo -e "\033[33m[*] Upgrading packages...\033[0m"
pkg upgrade -y

echo -e "\033[33m[*] Installing requirements...\033[0m"
pkg install proot-distro -y

echo -e "\033[33m[*] Installing Ubuntu...\033[0m"
proot-distro install ubuntu
echo -e "\033[33m[*] Ubuntu Installation Completed...\033[0m"

echo -e "\033[33m[*] Creating aliases\033[0m"
# Files
ALIAS_FILE=$HOME/.ubuntu_aliases
BASHRC_FILE=$HOME/.bashrc

# Commands
START_UBUNTU="start-ub"

touch $ALIAS_FILE
echo "####################################" >> $ALIAS_FILE
echo "### Aliases for UBUNTU in Termux ###" >> $ALIAS_FILE 
echo "####################################" >> $ALIAS_FILE
echo "" >> $ALIAS_FILE
echo "# for startup" >> $ALIAS_FILE
echo "alias $START_UBUNTU=proot-distro login ubuntu" >> $ALIAS_FILE
echo "" >> $ALIAS_FILE

# create .bashrc file if does not exist
if [ ! -f "$BASHRC_FILE" ]; then
    touch $BASHRC_FILE
fi
echo "source $ALIAS_FILE" >> $BASHRC_FILE
echo "" >> $BASHRC_FILE

echo -e "\033[33m[*] Ubuntu has been installed...[0m"
echo -e "\033[33m[*] Start Ubuntu using $START_UBUNTU\033[0m"
