#!/bin/bash

# Node.js Installation Script using nvm
# Installs nvm, Node.js LTS version, and configures the environment

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Node.js installation using nvm...${NC}"

# 1. Install nvm
echo -e "${GREEN}Step 1: Installing nvm (Node Version Manager)...${NC}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

# Load nvm immediately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Verify nvm installation
if ! command -v nvm &> /dev/null; then
    echo -e "${RED}Error: nvm installation failed. Please try manually.${NC}"
    exit 1
fi

# 2. Install Node.js LTS version
echo -e "${GREEN}Step 2: Installing Node.js LTS version...${NC}"
nvm install --lts

# Set LTS as default
nvm alias default 'lts/*'
nvm use default

# 3. Update npm to latest
echo -e "${GREEN}Step 3: Updating npm to latest version...${NC}"
npm install -g npm@latest

# 4. Verify installations
echo -e "${GREEN}Step 4: Verifying installations...${NC}"
node_version=$(node --version)
npm_version=$(npm --version)

echo -e "${YELLOW}Installation complete!${NC}"
echo ""
echo -e "Here are your installed versions:"
echo -e "Node.js: ${GREEN}$node_version${NC}"
echo -e "npm: ${GREEN}$npm_version${NC}"
echo ""
echo -e "${YELLOW}Important Notes:${NC}"
echo -e "1. To check Node.js version anytime, run: ${GREEN}node --version${NC}"
echo -e "2. To check npm version anytime, run: ${GREEN}npm --version${NC}"
echo -e "3. You may need to restart your terminal or run: ${GREEN}source ~/.bashrc${NC}"
echo -e "4. To install additional Node.js versions, use: ${GREEN}nvm install <version>${NC}"
echo -e "5. To switch versions, use: ${GREEN}nvm use <version>${NC}"
echo ""
echo -e "${GREEN}Node.js environment is ready! Happy coding! 🚀${NC}"