.PHONY: help build logs logs-dev clean dev dev-down prod prod-down restart restart-dev health show-urls

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
	@echo "  Felix (port):  http://localhost:8040"
	@echo "  MamaRezepte:   http://rezepte.localhost:8080"
	@echo "  Namo:          http://namo.localhost:8080"
	@echo ""
	@echo "🔧 Direct access (for debugging):"
	@echo "  Distributor:   http://localhost:3000"

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
	@echo ""
	@echo "📌 Direct Felix access: http://<server-ip>:8040"

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
	@docker-compose ps
	@docker-compose -f docker-compose.dev.yml ps

# Show service URLs
show-urls:
	@echo "🌐 Development URLs:"
	@echo "  Main:        http://localhost:8080"
	@echo "  Felix:       http://felix.localhost:8080"
	@echo "  Felix (port): http://localhost:8040"
	@echo "  MamaRezepte: http://rezepte.localhost:8080"
	@echo "  Namo:        http://namo.localhost:8080"
	@echo ""
	@echo "🌐 Production URLs (when deployed):"
	@echo "  Main:        https://grabler.me"
	@echo "  Felix:       https://felix.grabler.me"
	@echo "  Felix (port): http://<server-ip>:8040"
	@echo "  MamaRezepte: https://rezepte.grabler.me"
	@echo "  Namo:        https://namo.grabler.me"
