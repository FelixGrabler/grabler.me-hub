#!/bin/bash

# Development Quick Start Script
# This script helps quickly start the development environment

set -e

echo "🚀 Grabler.me Hub - Development Quick Start"
echo "==========================================="

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker first."
    exit 1
fi

echo "✅ Docker is running"

# Update submodules
echo "🔄 Updating submodules..."
git submodule update --init --recursive
git submodule foreach git pull origin main

# Setup development environment
echo "🛠️  Setting up development environment..."
make setup-dev

# Start development environment
echo "🚀 Starting development environment..."
make dev

echo ""
echo "🎉 Development environment is starting!"
echo ""
echo "🌐 Your applications will be available at:"
echo "   Main Hub:     http://localhost:8080"
echo "   Felix:        http://felix.localhost:8080"
echo "   MamaRezepte:  http://rezepte.localhost:8080" 
echo "   Namo:         http://namo.localhost:8080"
echo ""
echo "🔧 Direct access (for debugging):"
echo "   Distributor:  http://localhost:3000"
echo "   Felix:        http://localhost:4173"
echo "   MamaRezepte:  http://localhost:5174"
echo "   Namo Frontend: http://localhost:5173"
echo "   Namo API:     http://localhost:8000"
echo ""
echo "📋 Useful commands:"
echo "   make logs-dev    # View logs"
echo "   make dev-down    # Stop environment"
echo "   make health      # Check service health"
echo ""
echo "⏳ Services are starting up... Please wait a moment for all containers to be ready."
