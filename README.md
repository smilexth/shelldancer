# 🕺 Shell Dancer

**Shell Dancer** is an interactive shell tool built using `autossh` to simplify creating port tunnels and reverse shells. It provides an easy-to-use menu-driven interface for Linux users to configure and establish secure SSH tunnels.

🌐 **Official Website**: [https://dancer.sh](https://dancer.sh)

---

## ✨ Features

- Create **Port Tunnels** (local to remote forwarding).
- Create **Reverse Shells** (remote to local forwarding).
- Simple interactive menu for configuration.
- Lightweight and dynamic, works on most Linux systems.
- Installs globally on your system for easy access.

## 🌐 Why Use SSH Tunneling for Web Services?

SSH tunneling is particularly useful for web services in several scenarios:

1. **Local Development with External Services**
   - Access a production database locally while developing
   - Test webhooks on your local development server
   - Connect local applications to cloud services securely

2. **Bypassing Network Restrictions**
   - Access internal web services from outside the network
   - Reach development servers behind firewalls
   - Connect to staging environments without public IP addresses

3. **Security Benefits**
   - Encrypt traffic between services
   - Access services without exposing them to the public internet
   - Create secure paths through untrusted networks

For example, if you're developing a web application that needs to connect to a database on port 3306, you can use Shell Dancer to create a secure tunnel:
```
Local Machine (3306) <-> SSH Tunnel <-> Remote Database (3306)
```

## 📋 Prerequisites

Before using Shell Dancer, ensure the following dependencies are installed on your system:

1. **autossh**: Install it using your package manager:
   ```bash
   sudo apt install autossh  # For Debian/Ubuntu
   sudo yum install autossh  # For CentOS/RedHat
   sudo pacman -S autossh    # For Arch Linux
   brew install autossh      # For macOS
   ```

## 🛠️ Installation

### ⚡ Option 1: Official Quick Install using `curl`

```sh
curl -fsSL https://dancer.sh/installer.sh | sh
```


Follow the on-screen instructions to create port tunnels and reverse shells.


### 📝 Option 2: Manual Installation from Repository

```sh
git clone https://github.com/smilexth/shelldancer.git
cd shelldancer
```

before running the install script, make sure you have the right permissions to execute it which can be done by running following command:

```sh
chmod +x installer.sh
```

To install Shell Dancer, run the `installer.sh` script from the project directory:

```sh
./installer.sh
```


## 🚀 After Installation

Once installed, you can run the script from anywhere using:
```sh
shelldancer
```

## 📖 Usage

To use Shell Dancer, follow these steps:

1. Run the Shell Dancer script:
   ```sh
   shelldancer
   ```

2. You will see the Shell Dancer menu with options to create a tunnel or exit.

3. Select "Create Tunnel" by entering `1`.

4. Follow the prompts to enter the necessary details:
   - SSH port (default is 22)
   - SSH username
   - SSH hostname (remote server address)
   - Full path to your SSH key file
   - Remote port to bind (traffic will come to this port)
   - Local port to listen on (traffic will be forwarded here)

5. Shell Dancer will validate the SSH key file and check if the remote port is in use. If the port is available, it will create the tunnel using `autossh`.

6. If the tunnel is created successfully, you will see a confirmation message. If it fails, you will be prompted to try again.

## 🔄 Running autossh as a Service

To make `autossh` run as a service and start tunnels automatically using ```systemd``` on Debian/Ubuntu or ```launchd``` on macOS, follow the instructions below:

1. Create a systemd service file for `autossh`:
   ```sh
   sudo nano /etc/systemd/system/autossh-tunnel.service
   ```

2. Add the following content to the service file:
   ```ini
   [Unit]
   Description=AutoSSH Tunnel Service
   After=network.target

   [Service]
   Environment="AUTOSSH_GATETIME=0"
   ExecStart=/usr/bin/autossh -M 0 -N -L [LOCAL_PORT]:[REMOTE_HOST]:[REMOTE_PORT] [USER]@[REMOTE_HOST]
   User=[YOUR_USERNAME]
   Restart=always

   [Install]
   WantedBy=multi-user.target
   ```

   Replace `[LOCAL_PORT]`, `[REMOTE_HOST]`, `[REMOTE_PORT]`, `[USER]`, and `[YOUR_USERNAME]` with your specific details.

3. Reload systemd to recognize the new service:
   ```sh
   sudo systemctl daemon-reload
   ```

4. Enable the service to start on boot:
   ```sh
   sudo systemctl enable autossh-tunnel.service
   ```

5. Start the service:
   ```sh
   sudo systemctl start autossh-tunnel.service
   ```

6. Check the status of the service to ensure it is running:
   ```sh
   sudo systemctl status autossh-tunnel.service
   ```

This will ensure that your SSH tunnel starts automatically on system boot and restarts if it fails.

### 🍏 MacOS Using Brew to make autossh run as a Service

1. Install autossh using brew:
   ```sh
   brew install autossh
   ```
2. Create a plist file for autossh:
   ```sh
   nano ~/Library/LaunchAgents/com.autossh.tunnel.plist
   ```
3. Add the following content to the plist file:
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>Label</key>
       <string>com.autossh.tunnel</string>
       <key>ProgramArguments</key>
       <array>
           <string>/usr/local/bin/autossh</string>
           <string>-M</string>
           <string>0</string>
           <string>-N</string>
           <string>-L</string>
           <string>[LOCAL_PORT]:[REMOTE_HOST]:[REMOTE_PORT]</string>
           <string>[USER]@[REMOTE_HOST]</string>
       </array>
       <key>RunAtLoad</key>
       <true/>
       <key>KeepAlive</key>
       <true/>
   </dict>
   </plist>
   ```
   Replace `[LOCAL_PORT]`, `[REMOTE_HOST]`, `[REMOTE_PORT]`, `[USER]`, and `[YOUR_USERNAME]` with your specific details.

4. Load the plist file:
   ```sh
   launchctl load ~/Library/LaunchAgents/com.autossh.tunnel.plist
   ```
5. Start the service:
   ```sh
   launchctl start com.autossh.tunnel
   ```
6. Check the status of the service to ensure it is running:
   ```sh
   launchctl list | grep autossh
   ```
---

## 📅 Roadmap

📅 [Q2/2025] Switch option between `ssh` and `autossh` \
📅 [Q2/2025] Automate run as a Services (Optional Generate) \
📅 [Q2/2025] Support on another distributions

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

