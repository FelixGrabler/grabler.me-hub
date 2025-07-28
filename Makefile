.PHONY: help build up down logs clean dev dev-down prod prod-down restart health

# Default target
help:
	@echo "Available commands:"
	@echo "  dev        - Start development environment"
	@echo "  dev-down   - Stop development environment"
	@echo "  prod       - Start production environment"
	@echo "  prod-down  - Stop production environment"
	@echo "  build      - Build all services"
	@echo "  logs       - Show logs from all services"
	@echo "  clean      - Remove all containers, volumes, and images"
	@echo "  restart    - Restart all services"
	@echo "  health     - Check health of all services"
	@echo "  debug      - Start with debug configuration (direct passwords)"
	@echo "  test-namo  - Test only Namo services"

# Development environment
dev:
	@echo "Starting development environment..."
	@echo "Creating global network..."
	docker network create grabler-network 2>/dev/null || true
	@echo "Starting main services..."
	docker-compose -f docker-compose.dev.yml up -d
	@echo "Development environment started!"
	@echo "Main site: http://localhost:8080"
	@echo "Namo site: http://namo.localhost:8080"
	@echo "Direct Namo frontend: http://localhost:5173"
	@echo "Direct Namo API: http://localhost:8000"

dev-down:
	@echo "Stopping development environment..."
	cd Namo && docker-compose -f docker-compose.yml -f ../docker-compose.namo.dev.yml down
	docker-compose -f docker-compose.dev.yml down

# Production environment
prod:
	@echo "Starting production environment..."
	@echo "Creating global network..."
	docker network create grabler-network 2>/dev/null || true
	@echo "Starting main services..."
	docker-compose up -d
	@echo "Starting Namo services..."
	cd Namo && docker-compose -f docker-compose.yml -f ../docker-compose.namo.yml up -d
	@echo "Production environment started!"
	@echo "Configure your DNS to point to this server:"
	@echo "  grabler.me -> your-server-ip"
	@echo "  namo.grabler.me -> your-server-ip"

prod-down:
	@echo "Stopping production environment..."
	cd Namo && docker-compose -f docker-compose.yml -f ../docker-compose.namo.yml down
	docker-compose down

# Build all services
build:
	@echo "Building main services..."
	docker-compose build
	docker-compose -f docker-compose.dev.yml build
	@echo "Building Namo services..."
	docker-compose -f ./Namo/docker-compose.yml build

# Show logs
logs:
	@echo "Showing logs from all production services..."
	docker-compose logs -f &
	docker-compose -f ./Namo/docker-compose.yml -f ./docker-compose.namo.yml logs -f

logs-dev:
	@echo "Showing logs from all development services..."
	docker-compose -f docker-compose.dev.yml logs -f &
	docker-compose -f ./Namo/docker-compose.yml -f ./docker-compose.namo.dev.yml logs -f

# Clean everything
clean:
	@echo "Cleaning up everything..."
	docker-compose down -v --rmi all
	docker-compose -f docker-compose.dev.yml down -v --rmi all
	docker-compose -f ./Namo/docker-compose.yml down -v --rmi all
	docker system prune -f

# Restart services
restart:
	@echo "Restarting main services..."
	docker-compose restart
	@echo "Restarting Namo services..."
	docker-compose -f ./Namo/docker-compose.yml restart

restart-dev:
	docker-compose -f docker-compose.dev.yml restart

# Health check
health:
	@echo "Checking service health..."
	docker-compose ps
	@echo "\nChecking Namo API health:"
	@curl -f http://localhost:8000/health 2>/dev/null && echo "✅ Namo API healthy" || echo "❌ Namo API unhealthy"

# Debug environment with direct passwords
debug:
	@echo "Starting debug environment (using direct passwords)..."
	@echo "Creating global network..."
	docker network create grabler-network 2>/dev/null || true
	@echo "Starting main services..."
	docker-compose up -d
	@echo "Starting Namo services with debug config..."
	docker-compose -f ./Namo/docker-compose.yml -f ./docker-compose.namo.debug.yml up -d
	@echo "Debug environment started!"
	@echo "Check logs with: make logs-debug"

# Test only Namo services
test-namo:
	@echo "Testing Namo services only..."
	@echo "Creating global network..."
	docker network create grabler-network 2>/dev/null || true
	@echo "Starting Namo services..."
	docker-compose -f ./Namo/docker-compose.yml -f ./docker-compose.namo.debug.yml up -d
	@echo "Namo services started!"
	@echo "Check with: docker-compose -f ./Namo/docker-compose.yml -f ./docker-compose.namo.debug.yml ps"

logs-debug:
	@echo "Showing debug logs..."
	docker-compose -f ./Namo/docker-compose.yml -f ./docker-compose.namo.debug.yml logs -f
update-submodules:
	git submodule update --init --recursive
	git submodule foreach git pull origin main

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
