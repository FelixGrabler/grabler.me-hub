.PHONY: help build up down logs clean dev dev-down prod prod-down restart health update-submodules

# Default target
help:
	@echo "Available commands:"
	@echo "  dev          - Start development environment"
	@echo "  dev-down     - Stop development environment"
	@echo "  prod         - Start production environment"
	@echo "  prod-down    - Stop production environment"
	@echo "  build        - Build all services"
	@echo "  logs         - Show logs from all services"
	@echo "  logs-dev     - Show logs from development services"
	@echo "  clean        - Remove all containers, volumes, and images"
	@echo "  restart      - Restart all production services"
	@echo "  restart-dev  - Restart all development services"
	@echo "  health       - Check health of all services"
	@echo "  update-submodules - Update all git submodules"
	@echo "  setup-dev    - Setup development environment (create example secrets)"

# Development environment
dev:
	@echo "Starting development environment..."
	@echo "Creating global network..."
	docker network create grabler-network 2>/dev/null || true
	@echo "Starting all development services..."
	docker-compose -f docker-compose.dev.yml up -d
	@echo "Development environment started!"
	@echo ""
	@echo "🌐 Available sites:"
	@echo "  Main site:     http://localhost:8080"
	@echo "  Felix:         http://felix.localhost:8080"
	@echo "  MamaRezepte:   http://rezepte.localhost:8080"
	@echo "  Namo:          http://namo.localhost:8080"
	@echo ""
	@echo "🔧 Direct access (for debugging):"
	@echo "  Distributor:   http://localhost:3000"
	@echo "  Felix:         http://localhost:4173"
	@echo "  MamaRezepte:   http://localhost:5174"
	@echo "  Namo Frontend: http://localhost:5173"
	@echo "  Namo API:      http://localhost:8000"
	@echo "  Database:      localhost:5432"

dev-down:
	@echo "Stopping development environment..."
	docker-compose -f docker-compose.dev.yml down

# Production environment
prod:
	@echo "Starting production environment..."
	@echo "Creating global network..."
	docker network create grabler-network 2>/dev/null || true
	@echo "Starting all production services..."
	docker-compose up --build -d
	@echo "Production environment started!"
	@echo ""
	@echo "🌐 Configure your DNS to point to this server:"
	@echo "  grabler.me -> your-server-ip"
	@echo "  felix.grabler.me -> your-server-ip"
	@echo "  rezepte.grabler.me -> your-server-ip"
	@echo "  namo.grabler.me -> your-server-ip"

prod-down:
	@echo "Stopping production environment..."
	docker-compose down

# Build all services
build:
	@echo "Building all services..."
	docker-compose build
	docker-compose -f docker-compose.dev.yml build

# Show logs
logs:
	@echo "Showing logs from all production services..."
	docker-compose logs -f

logs-dev:
	@echo "Showing logs from all development services..."
	docker-compose -f docker-compose.dev.yml logs -f

# Clean everything
clean:
	@echo "Cleaning up everything..."
	docker-compose down -v --rmi all
	docker-compose -f docker-compose.dev.yml down -v --rmi all
	docker system prune -f

# Restart services
restart:
	@echo "Restarting production services..."
	docker-compose restart

restart-dev:
	@echo "Restarting development services..."
	docker-compose -f docker-compose.dev.yml restart

# Health check
health:
	@echo "Checking service health..."
	@echo ""
	@echo "🔍 Production services:"
	docker-compose ps
	@echo ""
	@echo "🔍 Development services:"
	docker-compose -f docker-compose.dev.yml ps
	@echo ""
	@echo "🏥 Health checks:"
	@curl -f http://localhost:8000/health 2>/dev/null && echo "✅ Namo API healthy" || echo "❌ Namo API unhealthy"

# Update git submodules
update-submodules:
	@echo "Updating git submodules..."
	@echo "Initializing submodules..."
	git submodule update --init --recursive
	@echo "Pulling latest changes from all submodules..."
	git submodule foreach git pull origin main
	@echo "✅ Submodules updated!"
	@echo ""
	@echo "📦 Submodule status:"
	git submodule status

# Setup development environment
setup-dev:
	@echo "Setting up development environment..."
	@echo "Checking if secrets exist..."
	@if [ ! -f "./Namo/secrets/dev_postgres_password.txt" ]; then \
		echo "Creating example secrets..."; \
		mkdir -p ./Namo/secrets; \
		echo "dev_password_123" > ./Namo/secrets/dev_postgres_password.txt; \
		echo "your-secret-key-here" > ./Namo/secrets/dev_secret_key.txt; \
		echo "your-telegram-bot-token" > ./Namo/secrets/telegram_bot_token.txt; \
		echo "your-telegram-chat-id" > ./Namo/secrets/dev_telegram_chat_id.txt; \
		echo "⚠️  Please update the secrets in ./Namo/secrets/ before starting!"; \
	fi
	@echo "✅ Development setup complete!"

# Quick commands for specific services
felix-dev:
	@echo "Starting only Felix in development mode..."
	docker-compose -f docker-compose.dev.yml up felix -d

mama-rezepte-dev:
	@echo "Starting only MamaRezepte in development mode..."
	docker-compose -f docker-compose.dev.yml up mama-rezepte -d

namo-dev:
	@echo "Starting only Namo services in development mode..."
	docker-compose -f docker-compose.dev.yml up namo-db namo-backend namo-frontend -d

# Show service URLs
show-urls:
	@echo "🌐 Development URLs:"
	@echo "  Main:        http://localhost:8080"
	@echo "  Felix:       http://felix.localhost:8080"
	@echo "  MamaRezepte: http://rezepte.localhost:8080"
	@echo "  Namo:        http://namo.localhost:8080"
	@echo ""
	@echo "🌐 Production URLs (when deployed):"
	@echo "  Main:        https://grabler.me"
	@echo "  Felix:       https://felix.grabler.me"
	@echo "  MamaRezepte: https://rezepte.grabler.me"
	@echo "  Namo:        https://namo.grabler.me"
