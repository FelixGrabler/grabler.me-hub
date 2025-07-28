#!/bin/bash

# Update Git Submodules Script
# This script updates all git submodules in the project

set -e  # Exit on any error

echo "🔄 Updating Git Submodules..."
echo "================================"

echo "📦 Initializing submodules..."
git submodule update --init --recursive

echo "🚀 Pulling latest changes from all submodules..."
git submodule foreach git pull origin main

echo ""
echo "✅ Submodules updated successfully!"
echo ""
echo "📊 Current submodule status:"
git submodule status

echo ""
echo "🔧 If you need to update a specific submodule:"
echo "   git submodule update --remote <submodule-path>"
echo ""
echo "🔧 If you need to reset a submodule:"
echo "   git submodule update --init --force <submodule-path>"
