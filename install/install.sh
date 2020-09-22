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



#checking if all packages are installed & dependecies

function checkdependences {
REQUIRED_PKG="autossh"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi

}

#options 
