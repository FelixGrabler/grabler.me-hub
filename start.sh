#!/bin/bash

# Grabler.me Hub Startup Script

set -e

echo "🚀 Grabler.me Hub Setup"
echo "======================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Check if Make is installed
if ! command -v make &> /dev/null; then
    echo "⚠️  Make is not installed. You can still use docker-compose commands directly."
fi

echo "✅ Prerequisites check passed!"
echo ""

# Ask user for environment
echo "Which environment would you like to start?"
echo "1) Development (with hot reload)"
echo "2) Production"
echo ""
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo ""
        echo "🔧 Starting development environment..."
        echo ""
        if command -v make &> /dev/null; then
            make dev
        else
            docker-compose -f docker-compose.dev.yml up -d
        fi
        echo ""
        echo "✅ Development environment started!"
        echo ""
        echo "📱 Access your applications:"
        echo "   Main hub: http://localhost:8080"
        echo "   Namo: http://namo.localhost:8080"
        echo ""
        echo "🔧 Direct access (development):"
        echo "   Distributor frontend: http://localhost:3000"
        echo "   Namo frontend: http://localhost:5173"
        echo "   Namo API: http://localhost:8000"
        echo ""
        echo "📝 View logs with: make logs-dev (or docker-compose -f docker-compose.dev.yml logs -f)"
        ;;
    2)
        echo ""
        echo "🏭 Starting production environment..."
        echo ""
        if command -v make &> /dev/null; then
            make prod
        else
            docker-compose up -d
        fi
        echo ""
        echo "✅ Production environment started!"
        echo ""
        echo "🌐 Configure your DNS to point to this server:"
        echo "   grabler.me -> $(curl -s ifconfig.me 2>/dev/null || echo 'your-server-ip')"
        echo "   *.grabler.me -> $(curl -s ifconfig.me 2>/dev/null || echo 'your-server-ip')"
        echo ""
        echo "📝 View logs with: make logs (or docker-compose logs -f)"
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again and choose 1 or 2."
        exit 1
        ;;
esac

echo ""
echo "🎉 Setup complete! Happy coding!"
