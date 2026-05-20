#!/bin/bash

set -e

echo "====================================="
echo " Linux Kernel Upgrade Script"
echo "====================================="

# Check root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root"
   exit 1
fi

echo "[1] Updating package list..."
apt update

echo "[2] Upgrading installed packages..."
apt upgrade -y

echo "[3] Installing latest kernel..."
apt install --install-recommends linux-generic -y
# apt install --install-recommends linux-generic-hwe-24.04 -y

echo "[4] Removing unused kernels..."
apt autoremove -y

echo "[5] Current Kernel:"
uname -r

echo "[6] Checking newest installed kernel..."
dpkg --list | grep linux-image

echo "====================================="
echo "Kernel update completed"
echo "System reboot required"
echo "====================================="

read -p "Reboot now? (y/n): " reboot_ans

if [[ $reboot_ans == "y" ]]; then
    reboot
fi
