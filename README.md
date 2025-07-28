# Grabler.me Hub

A distributed project hub

````
grabler.me-hub/
├── docker-compose.yml              # Main hub (production)
├── docker-compose.dev.yml          # Main hub (development)
├── docker-compose.namo.yml         # Namo integration overrides (production)
├── docker-compose.namo.dev.yml     # Namo integration overrides (development)
├── Makefile                        # Management commands
├── README.md                       # This file
├── distributor-frontend/           # Main hub website (Vue.js)
│   ├── src/
│   ├── Dockerfile
│   ├── Dockerfile.dev
│   └── package.json
├── proxy/                          # Nginx configuration
│   ├── nginx.conf                 # Production config
│   └── nginx.dev.conf             # Development config
└── Namo/                          # Namo project (submodule)
    ├── docker-compose.yml         # Original Namo services
    ├── app/
    │   ├── backend/               # FastAPI backend
    │   └── frontend/              # Vue.js frontend
    └── secrets/                   # Namo secrets
```ing page for multiple applications, each running on their own subdomain. The hub uses Docker Compose to orchestrate multiple projects and an Nginx proxy to route traffic based on subdomains.

## 🏗️ Architecture

The project uses a **compose file overlay pattern** to avoid duplicating service definitions:

````

Main Compose Files:
├── docker-compose.yml # Main hub services (production)
├── docker-compose.dev.yml # Main hub services (development)
└── Subproject Integration:
├── Namo/docker-compose.yml # Original Namo services
├── docker-compose.namo.yml # Production overrides for global integration
└── docker-compose.namo.dev.yml # Development overrides for global integration

```

This approach means:
- ✅ **No duplication**: Each subproject keeps its own docker-compose.yml
- ✅ **Clean integration**: Small override files handle global network integration
- ✅ **Maintainable**: Changes to subprojects don't require updating the main compose
- ✅ **Flexible**: Easy to add/remove subprojects

```

┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ grabler.me │ │ namo.grabler.me │ │ app3.grabler.me │
│ (Vue.js app) │ │ (Namo app) │ │ (Future app) │
└─────────────────┘ └─────────────────┘ └─────────────────┘
│ │ │
└───────────────────────┼───────────────────────┘
│
┌─────────────────┐
│ Nginx Proxy │
│ (Port 80/443) │
└─────────────────┘
│
┌─────────────────┐
│ Docker Network │
│ grabler-net │
└─────────────────┘

```

## 🚀 Features

- **Main Hub**: Vue.js application displaying project tiles with descriptions and links
- **Subdomain Routing**: Nginx proxy automatically routes subdomains to appropriate containers
- **Dockerized**: All services run in Docker containers for easy deployment
- **Development Mode**: Hot-reload development environment with direct port access
- **Production Ready**: Optimized builds with caching, compression, and security headers

## 📁 Project Structure

```

grabler.me-hub/
├── docker-compose.yml # Production configuration
├── docker-compose.dev.yml # Development configuration
├── Makefile # Management commands
├── README.md # This file
├── distributor/ # Main hub website (Vue.js)
│ ├── src/
│ ├── Dockerfile
│ ├── Dockerfile.dev
│ └── package.json
├── proxy/ # Nginx configuration
│ ├── nginx.conf # Production config
│ └── nginx.dev.conf # Development config
└── Namo/ # Namo project (submodule)
├── app/
│ ├── backend/ # FastAPI backend
│ └── frontend/ # Vue.js frontend
└── docker-compose.yml

````

## 🛠️ Setup and Usage

### Prerequisites

- Docker and Docker Compose
- Make (for using the Makefile commands)

### Quick Start

1. **Clone the repository**:

   ```bash
   git clone <repository-url>
   cd grabler.me-hub
````

2. **Setup development environment**:

   ```bash
   make setup-dev
   ```

3. **Start development environment**:

   ```bash
   make dev
   ```

4. **Access the applications**:
   - Main hub: http://localhost:8080
   - Namo: http://namo.localhost:8080
   - Direct Namo frontend: http://localhost:5173
   - Direct Namo API: http://localhost:8000

### Available Commands

```bash
# Development
make dev         # Start development environment
make dev-down    # Stop development environment
make logs-dev    # View development logs

# Production
make prod        # Start production environment
make prod-down   # Stop production environment
make logs        # View production logs

# Maintenance
make build       # Build all services
make clean       # Remove all containers and images
make restart     # Restart all services
make health      # Check service health
```

## 🌐 Adding New Projects

To add a new project to the hub:

1. **Add the project as a submodule** (if using git submodules):

   ```bash
   git submodule add <project-repo-url> <project-name>
   ```

2. **Create integration override files**:

   ```bash
   # For production
   cp docker-compose.namo.yml docker-compose.newproject.yml
   # For development
   cp docker-compose.namo.dev.yml docker-compose.newproject.dev.yml
   # Edit these files to match your new project's service names
   ```

3. **Update Makefile** to include the new project in commands

4. **Update proxy/nginx.conf** to add routing for the new subdomain

5. **Update distributor-frontend/src/App.vue** to add a new tile:
   ```javascript
   {
     id: 'new-project',
     title: 'New Project',
     description: 'Description of the new project',
     url: 'https://newproject.grabler.me',
     icon: '🚀',
     gradient: 'linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%)',
     status: 'live'
   }
   ```

The beauty of this approach is that **each subproject maintains its own docker-compose.yml** and you just create small override files for integration!

## 🔧 Configuration

### Environment Variables

Each project can be configured through environment variables in the docker-compose files:

- **distributor**: Vue.js build configuration
- **namo-backend**: API configuration, database settings, CORS origins
- **namo-frontend**: API URLs, app name, environment

### Nginx Configuration

The proxy configuration includes:

- **Rate limiting**: API and general request limits
- **Caching**: Static asset caching with appropriate headers
- **CORS**: Proper CORS headers for API requests
- **Compression**: Gzip compression for better performance
- **Security**: Security headers and best practices

### Secrets Management

Sensitive configuration is handled through Docker secrets:

```bash
./Namo/secrets/
├── dev_postgres_password.txt
├── dev_secret_key.txt
├── telegram_bot_token.txt
└── dev_telegram_chat_id.txt
```

## 🌍 Production Deployment

### DNS Configuration

Point your domains to your server:

```
Type  Name                Value
A     grabler.me          your-server-ip
A     *.grabler.me        your-server-ip
```

### SSL/HTTPS Setup

For production with HTTPS:

1. **Obtain SSL certificates** (Let's Encrypt recommended):

   ```bash
   certbot certonly --standalone -d grabler.me -d *.grabler.me
   ```

2. **Update nginx.conf** to include SSL configuration:

   ```nginx
   server {
       listen 443 ssl;
       ssl_certificate /etc/nginx/ssl/fullchain.pem;
       ssl_certificate_key /etc/nginx/ssl/privkey.pem;
       # ... rest of configuration
   }
   ```

3. **Mount SSL certificates** in docker-compose.yml:
   ```yaml
   volumes:
     - /etc/letsencrypt/live/grabler.me:/etc/nginx/ssl:ro
   ```

### Production Startup

```bash
# Build and start production environment
make build
make prod

# Monitor logs
make logs
```

## 🔍 Monitoring and Debugging

### Health Checks

All services include health checks:

```bash
# Check overall health
make health

# Check individual containers
docker-compose ps
```

### Logs

```bash
# All services
make logs

# Specific service
docker-compose logs -f namo-backend
```

### Direct Access

In development mode, you can access services directly:

- Distributor frontend: http://localhost:3000
- Namo frontend: http://localhost:5173
- Namo backend: http://localhost:8000
- Database: localhost:5432

## 🧪 Development

### Hot Reload

Development mode includes hot reload for:

- **Vue.js applications**: Changes reflect immediately
- **FastAPI backend**: Auto-reload on file changes
- **Nginx configuration**: Restart proxy container to apply changes

### Adding Features to the Hub

The main hub is a Vue.js application. To modify:

1. Edit files in `distributor/src/`
2. Changes will auto-reload in development mode
3. Add new project tiles in `App.vue`
4. Customize styling in `style.css`

## 📋 Todo / Future Enhancements

- [ ] Automatic SSL certificate generation and renewal
- [ ] Health dashboard showing status of all services
- [ ] Centralized logging with log aggregation
- [ ] Monitoring and alerting integration
- [ ] Automated deployment pipeline
- [ ] Service discovery for dynamic project addition
- [ ] Load balancing for high availability
- [ ] Backup and disaster recovery procedures

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test in development environment
5. Submit a pull request

## 📄 License

[Add your license information here]

## 📞 Support

For issues and questions:

- Create an issue in the repository
- Check the logs: `make logs`
- Verify health: `make health`

---

**Happy coding! 🚀**
