#!/bin/bash

# Determine the folder where the script resides
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOG_FILE="$SCRIPT_DIR/backup_log.txt"

# Clear the log file
truncate -s 0 "$LOG_FILE"

# Function to check if the drive is already mounted
check_mount() {
    if grep -qs '/mnt/backup_drive' /proc/mounts; then
        echo "The drive is already mounted." >> "$LOG_FILE"
        exit 1
    fi
}

# Mounting the drive
mount_drive() {
    sudo mount /dev/sdb /mnt/backup_drive
    if [ $? -ne 0 ]; then
        echo "Error mounting the drive." >> "$LOG_FILE"
        exit 1
    fi
    echo "Drive mounted successfully." >> "$LOG_FILE"
}

# Unmounting the drive
unmount_drive() {
    sudo umount /mnt/backup_drive
    if [ $? -ne 0 ]; then
        echo "Error unmounting the drive." >> "$LOG_FILE"
        exit 1
    fi
    echo "Drive unmounted successfully." >> "$LOG_FILE"
}

# Cloning with rsync
clone_with_rsync() {
    sudo rsync -av --delete /home/Nico /mnt/backup_drive 1>> "$LOG_FILE" 2>&1
    if [ $? -ne 0 ]; then
        echo "Error cloning /home/Nico." >> "$LOG_FILE"
        exit 1
    fi
    echo "Cloning completed successfully." >> "$LOG_FILE"
}

# Displaying disk space on the mounted drive
show_disk_space() {
    echo "Disk space on the mounted drive:" >> "$LOG_FILE"
    df -h /mnt/backup_drive >> "$LOG_FILE"
}

# Main function
main() {
    check_mount
    mount_drive
    clone_with_rsync
    show_disk_space
    unmount_drive
    # Quitting the screen when cloning is completed
    screen -X quit
}

# Starting the script in a screen if not already running in one
screen -dmS backup_process bash -c "source $BASH_SOURCE && main"