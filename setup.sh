#!/bin/bash

# ============================================
# GitHub Actions CI/CD Project Setup Script
# ============================================
# This script helps you set up and test the project locally

set -e  # Exit on error

echo "🚀 GitHub Actions CI/CD Project Setup"
echo "======================================"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
print_step() {
    echo -e "${BLUE}➜${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if Python is installed
print_step "Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3.9 or higher."
    exit 1
fi
print_success "Python $(python3 --version) found"
echo ""

# Install Python dependencies
print_step "Installing Python dependencies..."
pip install -r requirements.txt
print_success "Dependencies installed"
echo ""

# Run tests
print_step "Running tests..."
pytest -v
print_success "All tests passed!"
echo ""

# Check if Docker is installed
print_step "Checking Docker installation..."
if ! command -v docker &> /dev/null; then
    print_warning "Docker is not installed. Skipping Docker build test."
    print_warning "Install Docker from: https://docs.docker.com/get-docker/"
else
    print_success "Docker $(docker --version) found"
    echo ""
    
    # Build Docker image
    print_step "Building Docker image..."
    docker build -t flask-test-local .
    print_success "Docker image built successfully!"
    echo ""
    
    print_step "You can now run the container with:"
    echo "  docker run -p 5000:5000 flask-test-local"
fi

echo ""
echo "======================================"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Create a GitHub repository"
echo "2. Create a Docker Hub account (https://hub.docker.com)"
echo "3. Configure GitHub secrets (DOCKER_USERNAME, DOCKER_PASSWORD)"
echo "4. Push your code to GitHub"
echo "5. Watch the GitHub Actions workflow run!"
echo ""
echo "For detailed instructions, see README.md"
echo ""
