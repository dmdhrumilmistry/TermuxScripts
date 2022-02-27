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
# dirs and files
curr_dir="$(eval pwd)"
beef_dir="${PREFIX}/opt/beef"
log_file=".beef-installer-logs"

# ======== end of Global variables ========


###########################################
# Functions
# =========================================

###########################################
# prints banner on the screen
banner(){
    clear
    echo -e "${CYAN}"
    echo -e "██████╗ ███████╗███████╗███████╗"
    echo -e "██╔══██╗██╔════╝██╔════╝██╔════╝"
    echo -e "██████╔╝█████╗  █████╗  █████╗"
    echo -e "██╔══██╗██╔══╝  ██╔══╝  ██╔══╝"
    echo -e "██████╔╝███████╗███████╗██║"
    echo -e "╚═════╝ ╚══════╝╚══════╝╚═╝"
    echo -e "${NORMAL}${PURPLE}"                                               
    echo -e ""
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
    local packages=("python" "python2" "ruby" "git" "wget" "curl" "nano" "gnupg" "libiconv" "pkg-config" "clang" "make" "libffi" "libyaml" "libxslt" "bison" "espeak" "zlib" "zlib-static" "postgresql" "libpcap" "libpcap-static" "libxslt-static" "libxml2" "libxml2-static" "libcurl" "libcurl-static" "libtool" "liblzma" "patch" "lzlib" "cmake" "build-essential" "openssl" "sqlite" "autoconf" "automake" "nodejs")
    
    # log time
    echo -e "\n\n" >> $log_file
    date >> $log_file


    for package in "${packages[@]}"; do 
        print_info "Installing $package package."
        
        # log package
        echo "Installing $package package." >> $log_file
        apt install $package -y >> $log_file 2>>$log_file
        echo -e "\n" >> $log_file


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
# clone Beef Repo
clone_repo(){
    local repo_link="https://github.com/beefproject/beef.git"
    local dest_dir="${PREFIX}/opt/beef"

    if [ -d "${dest_dir}" ]; then
        print_info "${dest_dir} found. Deleting and creating new directory"
        rm -rf $dest_dir
    fi

    print_info "Creating new ${dest_dir} directory"
    mkdir -p $dest_dir

    print_info "Cloning beef project"
    git clone $repo_link $dest_dir --depth=1 >> $log_file

    local status=$?
    if [ $status != 0 ]; then
        print_err "Falied to clone Beef! Exiting."
        exit 1
    else
        print_success "Beef Cloned successfully."
    fi

}



###########################################
# installs ruby gems
install_gems(){
    # install required gems for installation
    print_info "Installing Required Gems"
    rm "Gemfile"
    # TODO: download gemfile and install/update gems
    gem install bundler
    gem install nokogiri -- --use-system-libraries --with-xml2-config=/data/data/com.termux/files/usr/bin/xml2-config --with-xml2-include=/data/data/com.termux/files/usr/include/libxml2

    local status=$?
    if [ $status != 0 ]; then
        print_err "Falied to clone Beef! Exiting."
        exit 1
    else
        print_success "Beef Cloned successfully."
    fi
    
    # install beef gems
    if [ -f  "${beef_dir}/Gemfile" ]; then
        print_info "Beef Gemfile found. installing gems..."
        cd $beef_dir
        
        # try `bundle install` if bundler install fails 
        bundler install
        local status=$?
        if [ $status != 0 ]; then
            print_err "Falied to install gems! Exiting."
            exit 1
        fi
        cd $curr_dir
    else
        print_err "Gemfile is missing..."
        exit 1
    fi

    print_success "Gems installed Successfully."
}


###########################################
# configure and install beef
install_beef(){
    
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

echo -e "\n"
print_info "Downloading Beef...."
clone_repo

echo -e "\n"
print_info "Installing Beef Gems"
install_gems

exit 0
# =========== end of start script ============
