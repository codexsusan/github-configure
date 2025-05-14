#!/bin/bash

# GitHub EC2 Auto-Configuration Script
# Usage: ./github-ec2-setup.sh "Your Name" "your.email@example.com" "your_github_username"

# Check for required arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 \"Your Name\" \"your.email@example.com\" \"your_github_username\""
    exit 1
fi

USER_NAME=$1
USER_EMAIL=$2
GITHUB_USERNAME=$3

echo "Starting GitHub configuration for EC2 instance..."

# Update packages and install git
echo "Installing git..."
if command -v yum &> /dev/null; then
    sudo yum update -y
    sudo yum install git -y
elif command -v apt-get &> /dev/null; then
    sudo apt-get update -y
    sudo apt-get install git -y
else
    echo "Package manager not found. Please install git manually."
    exit 1
fi

# Configure git
echo "Configuring git..."
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git config --global init.defaultBranch main
git config --global pull.rebase true

# Generate SSH key
echo "Generating SSH key..."
SSH_DIR="$HOME/.ssh"
mkdir -p "$SSH_DIR"
ssh-keygen -t ed25519 -C "$USER_EMAIL" -f "$SSH_DIR/id_github" -N ""

# Add key to SSH agent
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/id_github"

# Create SSH config file
cat > "$SSH_DIR/config" <<EOL
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_github
    IdentitiesOnly yes
EOL

chmod 600 "$SSH_DIR/config"

# Display public key
echo ""
echo "Public key generated. Please add this to your GitHub account:"
echo "https://github.com/settings/ssh/new"
echo ""
cat "$SSH_DIR/id_github.pub"
echo ""

# Test connection (will fail until key is added to GitHub)
echo "After adding the key to GitHub, you can test the connection with:"
echo "ssh -T git@github.com"
echo "You should see a welcome message with your GitHub username."

# Optional: Set up HTTPS credential helper
# git config --global credential.helper store

echo "GitHub configuration script completed successfully!"