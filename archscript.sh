#!/bin/bash

# Sync packages
yay -Syu

# Install neovim and dependencies
yay -S neovim gcc make cmake unzip
