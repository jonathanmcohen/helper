#!/bin/bash

# Prompt user for the container ID
read -p "Enter the container ID: " CONTAINER_ID

# Define the file path using the container ID
FILE_PATH="/etc/pve/lxc/${CONTAINER_ID}.conf"

# Lines to append
LINE1="lxc.cgroup2.devices.allow: c 10:200 rwm"
LINE2="lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file"

# Check if the file exists
if [ -f "$FILE_PATH" ]; then
    # Append the lines to the file
    echo "$LINE1" >> "$FILE_PATH"
    echo "$LINE2" >> "$FILE_PATH"
    echo "Lines successfully added to $FILE_PATH"
    
    # Reboot the container using pct
    echo "Rebooting container $CONTAINER_ID..."
    pct reboot $CONTAINER_ID

    echo "Container $CONTAINER_ID has been rebooted."
else
    echo "Error: File does not exist at $FILE_PATH"
    exit 1
fi
