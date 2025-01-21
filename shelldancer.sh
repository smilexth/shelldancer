#!/bin/bash
# ==========================================================
# Shell Dancer - Interactive AutoSSH Tool
# Copyright © SmileX
# Licensed for personal or professional use.
# Redistribution and modification are permitted with attribution.
# ==========================================================
# GitHub Repository: https://github.com/smilexth/shelldancer
# ==========================================================

# Color definitions
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if autossh is installed
if ! command -v autossh &> /dev/null; then
    echo "Error: autossh is not installed. Please install it first."
    exit 1
fi

# Function to display menu
display_menu() {
    echo -e "${BLUE}============================${NC}"
    echo -e "${YELLOW}       Shell Dancer${NC}"
    echo -e "${YELLOW}   AutoSSH Interactive Tool${NC}"
    echo -e "${YELLOW}       (c) SmileX${NC}"
    echo -e "${YELLOW}GitHub: https://github.com/smilexth/shelldancer${NC}"
    echo -e "${BLUE}============================${NC}"
    echo -e "1. Create Port Tunnel"
    echo -e "2. Create Reverse Shell"
    echo -e "3. Exit"
    echo -n "Select an option [1-3]: "
}

# Function to configure and start port tunnel
create_port_tunnel() {
    echo -e "${BLUE}=== Configure Port Tunnel ===${NC}"
    read -p "Enter remote host (e.g., user@host.com): " remote_host
    read -p "Enter local port to forward: " local_port
    read -p "Enter remote port to forward to: " remote_port

    echo "Starting port tunnel..."
    autossh -M 0 -f -N -L "$local_port:localhost:$remote_port" "$remote_host"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Port tunnel established successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to establish port tunnel.${NC}"
    fi
}

# Function to configure and start reverse shell
create_reverse_shell() {
    echo -e "${BLUE}=== Configure Reverse Shell ===${NC}"
    read -p "Enter remote host (e.g., user@host.com): " remote_host
    read -p "Enter remote port to bind: " remote_port
    read -p "Enter local port to listen: " local_port

    echo "Starting reverse shell..."
    autossh -M 0 -f -N -R "$remote_port:localhost:$local_port" "$remote_host"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Reverse shell established successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to establish reverse shell.${NC}"
    fi
}

# Main loop
while true; do
    display_menu
    read choice

    case $choice in
        1)
            create_port_tunnel
            ;;
        2)
            create_reverse_shell
            ;;
        3)
            echo -e "${GREEN}Thank you for using Shell Dancer! Goodbye! 💃${NC}"
            break
            ;;
        *)
            echo -e "${RED}❌ Invalid option. Please try again.${NC}"
            ;;
    esac
    echo ""
done
