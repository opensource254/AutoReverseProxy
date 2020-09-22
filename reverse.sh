if [ -z "${DISPLAY:-}" ]; then
    echo -e "\e[1;31mThe script should be exected inside a X (graphical) session.""\e[0m"""
    exit 1
fi

clear

##################################### < CONFIGURATION  > #####################################
DUMP_PATH="/tmp/tmpReverse" 