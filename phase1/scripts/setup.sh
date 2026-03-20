#!/bin/bash
set -e

echo "============================="
echo "Starting environment setup..."
echo "============================="

# Check OS (Ubuntu/Debian-based)
if ! command -v apt &> /dev/null
then
  echo "[ERROR] This script supports Ubuntu/Debian only."
  exit 1
fi

# Check sudo/root
if [ "$EUID" -ne 0 ]; then
  echo "[ERROR] Please run with sudo privileges"
  exit 1
fi

# Update system
echo "[1/6] Updating system..."
apt update -y

# Install basic tools
echo "[2/6] Installing basic tools..."
apt install -y git curl build-essential

# Install Node.js (LTS 20.x)
echo "[3/6] Checking Node.js..."
if ! command -v node &> /dev/null
then
  echo "Installing Node.js (LTS 20.x)..."
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  apt install -y nodejs
else
  echo "Node.js already installed"
fi

# Install Docker
echo "[4/6] Checking Docker..."
if ! command -v docker &> /dev/null
then
  echo "Installing Docker..."
  apt install -y docker.io
  systemctl start docker
  systemctl enable docker
  usermod -aG docker $SUDO_USER
else
  echo "Docker already installed"
fi

# Create necessary directories
echo "[5/6] Creating project directories..."
mkdir -p ../uploads

# Setup environment file
echo "Initializing .env file..."
if [ ! -f .env ]; then
  touch .env
fi

# Install dependencies
echo "[6/6] Installing project dependencies..."
npm install

echo "============================="
echo "Setup completed successfully!"
echo "============================="
