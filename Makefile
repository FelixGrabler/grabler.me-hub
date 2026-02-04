.PHONY: help build logs clean up down prod prod-down restart health show-urls

# Default target
help:
	@echo "Available commands:"
	@echo "  up           - Start production environment"
	@echo "  down         - Stop production environment"
	@echo "  build        - Build all services"
	@echo "  logs         - Show logs from all services"
	@echo "  clean        - Remove all containers, volumes, and images"
	@echo "  restart      - Restart all production services"
	@echo "  health       - Check health of all services"
	@echo "  prod         - Alias for up"
	@echo "  prod-down    - Alias for down"

# Production environment
up:
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

down:
	@echo "Stopping production environment..."
	docker-compose down

prod: up

prod-down: down

# Build all services
build:
	@echo "Building all services..."
	docker-compose build

# Show logs
logs:
	@echo "Showing logs from all production services..."
	docker-compose logs -f

# Clean everything
clean:
	@echo "Cleaning up everything..."
	docker-compose down -v --rmi all
	docker system prune -f

# Restart services
restart:
	@echo "Restarting production services..."
	docker-compose restart

# Health check
health:
	@echo "Checking service health..."
	docker-compose ps

# Show service URLs
show-urls:
	@echo "🌐 Production URLs:"
	@echo "  Main:        https://grabler.me"
	@echo "  Felix:       https://felix.grabler.me"
	@echo "  Felix (port): http://<server-ip>:8040"
	@echo "  MamaRezepte: https://rezepte.grabler.me"
	@echo "  Namo:        https://namo.grabler.me"
