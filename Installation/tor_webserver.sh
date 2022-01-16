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
# TOR conf files
tor_dir="${PREFIX}/var/lib/tor/hidden_service"
tor_file="${tor_dir}/torrc"
# ======== end of Global variables ========


###########################################
# Functions
# =========================================

###########################################
# prints banner on the screen
banner(){
    clear
    echo -e "${CYAN}"
    echo -e "████████╗ ██████╗ ██████╗"                        
    echo -e "╚══██╔══╝██╔═══██╗██╔══██╗"                       
    echo -e "   ██║   ██║   ██║██████╔╝"                       
    echo -e "   ██║   ██║   ██║██╔══██╗"                       
    echo -e "   ██║   ╚██████╔╝██║  ██║"                       
    echo -e "   ╚═╝    ╚═════╝ ╚═╝  ╚═╝"                                                                                          
    echo -e "${NORMAL}${PURPLE}"                                               
    echo -e "██╗    ██╗███████╗██████╗"                        
    echo -e "██║    ██║██╔════╝██╔══██╗"                       
    echo -e "██║ █╗ ██║█████╗  ██████╔╝"                       
    echo -e "██║███╗██║██╔══╝  ██╔══██╗"                       
    echo -e "╚███╔███╔╝███████╗██████╔╝"                       
    echo -e " ╚══╝╚══╝ ╚══════╝╚═════╝"                        
    echo                                                  
    echo -e "███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗" 
    echo -e "██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗"
    echo -e "███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝"
    echo -e "╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗"
    echo -e "███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║"
    echo -e "╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝"
    echo -e "${NORMAL}"
    echo -e "================================================"
    echo -e "Script by ${GREEN}dmdhrumilmistry${NORMAL}"
    echo -e "================================================\n\n"

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
    local packages=("tor" "apache2")
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
# configure tor service
conf_tor(){
    local hostname_file="${tor_dir}/hostname"
    local tor_log_file="${tor_dir}/tor_script_logs.out"
    
    local hidden_service_port="80"
    local server_conf="127.0.0.1:8080"
    local tor_proxy="127.0.0.1:9050"

    # kill already running tor service
    pkill -9 tor

    # delete tor_dir folder if present
    if [ -d "$tor_dir" ]; then 
        print_info "Deleting $tor_dir"
        rm -rf $tor_dir
    fi
    # create new tor_dir folder
    print_info "Creating $tor_dir"
    mkdir -p $tor_dir

    # delete torrc file if already exists
    if [ -f "$tor_file" ]; then
        print_info "torrc file found at $tor_file, this file will be deleted."
        rm -rf $tor_file
    fi
    touch $tor_file
    # SOCKS port does not work after android 7
    # echo "SOCKSPort ${tor_proxy}" >> $tor_file 
    echo "HiddenServiceDir ${tor_dir}" >> $tor_file
    echo "HiddenServicePort ${hidden_service_port} ${server_conf}" >> $tor_file  
    print_success "torrc file created successfully."

    print_info "Starting TOR to get hostname...."
    tor > $tor_log_file &

    print_info "Waiting 10 seconds for hostname to be generated...."
    sleep 10
    pkill -9 tor

    print_info "Getting TOR website hostname..."
    if [ ! -f "$hostname_file" ]; then
        print_err "TOR hostname not found. Try Again"
        exit 1
    else
        print_success "HOSTNAME : $(cat $hostname_file)"
    fi
} 

###########################################
# configure and start apache2 service
conf_apache2(){
    local html_content="<html><body><p>This Website was hosted using the script written by <h2><b><a href='https://github.com/dmdhrumilmistry/'>dmdhrumilmistry</a?</b></p></h2></body></html>"
    local index_path="${PREFIX}/share/apache2/default-site/htdocs/index.html"
    
    # stop httpd if already running
    pkill -9 httpd

    # overwrite index file
    print_info "Creating index file at $index_path"
    echo $html_content > $index_path
    
    # start server during installation for verification
    # apachectl -k start
    # local status=$?
    # if [ $status != 0 ]; then
        # print_err "Failed to start Web Server"
        # exit 1
    # else
        # print_success "Web Server started successfully"
        # print_info "${NORMAL}Use ${BOLD}${YELLOW}apachectl -k stop${NORMAL} to stop the web server."
    # fi
}

###########################################
# configure and create aliases
conf_aliases(){
    local alias_file="${HOME}/.tor_webserver_aliases"
    local shell_file=""

    # find user shell and set shellrc file to shell_file
    case $(echo $SHELL) in
    *"/zsh"*)
        shell_file="${HOME}/.zshrc"
    ;;
    *"/bash"*)
        shell_file="${HOME}/.bashrc"
    ;;
    *)
        print_info "Cannot find bash/zsh conf file, add ${alias_file} to your shell rc file manually."
        exit 1
    ;;
    esac
    if [[ -f "$shell_file" ]]; then
        print_info "$shell_file found, updating file with new aliases."
    else
        print_info "$shell_file not found."
    fi

    # forefully remove alias file and create n
    rm -rf $alias_file

    # commands for tor service
    echo "alias tor-web-start=\"tor -f ${tor_file} & ;apachectl -k start\"" >> $alias_file
    echo "alias tor-web-stop=\"pkill -9 tor;pkill -9 httpd\"" >> $alias_file

    # add alias source command to shell rc file
    echo "source $alias_file" >> $shell_file

    # print details to user
    print_success "Restart Termux before using below commands"
    echo -e "${BOLD}${YELLOW}tor-web-start${NORMAL}\tto start tor and web server"
    echo -e "${BOLD}${YELLOW}tor-web-stop${NORMAL}\tto stop tor and web server"
    echo 
}
# ======== end of functions ==============


##############################################
# Start Script

# exit script if any error occurs
# set -e

# print banner
banner

# install requirements
print_info "Installing Requirements...."
install_reqs

# configure server
print_info "Configuring Server...."
conf_apache2

# configure tor
print_info "Configuring TOR...."
conf_tor

# configure aliases
conf_aliases

exit 0
# =========== end of start script ============
