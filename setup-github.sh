#!/bin/bash

# GitHub Repository Setup Script for Apex Physical Therapy Website
# This script helps you connect this project to GitHub and deploy to Netlify

set -e

echo "=== GitHub Repository Setup ==="
echo ""

# Check if git is available
if ! command -v git &> /dev/null; then
    echo "Error: git is not installed or not in PATH"
    exit 1
fi

# Get current directory name
CURRENT_DIR=$(basename "$PWD")
echo "Current directory: $CURRENT_DIR"
echo ""

# Ask for GitHub information
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter repository name (default: apex-physical-therapy): " REPO_NAME
REPO_NAME=${REPO_NAME:-apex-physical-therapy}

# Check if remote already exists
if git remote get-url origin &> /dev/null; then
    echo "Warning: git remote 'origin' already exists."
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting."
        exit 1
    fi
    git remote remove origin
fi

# Set up remote
echo ""
echo "Setting up remote: https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# Create README note
echo ""
echo "=== Next Steps ==="
echo "1. Create a new repository on GitHub:"
echo "   - Go to https://github.com/new"
echo "   - Repository name: $REPO_NAME"
echo "   - Description: 'Apex Physical Therapy website - High-Transparency Clinical Minimalism design'"
echo "   - DO NOT initialize with README, .gitignore, or license"
echo "   - Click 'Create repository'"
echo ""
echo "2. Push your code:"
echo "   Run the following commands:"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Deploy to Netlify:"
echo "   - Go to https://app.netlify.com"
echo "   - Sign up/login"
echo "   - Click 'New site from Git'"
echo "   - Choose GitHub, authorize, select your repository"
echo "   - Build settings: leave blank (static site)"
echo "   - Click 'Deploy site'"
echo ""
echo "4. Your site will be live at: https://[random-name].netlify.app"
echo "   You can add a custom domain later."
echo ""
echo "Script complete. Follow the steps above to deploy your website."