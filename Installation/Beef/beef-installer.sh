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
repo_link="https://github.com/beefproject/beef.git"

###########################################
# beef authentication
beefuser="beefroot"
beefpasswd="toor"

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
    echo -e "╦┌┐┌┌─┐┌┬┐┌─┐┬  ┬  ┌─┐┬─┐"
    echo -e "║│││└─┐ │ ├─┤│  │  ├┤ ├┬┘"
    echo -e "╩┘└┘└─┘ ┴ ┴ ┴┴─┘┴─┘└─┘┴└─"
    echo -e "${NORMAL}"
    echo -e "================================================"
    echo -e "Script by ${GREEN}dmdhrumilmistry${NORMAL}"
    echo -e "================================================\n\n"
}


###########################################
# checks for return value and prints 
# message according
check_result(){
    local msg_succ=$1
    local msg_err=$2
    local status=$3

    if [ $status != 0 ]; then
        print_err "$msg_err"
        exit 1
    else
        print_success "$msg_succ"
    fi
    
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

        check_result "$package installed successfully." "$package installation failed! Exiting." $?
    done
}


###########################################
# Download files from internet using wget
download_files(){
    local files=("https://raw.githubusercontent.com/dmdhrumilmistry/TermuxScripts/main/Installation/Beef/files/Gemfile" "https://raw.githubusercontent.com/dmdhrumilmistry/TermuxScripts/main/Installation/Beef/files/config.yaml")

    for file in "${files[@]}"; do
        wget $file >> $log_file 2>>$log_file
        check_result "${file} downloaded successfully" "Failed to download file ${https://raw.githubusercontent.com/dmdhrumilmistry/TermuxScripts/beef-installer/Installation/Beef/files/Gemfile}" $?
    done
}


###########################################
# clone Beef Repo
clone_repo(){

    if [ -d "${beef_dir}" ]; then
        print_info "${beef_dir} found. Deleting and creating new directory"
        rm -rf $beef_dir
    fi

    print_info "Creating new ${beef_dir} directory"
    mkdir -p $beef_dir

    print_info "Cloning beef project" "Falied to clone Beef! Exiting." $?
    git clone $repo_link $beef_dir --depth=1 >> $log_file 2>>$log_file

    check_result "Beef Cloned successfully." "Beef Cloned successfully." $?
}



###########################################
# installs ruby gems
install_gems(){
    cd $beef_dir

    print_info "Installing Required Gems"
    gem install bundler
    gem install nokogiri -- --use-system-libraries --with-xml2-config=/data/data/com.termux/files/usr/bin/xml2-config --with-xml2-include=/data/data/com.termux/files/usr/include/libxml2

    check_result "Required Gems installed successfully." "Failed to install required gems." $?
    
    print_info "Removing and Downloading Gemfile & config.yaml files"
    rm -f Gemfile
    rm -f config.yaml
    download_files


    if [ -f  "${beef_dir}/Gemfile" ]; then
        print_info "Beef Gemfile found. installing gems..."
    
        # try `bundle install` if bundler install fails 
        bundler install
        check_result "Beef Gems installed successfully" "Falied to install gems! Exiting." $?
        cd $curr_dir
    else
        print_err "Gemfile is missing. Cannot proceed further. Exiting!!"
        exit 1
    fi
}


###########################################
# configure and install beef
install_beef(){
    install_gems

    print_info "${beef_dir} contains beef executable"
    print_info "default username : ${beefuser}"
    print_info "default passwd : ${beefpasswd}"

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
print_info "Installing Beef..."
install_beef

exit 0
# =========== end of start script ============
