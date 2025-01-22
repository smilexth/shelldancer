#!/bin/bash

# ==========================================================
# Shell Dancer Installer
# Copyright © SmileX
# This script installs or updates Shell Dancer on your system
# ==========================================================

SCRIPT_NAME="shelldancer"
REPO_URL="https://raw.githubusercontent.com/smilexth/shelldancer/main/shelldancer"

# Function to compare two version strings
version_gt() {
    local IFS=.
    local i ver1=($1) ver2=($2)

    # Fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done

    # Fill empty fields in ver2 with zeros
    for ((i=${#ver2[@]}; i<${#ver1[@]}; i++)); do
        ver2[i]=0
    done

    for ((i=0; i<${#ver1[@]}; i++)); do
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 0
        elif ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 1
        fi
    done
    return 1
}

# Function to check if shelldancer is already installed
check_existing() {
    if command -v "$SCRIPT_NAME" &> /dev/null; then
        echo "Checking for updates..."

        # Get the remote version
        REMOTE_VERSION=$(curl -sSL "$REPO_URL" | grep -o 'Shell Dancer v[0-9.]*' | head -n1 | cut -d'v' -f2)

        # Get the local version
        LOCAL_VERSION=$($SCRIPT_NAME -v 2>/dev/null | grep -o 'Shell Dancer v[0-9.]*' | head -n1 | cut -d'v' -f2)

        # Validate remote version
        if [ -z "$REMOTE_VERSION" ]; then
            echo "❌ Unable to fetch the remote version. Please check the repository URL."
            exit 1
        fi

        # Validate local version
        if [ -z "$LOCAL_VERSION" ]; then
            echo "❌ Unable to detect the local version. Reinstalling Shell Dancer."
            return 1
        fi

        
        if version_gt "$REMOTE_VERSION" "$LOCAL_VERSION"; then
            echo "✅ Shell Dancer v$LOCAL_VERSION is installed at $(command -v $SCRIPT_NAME)"
            echo "ℹ️ A newer version (v$REMOTE_VERSION) is available!"

            while true; do
                read -r -p "Do you want to update to v$REMOTE_VERSION? [y/N]: " update_choice < /dev/tty
                if [[ "$update_choice" =~ ^[Yy]$ ]]; then
                    return 1  # Update is needed
                elif [[ "$update_choice" =~ ^[Nn]$ ]] || [[ -z "$update_choice" ]]; then
                    echo "Skipping update. Shell Dancer remains at v$LOCAL_VERSION."
                    exit 0
                else
                    echo "Please enter y or n."
                fi
            done
        fi
    fi
    return 0  # Not installed, proceed with installation
}

# Function to download and install Shell Dancer
install_shelldancer() {
    # Find a writable directory in $PATH
    INSTALL_DIR=""
    for dir in $(echo "$PATH" | tr ':' '\n'); do
        if [ -w "$dir" ]; then
            INSTALL_DIR="$dir"
            break
        fi
    done

    if [ -z "$INSTALL_DIR" ]; then
        echo "❌ No writable directory found in \$PATH. Please run this script as root."
        exit 1
    fi

    echo -e "Downloading Shell Dancer..."

    # Simulated progress bar with colors
    curl --progress-bar -sSL "$REPO_URL" -o "$INSTALL_DIR/$SCRIPT_NAME" &
    CURL_PID=$!  # Store the curl process ID

    # Progress bar display
    while kill -0 $CURL_PID 2>/dev/null; do
        for i in $(seq 1 50); do
            BAR=$(printf "\e[42m \e[0m%.0s" $(seq 1 $i))  # Green bar
            SPACES=$(printf "%.0s " $(seq $i 50))  # Empty spaces
            PERCENT=$((i * 2))  # Progress percentage
            echo -ne "[${BAR}${SPACES}] ${PERCENT}%\r"
            sleep 0.1
        done
    done

    wait $CURL_PID  # Wait for curl to finish

    # Check download result
    if [ $? -eq 0 ]; then
        chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
        echo -e "\n✅ Shell Dancer has been installed at $INSTALL_DIR/$SCRIPT_NAME"
    else
        echo -e "\n❌ Failed to download Shell Dancer. Please check your network connection."
        exit 1
    fi
}


# Main script execution
echo "Starting Shell Dancer Installer..."
check_existing
if [ $? -eq 1 ]; then
    install_shelldancer
else
   echo "Completed!"
fi
