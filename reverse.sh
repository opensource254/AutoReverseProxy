#!/bin/bash



if [ -z "${DISPLAY:-}" ]; then
    echo -e "\e[1;31mThe script should be exected inside a X (graphical) session.""\e[0m"""
    exit 1
fi

clear

##########configs##################
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
transparent="\e[0m"
msgcolor=`echo "\033[01;31m"` # bold red
normal=`echo "\033[00;00m"` # normal white
menu=`echo "\033[36m"` #Blue
number=`echo "\033[33m"` #yellow
bgred=`echo "\033[41m"`
fgred=`echo "\033[31m"`





#Exit Modes
general_back="Back"
general_error_1="Not_Found"
general_case_error="Unknown option. Choose again"
general_exitmode="Reconecting"
general_exitmode_1="SSh Connection Error"
general_exitmode_2="Connection is Active"
general_exitmode_3="Disabling "$grey"forwarding of packets"

##########configs##################

# Check requirements
function checkdependences {
    
    echo -ne "php....."
    if ! hash php 2>/dev/null; then
        echo -e "\e[1;31mNot installed"$transparent""
        exit=1
    else
        echo -e "\e[1;32mOK!"$transparent""
    fi
    sleep 0.025
    
    echo -ne "ssh....."
    if ! hash ssh 2>/dev/null; then
        echo -e "\e[1;31mNot installed"$transparent""
        exit=1
    else
        echo -e "\e[1;32mOK!"$transparent""
    fi
    sleep 0.025
    
    if [ "$exit" = "1" ]; then
        exit 1
    fi
    
    sleep 1
    clear
}
checkdependences

function setresolution {
    
    function resA {
        
        TOPLEFT="-geometry 90x13+0+0"
        TOPRIGHT="-geometry 83x26-0+0"
        BOTTOMLEFT="-geometry 90x24+0-0"
        BOTTOMRIGHT="-geometry 75x12-0-0"
        TOPLEFTBIG="-geometry 91x42+0+0"
        TOPRIGHTBIG="-geometry 83x26-0+0"
    }
    
    function resB {
        
        TOPLEFT="-geometry 92x14+0+0"
        TOPRIGHT="-geometry 68x25-0+0"
        BOTTOMLEFT="-geometry 92x36+0-0"
        BOTTOMRIGHT="-geometry 74x20-0-0"
        TOPLEFTBIG="-geometry 100x52+0+0"
        TOPRIGHTBIG="-geometry 74x30-0+0"
    }
    function resC {
        
        TOPLEFT="-geometry 100x20+0+0"
        TOPRIGHT="-geometry 109x20-0+0"
        BOTTOMLEFT="-geometry 100x30+0-0"
        BOTTOMRIGHT="-geometry 109x20-0-0"
        TOPLEFTBIG="-geometry  100x52+0+0"
        TOPRIGHTBIG="-geometry 109x30-0+0"
    }
    function resD {
        TOPLEFT="-geometry 110x35+0+0"
        TOPRIGHT="-geometry 99x40-0+0"
        BOTTOMLEFT="-geometry 110x35+0-0"
        BOTTOMRIGHT="-geometry 99x30-0-0"
        TOPLEFTBIG="-geometry 110x72+0+0"
        TOPRIGHTBIG="-geometry 99x40-0+0"
    }
    function resE {
        TOPLEFT="-geometry 130x43+0+0"
        TOPRIGHT="-geometry 68x25-0+0"
        BOTTOMLEFT="-geometry 130x40+0-0"
        BOTTOMRIGHT="-geometry 132x35-0-0"
        TOPLEFTBIG="-geometry 130x85+0+0"
        TOPRIGHTBIG="-geometry 132x48-0+0"
    }
    function resF {
        TOPLEFT="-geometry 100x17+0+0"
        TOPRIGHT="-geometry 90x27-0+0"
        BOTTOMLEFT="-geometry 100x30+0-0"
        BOTTOMRIGHT="-geometry 90x20-0-0"
        TOPLEFTBIG="-geometry  100x70+0+0"
        TOPRIGHTBIG="-geometry 90x27-0+0"
    }
    
    detectedresolution=$(xdpyinfo | grep -A 3 "screen #0" | grep dimensions | tr -s " " | cut -d" " -f 3)
    ##  A) 1024x600
    ##  B) 1024x768
    ##  C) 1280x768
    ##  D) 1280x1024
    ##  E) 1600x1200
    case $detectedresolution in
        "1024x600" ) resA ;;
        "1024x768" ) resB ;;
        "1280x768" ) resC ;;
        "1366x768" ) resC ;;
        "1280x1024" ) resD ;;
        "1600x1200" ) resE ;;
        "1366x768"  ) resF ;;
        * ) resA ;;
    esac
    
}

function pingTest {
          
    while true;
    do
        RESULT="1"
        PING=$(ping 8.8.8.8 -c 1 | grep -E -o '[0-9]+ received' | cut -f1 -d' ')
        if [ "$RESULT" != "$PING" ]
        then
            echo -e "$red Connection failed $normal"
            exec "$0"
        else
            echo "   "
            echo -e "$green Connection is okay.. $normal"
            sleep 5
            exec "$0"
          
                       
        fi
        
    done
    
    
    
}



######################################< MENU>#######################################

show_menu(){
    printf "\n${menu}*********************************************${normal}\n"
    printf "${menu}**${number} 1)${menu} Check Connection ${normal}\n"
    printf "${menu}**${number} 2)${menu}op 2${normal}\n"
    printf "${menu}**${number} 3)${menu} op 3 ${normal}\n"
    printf "${menu}**${number} 4)${menu} op 4 ${normal}\n"
    printf "${menu}**${number} 5)${menu} op 5${normal}\n"
    printf "${menu}*********************************************${normal}\n"
    printf "Please enter a menu option and enter or ${fgred}x to exit. ${normal}"
    read opt
}

option_picked(){
    
    message=${@:-"${normal}Error: No message passed"}
    printf "${msgcolor}${message}${normal}\n"
}

clear
show_menu


while [ $opt != '' ]
do
    if [ $opt = '' ]; then
        exit;
    else
        case $opt in
            1) clear;
                option_picked "Checking Connection....";
                sleep 2 &
                PID=$!
                i=1
                sp="/-\|"
                echo -n ' '
                while [ -d /proc/$PID ]
                do
                    printf "\b${sp:i++%${#sp}:1}"
                done
                
                pingTest
                
                
            ;;
            2) clear;
                option_picked "Option 2 Picked";
                printf "sudo mount /dev/sdi1 /mnt/usbDrive; #The 500 gig drive";
                show_menu;
            ;;
            3) clear;
                option_picked "Option 3 Picked";
                printf "sudo service apache2 restart";
                show_menu;
            ;;
            4) clear;
                option_picked "Option 4 Picked";
                printf "ssh lmesser@ -p 2010";
                show_menu;
            ;;
            x)exit;
            ;;
            \n)exit;
            ;;
            *)clear;
                option_picked "Pick an option from the menu";
                show_menu;
            ;;
        esac
    fi
done