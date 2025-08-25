#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <aur package name>"
    exit 1
elif [ "$1" = "help" ]; then
    echo "Helper script to get and install an AUR package from the GitHub Mirror"
    exit 0
else
    if [ -d "./.aur-temp" ]; then
        rm -rf ./.aur-temp
    fi
    if git ls-remote --exit-code --heads https://github.com/archlinux/aur.git "$1" > /dev/null; then
        git clone --branch "$1" --single-branch https://github.com/archlinux/aur.git ./.aur-temp
    else
        echo "Error: Package '$1' does not exist in AUR."
        exit 1
    fi
fi
cd ./.aur-temp || exit 1
makepkg -si
