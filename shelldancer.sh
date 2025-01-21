#!/bin/bash

# Check if autossh is installed
if ! command -v autossh &> /dev/null; then
    echo "Error: autossh is not installed. Please install it first."
    exit 1
fi

# Function to display menu
display_menu() {
    echo "============================"
    echo "       Shell Dancer"
    echo "   AutoSSH Interactive Tool"
    echo "============================"
    echo "1. Create Port Tunnel"
    echo "2. Create Reverse Shell"
    echo "3. Exit"
    echo -n "Select an option [1-3]: "
}

# Function to configure and start port tunnel
create_port_tunnel() {
    echo "=== Configure Port Tunnel ==="
    read -p "Enter remote host (e.g., user@host.com): " remote_host
    read -p "Enter local port to forward: " local_port
    read -p "Enter remote port to forward to: " remote_port

    echo "Starting port tunnel..."
    autossh -M 0 -f -N -L "$local_port:localhost:$remote_port" "$remote_host"

    if [ $? -eq 0 ]; then
        echo "✅ Port tunnel established successfully!"
    else
        echo "❌ Failed to establish port tunnel."
    fi
}

# Function to configure and start reverse shell
create_reverse_shell() {
    echo "=== Configure Reverse Shell ==="
    read -p "Enter remote host (e.g., user@host.com): " remote_host
    read -p "Enter remote port to bind: " remote_port
    read -p "Enter local port to listen: " local_port

    echo "Starting reverse shell..."
    autossh -M 0 -f -N -R "$remote_port:localhost:$local_port" "$remote_host"

    if [ $? -eq 0 ]; then
        echo "✅ Reverse shell established successfully!"
    else
        echo "❌ Failed to establish reverse shell."
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
            echo "Thank you for using Shell-Dancer! Goodbye! 💃"
            break
            ;;
        *)
            echo "❌ Invalid option. Please try again."
            ;;
    esac
    echo ""
done
