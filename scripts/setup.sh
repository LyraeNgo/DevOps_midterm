#!/bin/bash

echo "==============================="
echo "Starting environment setup..."
echo "==============================="

# Update system
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install OS packages
echo "Installing required OS packages..."
sudo apt install -y git curl build-essential

# Install Node.js (runtime)
echo "Installing Node.js runtime..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt install -y nodejs

# Verify installation
echo "Checking Node.js version..."
node -v
npm -v

# Install Docker (optional but useful)
echo "Installing Docker..."
sudo apt install -y docker.io

sudo systemctl start docker
sudo systemctl enable docker

# Create project directories
echo "Creating application directories..."

mkdir -p ../logs
mkdir -p ../uploads
mkdir -p ../data

echo "Directories created:"
echo "- logs"
echo "- uploads"
echo "- data"

echo "==============================="
echo "Environment setup completed!"
echo "=============================="
