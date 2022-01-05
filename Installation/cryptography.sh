#!/data/data/com.termux/files/usr/bin/bash

## install cryptography on Termux
echo -e "\033[33m[*] Starting installation...\033[0m"

echo -e "\033[33m[*] Updating Packages\033[0m"
pkg update -y

echo -e "\033[33m[*] Upgrading Packages\033[0m"
pkg upgrade -y

echo -e "\033[33m[*] Installing requirements\033[0m"
pkg install rust build-essential libffi openssl python3 clang

echo -e "\033[33m[*] Upgrading pip\033[0m"
pip install -U pip

echo -e "\033[33m[*] Installing Cryptography 3.1.1\033[0m"
pip install cryptography==3.1.1
