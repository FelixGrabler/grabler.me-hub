#!/bin/bash

# Quick start script for Synology + Traefik setup (DSM SSL termination)

echo "🚀 Synology + Traefik Quick Start (DSM handles SSL)"
echo "=================================================="
echo ""

echo "📋 Step 1: Starting Traefik services..."
docker-compose up -d
echo ""

echo "📋 Step 2: Check if services are running..."
sleep 5
docker-compose ps
echo ""

echo "🎯 Next Steps:"
echo "=============="
echo ""
echo "1. 🔒 Set up SSL certificates in DSM:"
echo "   Control Panel → Security → Certificate"
echo "   Add Let's Encrypt or custom certificates for your domains"
echo ""
echo "2. 🌐 Set up DSM Reverse Proxy:"
echo "   Control Panel → Application Portal → Reverse Proxy"
echo "   Forward your domains (port 443) → localhost:8880 (HTTP)"
echo ""
echo "3. 🔍 Monitor Traefik routing:"
echo "   docker-compose logs -f traefik"
echo ""
echo "4. 🎛️  Access Traefik dashboard:"
echo "   http://$(hostname -I | awk '{print $1}'):8081"
echo ""
echo "5. 🌍 Test your sites:"
echo "   https://grabler.me"
echo "   https://felix.grabler.me" 
echo "   https://rezepte.grabler.me"
echo "   https://namo.grabler.me"
echo ""

echo "🏗️  Architecture:"
echo "================="
echo "Internet → DSM:443 (SSL) → Traefik:8880 (HTTP) → Your Apps"
echo ""

echo "🔧 Useful commands:"
echo "=================="
echo "View logs:           docker-compose logs traefik"
echo "Restart Traefik:     docker-compose restart traefik"
echo "Stop all:            docker-compose down"
echo "Check routing:       curl -H 'Host: grabler.me' http://localhost:8880"
echo ""
