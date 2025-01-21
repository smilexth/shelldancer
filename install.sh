#!/bin/bash

# ==========================================================
# Shell Dancer Installer
# Copyright © SmileX
# Dynamically installs Shell Dancer to a directory in $PATH
# ==========================================================

SCRIPT_NAME="shelldancer"
SOURCE_FILE="shelldancer.sh"

# Function to find a writable directory in $PATH
find_install_dir() {
    for dir in $(echo "$PATH" | tr ':' '\n'); do
        if [ -w "$dir" ]; then
            echo "$dir"
            return 0
        fi
    done
    return 1
}

# Check if the user is running the script with sufficient permissions
if [ "$EUID" -ne 0 ] && ! [ -w "$(find_install_dir)" ]; then
    echo "❌ Please run this installer with elevated permissions (e.g., using sudo)."
    exit 1
fi

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "❌ File '$SOURCE_FILE' not found in the current directory. Please ensure it is in this directory."
    exit 1
fi

# Find an installation directory in $PATH
INSTALL_DIR=$(find_install_dir)
if [ -z "$INSTALL_DIR" ]; then
    echo "❌ No writable directory found in \$PATH. Please run this script as root or check your system configuration."
    exit 1
fi

# Install the script
echo "Installing Shell Dancer to $INSTALL_DIR..."
cp "$SOURCE_FILE" "$INSTALL_DIR/$SCRIPT_NAME"

# Make the script executable
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# Verify the installation
if command -v "$SCRIPT_NAME" &> /dev/null; then
    echo "✅ Shell Dancer has been installed successfully!"
    echo "You can now run it using the command: $SCRIPT_NAME"
else
    echo "❌ Installation failed. Please check permissions for $INSTALL_DIR."
    exit 1
fi
