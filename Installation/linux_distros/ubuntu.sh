#!/data/data/com.termux/files/usr/bin/bash

# banner
echo "========================================================="
echo -e "\033[33m                          ___                           \033[0m"
echo -e "\033[33m | | |_      ._ _|_        |  ._   _ _|_  _. | |  _  ._ \033[0m"
echo -e "\033[33m |_| |_) |_| | | |_ |_|   _|_ | | _>  |_ (_| | | (/_ |  \033[0m"
echo -e "\033[33m                                                        \033[0m"
echo "========================================================="
echo -e "\033[33m---- Written by dmdhrumilmistry ----\033[0m"
echo "========================================================="
echo -e "\033[33m[*] Script downloaded from https://github.com/dmdhrumilmistry/TermuxScripts\033[0m"
# end banner

# start installation
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
RM_UBUNTU="rm-ub"


# delete alias file if already exists
if [ -f "$ALIAS_FILE" ]; then 
    rm -f $ALIAS_FILE
fi
touch $ALIAS_FILE
echo "####################################" >> $ALIAS_FILE
echo "### Aliases for UBUNTU in Termux ###" >> $ALIAS_FILE 
echo "####################################" >> $ALIAS_FILE
echo "" >> $ALIAS_FILE
echo "alias $START_UBUNTU=\"proot-distro login ubuntu\"" >> $ALIAS_FILE
echo "alias $RM_UBUNTU=\"proot-distro remove ubuntu\"" >> $ALIAS_FILE
echo "" >> $ALIAS_FILE

# create .bashrc file if does not exist
if [ ! -f "$BASHRC_FILE" ]; then
    touch $BASHRC_FILE
fi
echo "source $ALIAS_FILE" >> $BASHRC_FILE
echo "" >> $BASHRC_FILE

# echos to user
echo -e "\033[33m[*] Ubuntu has been installed...\033[0m"
echo "========================================================="
echo -e "\033[33m[*] To start Ubuntu use:\n$START_UBUNTU\033[0m\n"
echo -e "\033[33m[*] To remove Ubuntu use:\n$RM_UBUNTU\033[0m\n"
echo "========================================================="

echo -e "\033[33m[*] if you face any issues, do consider creating a issue on GitHub: https://github.com/dmdhrumilmistry/TermuxScripts/issues\033[0m"
echo -e "\033[33m[*] Running this script again, might fix issues in some cases.\033[0m"

echo "========================================================="
echo -e "\033[33m[*] Do Restart Termux before using commands.\033[0m"
echo "========================================================="

# load alias file
source $ALIAS_FILE
