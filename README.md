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

```sh
git clone https://github.com/smilexth/shelldancer.git
cd shelldancer
```

before running the install script, make sure you have the right permissions to execute it which can be done by running following command:

```sh
chmod +x install.sh
```

To install Shell Dancer, run the `install.sh` script from the project directory:

```sh
./install.sh
```



Follow the on-screen instructions to create port tunnels and reverse shells.

## After Installation

Once installed, you can run the script from anywhere using:
```sh
shelldancer
```

## License

This project is licensed under the MIT License.
