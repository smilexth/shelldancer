# Shell Dancer

**Shell Dancer** is an interactive shell tool built using `autossh` to simplify creating port tunnels and reverse shells. It provides an easy-to-use menu-driven interface for Linux users to configure and establish secure SSH tunnels.

---

## Features

- Create **Port Tunnels** (local to remote forwarding).
- Create **Reverse Shells** (remote to local forwarding).
- Simple interactive menu for configuration.
- Lightweight and dynamic, works on most Linux systems.
- Installs globally on your system for easy access.

## Prerequisites

Before using Shell Dancer, ensure the following dependencies are installed on your system:

1. **autossh**: Install it using your package manager:
   ```bash
   sudo apt install autossh  # For Debian/Ubuntu
   sudo yum install autossh  # For CentOS/RedHat
   sudo pacman -S autossh    # For Arch Linux
   brew install autossh      # For macOS
   ```

## Installation

### Option 1: Manual Installation

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

### Option 2: Quick Install using `curl`

```sh
curl -sSL https://raw.githubusercontent.com/smilexth/shelldancer/main/installer.sh | bash
```


Follow the on-screen instructions to create port tunnels and reverse shells.

## After Installation

Once installed, you can run the script from anywhere using:
```sh
shelldancer
```

