#!/data/data/com.termux/files/usr/bin/bash

############################################
# ANSI variables
# ==========================================

############################################
# ANSI styles
NORMAL="\e[0m"
BOLD="\e[1m"
FAINT="\e[2m"
ITALIC="\e[3m"
UNDERLINE="\e[4m"
############################################
# ANSI Foregroud Colors
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
PURPLE="\e[35m"
CYAN="\e[36m"
LIGHT_GRAY="\e[37m"
############################################
# ANSI Background Colors
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_PURPLE="\e[45m"
BG_CYAN="\e[46m"
BG_LIGHT_GRAY="\e[47m"
# ========= end of ANSI variables =========

###########################################
# Unicode variables
# =========================================
TICK="\u2713"
CROSS="\u274c"
# ======== end of Unicode variables =======

###########################################
# Global variables
# =========================================

# ======== end of Global variables ========

###########################################
# Functions
###########################################

###########################################
# prints banner on the screen
banner() {
    echo -e "${CYAN}"
    echo -e "██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗"
    echo -e "██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗"
    echo -e "██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝"
    echo -e "██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗"
    echo -e "██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║"
    echo -e "╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝"
    echo -e "${NORMAL}"
    echo -e "================================================"
    echo -e "Script by ${GREEN}dmdhrumilmistry${NORMAL}"
    echo -e "================================================\n\n"
}

###########################################
# prints info message
print_info() {
    local message=$1
    if [ "$message" != "" ]; then
        echo -e "${BOLD}${YELLOW}[*] ${message}${NORMAL}"
    fi
}

###########################################
# prints error message
print_err() {
    local message=$1
    if [ "$message" != "" ]; then
        echo -e "${BOLD}${RED}[${CROSS}] ${message}${NORMAL}"
    fi
}

###########################################
# prints successs message
print_success() {
    local message=$1
    if [ "$message" != "" ]; then
        echo -e "${BOLD}${GREEN}[${TICK}] ${message}${NORMAL}"
    fi
}

###########################################
# updates and upgrades packages
update_and_upgrade() {
    apt update -y && apt upgrade -y
    if [ $status != 0 ]; then
        print_err "Packages Upgrade failed! Exiting."
        exit 1
    else
        print_success "Packages Upgraded successfully."
    fi
}

###########################################
# to install requirements
install_reqs() {
    local packages=("python" "git")
    for package in "${packages[@]}"; do
        print_info "Installing $package package."
        apt install $package -y
        local status=$?
        if [ $status != 0 ]; then
            print_err "$package installation failed! Exiting."
            exit 1
        else
            print_success "$package installed successfully."
        fi
    done
}

###########################################
# starts main script
start() {
    local repo_link="https://github.com/dmdhrumilmistry/TermuxScripts.git"
    local folder_name="TermuxScripts"

    # print banner
    banner

    # Upgrade packages
    # print_info "Upgrading Packages"
    # update_and_upgrade

    # install requirements
    print_info "Installing requirements"
    install_reqs

    # remove directory if already exists
    rm -rf $folder_name

    # install project
    cd $HOME
    git clone --depth=1 $repo_link
    
    local status=$?
    if [ $status != 0 ]; then
        print_err "Clone failed! Exiting."
        exit 1
    else
        print_success "Cloned successfully in ${HOME}"
    fi

    # add execution permission for python script
    chmod +x ${HOME}/${folder_name}/termux-scripts.py

    # install python requirements
    python -m pip install -r ${HOME}/${folder_name}/requirements.txt
    
    # print info
    print_info "Run termux-script.py file using:"
    print_info "python termux-script.py"
}

# ============ end of Functions ============

###########################################
# Script
###########################################
start

# ============= end of Script =============
