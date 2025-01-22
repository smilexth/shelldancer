#!/bin/bash

# ==========================================================
# Shell Dancer Installer
# Copyright © SmileX
# This script installs or updates Shell Dancer on your system
# ==========================================================

SCRIPT_NAME="shelldancer"
REPO_URL="https://raw.githubusercontent.com/smilexth/shelldancer/main/shelldancer"

# Function to check if shelldancer is already installed
check_existing() {
    if command -v "$SCRIPT_NAME" &> /dev/null; then
        REMOTE_VERSION="$(curl -sSL "$REPO_URL" | sed -n -E 's/^.*echo \"(Shell Dancer v[0-9\.]+)\"$/\1/p')"
        LOCAL_VERSION="$($SCRIPT_NAME -v 2>/dev/null)"
        if [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ]; then
            echo "✅ Shell Dancer is already the latest version ($LOCAL_VERSION)."
            exit 0
        fi
        echo "✅ Shell Dancer is installed at $(command -v $SCRIPT_NAME)"
        read -p "Do you want to update it? [y/N]: " update_choice
        if [[ "$update_choice" =~ ^[Yy]$ ]]; then
            echo "Updating Shell Dancer..."
            return 1
        else
            echo "Installation aborted."
            exit 0
        fi
    fi
    return 0
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

    echo -ne "Downloading Shell Dancer... Please wait. "
    for i in {1..100}; do
        barCount=$((i/5))
        bar=""
        for ((j=1; j<=barCount; j++)); do
            bar="${bar}I"
        done
        echo -ne "[ ${bar} ${i}% ]\r"
        sleep 0.02
    done
    echo ""
    curl --progress-bar -sSL "$REPO_URL" -o "$INSTALL_DIR/$SCRIPT_NAME"

    if [ $? -eq 0 ]; then
        chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
        echo "✅ Shell Dancer has been installed at $INSTALL_DIR/$SCRIPT_NAME"
    else
        echo "❌ Failed to download Shell Dancer. Please check your network connection."
        exit 1
    fi
}

# Main script execution
echo "Starting Shell Dancer Installer..."
check_existing
if [ $? -eq 1 ]; then
    install_shelldancer
else
    echo "Installing Shell Dancer..."
    install_shelldancer
fi
