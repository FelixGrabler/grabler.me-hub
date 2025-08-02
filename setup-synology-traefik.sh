#!/bin/bash

# Synology NAS + Traefik Setup (DSM handles SSL)
# This setup lets DSM handle SSL termination while Traefik routes HTTP internally

echo "🚀 Setting up Traefik for Synology NAS (DSM SSL Termination)"
echo "============================================================"
echo ""

# Ensure proper permissions for any remaining files
if [ -d "traefik/acme" ]; then
    echo "ℹ️  Note: ACME directory exists but not needed (DSM handles SSL)"
fi

echo ""
echo "📋 SETUP CHECKLIST:"
echo "=================="
echo ""
echo "1. 🌐 DNS Configuration:"
echo "   Configure these DNS records to point to your Synology's public IP:"
echo "   - grabler.me → YOUR_PUBLIC_IP"
echo "   - felix.grabler.me → YOUR_PUBLIC_IP"
echo "   - rezepte.grabler.me → YOUR_PUBLIC_IP"
echo "   - namo.grabler.me → YOUR_PUBLIC_IP"
echo ""

echo "2. 🔧 Synology DSM Reverse Proxy Setup:"
echo "   Go to: Control Panel → Application Portal → Reverse Proxy"
echo "   Create these rules:"
echo ""
echo "   Rule 1: grabler.me"
echo "   - Source: grabler.me, Port 443, HTTPS"
echo "   - Destination: localhost, Port 8880, HTTP"
echo ""
echo "   Rule 2: felix.grabler.me"
echo "   - Source: felix.grabler.me, Port 443, HTTPS" 
echo "   - Destination: localhost, Port 8880, HTTP"
echo ""
echo "   Rule 3: rezepte.grabler.me"
echo "   - Source: rezepte.grabler.me, Port 443, HTTPS"
echo "   - Destination: localhost, Port 8880, HTTP"
echo ""
echo "   Rule 4: namo.grabler.me"
echo "   - Source: namo.grabler.me, Port 443, HTTPS"
echo "   - Destination: localhost, Port 8880, HTTP"
echo ""

echo "3. 🔒 SSL Certificate Setup:"
echo "   Go to: Control Panel → Security → Certificate"
echo "   Add certificates for your domains (Let's Encrypt or custom)"
echo "   Assign certificates to your reverse proxy rules"
echo ""

echo "4. 🚀 Start Services:"
echo "   docker-compose up -d"
echo ""

echo "5. 🎛️  Access Points:"
echo "   - Traefik Dashboard: http://YOUR_SYNOLOGY_IP:8081"
echo "   - Direct HTTP access (for testing): http://YOUR_SYNOLOGY_IP:8880"
echo "   - Your websites: https://grabler.me, https://felix.grabler.me, etc."
echo ""

echo "🔒 ARCHITECTURE:"
echo "================"
echo "Internet → DSM (443, SSL termination) → Traefik (8880, HTTP routing) → Apps"
echo ""
echo "✅ Benefits:"
echo "- DSM manages SSL certificates automatically"
echo "- No conflicts with DSM services"
echo "- Simple HTTP routing in Traefik"
echo "- All traffic encrypted from internet to DSM"
echo ""

echo "🛠️  TROUBLESHOOTING:"
echo "=================="
echo "- If sites don't load: Verify DSM reverse proxy rules point to port 8880"
echo "- If dashboard not accessible: Check port 8081 is open"
echo "- For logs: docker-compose logs traefik"
echo "- SSL issues: Check DSM certificate assignment"
echo ""

echo "Setup script completed! Follow the checklist above to complete the configuration."
