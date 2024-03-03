#!/bin/bash

# Determine the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_FILE="$SCRIPT_DIR/security_update_log.txt"

# Clear the log file
truncate -s 0 "$LOG_FILE"

check_if_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root" 
        exit 1
    fi
}

# Function to execute security updates
update_security() {
    # Update package lists
    apt-get update >> "$LOG_FILE" 2>&1

    # Upgrade installed packages
    apt-get upgrade -y >> "$LOG_FILE" 2>&1

    # Install security updates
    apt-get dist-upgrade -y >> "$LOG_FILE" 2>&1

    # Clean up
    apt-get autoremove -y >> "$LOG_FILE" 2>&1
    apt-get autoclean >> "$LOG_FILE" 2>&1

    echo "Security updates applied successfully." >> "$LOG_FILE"

    reboot
}

# Start the script in a screen session
check_if_root
screen -dmS security_update_process bash -c "source $BASH_SOURCE && update_security"
