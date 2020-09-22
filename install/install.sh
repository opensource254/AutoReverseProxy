#!/bin/bash


#Colors
white="\033[1;37m"
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
Purple="\033[0;35m"
transparent="\e[0m"

#Exit Modes
general_back="Back"
general_error_1="Not_Found"
general_case_error="Unknown option. Choose again"
general_exitmode="Reconecting"
general_exitmode_1="SSh Connection Error"
general_exitmode_2="Connection is Active"
general_exitmode_3="Disabling "$grey"forwarding of packets"

function conditional_clear() {

	if [[ "$INSTALLER_output_device" != "/dev/stdout" ]]; then clear; fi
}

#checking if all packages are installed & dependecies

#function checkdependences {
#REQUIRED_PKG="autossh"
#PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
#echo Checking for $REQUIRED_PKG: $PKG_OK
#if [ "" = "$PKG_OK" ]; then
 # echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  #sudo apt-get --yes install $REQUIRED_PKG 
#fi

#}

#Check for X display


if [ -z "${DISPLAY:-}" ]; then
    echo -e "\e[1;31mThe script should be executed inside a X (graphical) session."$transparent""
    exit 1
fi



function mostrarheader(){

	conditional_clear

	echo -e "$red[  $red    AutoReverseProxy ]"

}

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

#Install Main
conditional_clear
mostrarheader

echo "Updating system..."

#cleaning up
sudo apt-get install -f -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get clean -y
sudo apt-get update
sudo apt-get install xterm --yes
clear
mostrarheader
xterm $HOLD -title "Updating System"  $TOPLEFTBIG -bg "#FFFFFF" -fg "#000000" $TOPLEFTBIG -bg "#FFFFFF" -fg "#000000" $TOPLEFTBIG -bg "#FFFFFF" -fg "#000000" -e apt-get install software-properties-common --yes

#checking available dependecies
##############################

echo -ne "ssh....."
	if ! hash ssh 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent
	 xterm $HOLD -title "Installing ssh" -e apt-get --yes install ssh
	else
    echo -e "\e[1;32mOK!"$transparent
	fi
	sleep 0.025

##############################


echo -ne "php....."
	if ! hash ssh 2>/dev/null; then
		echo -e "\e[1;31mInstalling ..."$transparent
	 xterm $HOLD -title "Installing php" -e apt-get --yes install php libapache2-mod-php php-mcrypt
	else
    echo -e "\e[1;32mOK!"$transparent
	fi
	sleep 0.025

##############################
