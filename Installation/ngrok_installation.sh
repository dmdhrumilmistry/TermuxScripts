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

###########################################
# NGORK download links
ARM_NGROK_LINK="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm.tgz"
ARM64_NGROK_LINK="https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-arm64.tgz"
# ======== end of Global variables ========


###########################################
# Functions
# =========================================

banner(){
    echo -e "${BLUE}"
    echo -e "███╗   ██╗ ██████╗ ██████╗  ██████╗ ██╗  ██╗"                          
    echo -e "████╗  ██║██╔════╝ ██╔══██╗██╔═══██╗██║ ██╔╝"                         
    echo -e "██╔██╗ ██║██║  ███╗██████╔╝██║   ██║█████╔╝"                           
    echo -e "██║╚██╗██║██║   ██║██╔══██╗██║   ██║██╔═██╗"                           
    echo -e "██║ ╚████║╚██████╔╝██║  ██║╚██████╔╝██║  ██╗"                          
    echo -e "╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝"                          
    echo -e "${NORMAL}${CYAN}"                                        
    echo -e "╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┌─┐┬─┐"
    echo -e "║│││└─┐ │ ├─┤│  │  ├┤ ├┬┘"
    echo -e "╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘└─┘┴└─"                           
    echo -e "${NORMAL}${GREEN}+----------------+${NORMAL}"
    echo -e "${GREEN}|${NORMAL} Written by     ${GREEN}|${NORMAL}"
    echo -e "${GREEN}|${NORMAL}${YELLOW} Dhrumil Mistry ${GREEN}|${NORMAL}"
    echo -e "${GREEN}+----------------+${NORMAL}"
    echo -e ""                                                          
}

###########################################
# prints info message
print_info(){
    local message=$1
    if [ "$message" != "" ]; then
        echo -e "${BOLD}${YELLOW}[*] ${message}${NORMAL}"
    fi
}


###########################################
# prints error message
print_err(){
    local message=$1
    if [ "$message" != "" ]; then
        echo -e "${BOLD}${RED}[${CROSS}] ${message}${NORMAL}"
    fi
}


###########################################
# prints successs message
print_success(){
    local message=$1
    if [ "$message" != "" ]; then
        echo -e "${BOLD}${GREEN}[${TICK}] ${message}${NORMAL}"
    fi
}

###########################################
# to install requirements
install_reqs(){
    local packages=("wget")
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
# Downloads and setups ngrok on Termux
setup_ngrok(){
    if [[ -f "${PREFIX}/bin/ngrok" ]]; then
        print_err "Ngrok is already installed"
        exit 1
    fi 

    local tmpdir="${PREFIX}/tmp/"
    local ngrok_file="ngrok.tgz"
    print_info "Changing working directory to temp dir ${tmpdir}\n"
    cd $tmpdir

    print_info "Downloading ngrok\n"
    wget -O "$ngrok_file" $ARM64_NGROK_LINK
    if [ $? != 0 ]; then
        print_err "Failed to download ngrok file"
        exit 1
    fi
    print_success "Ngrok downloaded successfully"

    print_info "Extracting ngrok"
    tar -xf $ngrok_file -C "${PREFIX}/bin"
    if [ $? != 0 ]; then
        print_err "Failed to extract ngrok"
        exit 1
    fi
    print_success "Ngrok file extracted successfully"

    print_info "Removing Downloaded file"
    rm $ngrok_file

    print_success "Ngrok has been installed"
}

# ======== end of functions ==============


##############################################
# Start Script

# print banner
banner

# install requirements
install_reqs

# download and setup ngrok
setup_ngrok

exit 0
# =========== end of start script ============
