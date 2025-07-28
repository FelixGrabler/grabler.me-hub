# Grabler.me Hub

A multi-project hub serving applications on different subdomains: **grabler.me**, **felix.grabler.me**, **rezepte.grabler.me**, and **namo.grabler.me**.

## 🏗️ Project Structure

```
grabler.me-hub/
├── docker-compose.yml              # Production environment (all services)
├── docker-compose.dev.yml          # Development environment (all services)
├── Makefile                        # Management commands
├── update-submodules.sh           # Script to update git submodules
├── README.md                       # This file
├── distributor/                    # Main hub website (grabler.me)
│   ├── src/
│   ├── Dockerfile
│   ├── Dockerfile.dev
│   └── package.json
├── proxy/                          # Nginx reverse proxy
│   ├── nginx.conf                 # Production routing config
│   └── nginx.dev.conf             # Development routing config
├── Felix/                         # Felix's portfolio (submodule)
│   ├── src/
│   ├── Dockerfile
│   ├── Dockerfile.dev
│   └── package.json
├── MamaRezepte/                   # Recipe app (submodule)
│   └── frontend/
│       ├── src/
│       ├── Dockerfile
│       ├── Dockerfile.dev
│       └── package.json
└── Namo/                          # Namo travel app (submodule)
    ├── app/
    │   ├── backend/               # FastAPI backend
    │   └── frontend/              # Vue.js frontend
    └── secrets/                   # Namo secrets
```

## 🌐 Domain Structure

| Domain               | Service     | Description                 |
| -------------------- | ----------- | --------------------------- |
| `grabler.me`         | Distributor | Main landing page and hub   |
| `felix.grabler.me`   | Felix       | Personal portfolio website  |
| `rezepte.grabler.me` | MamaRezepte | Recipe collection app       |
| `namo.grabler.me`    | Namo        | Travel planning application |

## 🏗️ Architecture

This is a centralized hub that orchestrates multiple web applications using **Docker Compose** and **Nginx reverse proxy**. The architecture uses a **simplified two-file approach** for easy management:

```
Docker Services:
├── docker-compose.yml     # Production: all services in one file
└── docker-compose.dev.yml # Development: all services in one file

Git Structure:
├── distributor/           # Main frontend (directly in repo)
├── Felix/                 # Git submodule
├── MamaRezepte/          # Git submodule
└── Namo/                 # Git submodule
```

This simplified approach means:

- ✅ **Single source of truth**: Only two compose files to manage
- ✅ **No file sprawl**: Eliminated 8+ docker-compose files down to 2
- ✅ **Direct dockerfile usage**: Uses Dockerfiles from submodules directly
- ✅ **Easy updates**: Simple command to update all submodules
- ✅ **Clear separation**: Development vs production environments

```
┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐ ┌─────────────────┐
│ grabler.me      │ │ felix.grabler.me│ │rezepte.grabler.me│ │ namo.grabler.me │
│ (Main Hub)      │ │ (Portfolio)     │ │ (Recipes)       │ │ (Travel App)    │
└─────────────────┘ └─────────────────┘ └─────────────────┘ └─────────────────┘
        │                    │                    │                    │
        └────────────────────┼────────────────────┼────────────────────┘
                             │                    │
                    ┌─────────────────┐          │
                    │   Nginx Proxy   │          │
                    │  (Port 80/443)  │          │
                    └─────────────────┘          │
                             │                    │
                    ┌─────────────────┐          │
                    │ Docker Network  │          │
                    │ grabler-network │          │
                    └─────────────────┘          │
                                                 │
                                        ┌─────────────────┐
                                        │ PostgreSQL DB   │
                                        │ (For Namo)      │
                                        └─────────────────┘
```

## 🚀 Features

- **Multi-Project Hub**: Centralized management of multiple independent applications
- **Subdomain Routing**: Nginx proxy automatically routes traffic based on subdomains
- **Git Submodules**: Each project is a separate git repository for independent development
- **Dockerized**: All services containerized for consistent deployment
- **Development Mode**: Hot-reload development environment with direct port access
- **Production Ready**: Optimized builds with caching, compression, and security headers
- **Simplified Management**: Two docker-compose files instead of 8+

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

```

## 🛠️ Setup and Usage

### Prerequisites

- Docker and Docker Compose
- Make (for using the Makefile commands)
- Git (for submodule management)

### Quick Start

1. **Clone the repository with submodules**:

   ```bash
   git clone --recurse-submodules <repository-url>
   cd grabler.me-hub
   ```

2. **Update submodules** (if needed):

   ```bash
   make update-submodules
   # or
   ./update-submodules.sh
   ```

3. **Setup development environment**:

   ```bash
   make setup-dev
   ```

4. **Start development environment**:

   ```bash
   make dev
   ```

5. **Access the applications**:

   - **Main hub**: http://localhost:8080
   - **Felix**: http://felix.localhost:8080
   - **MamaRezepte**: http://rezepte.localhost:8080
   - **Namo**: http://namo.localhost:8080

   **Direct access for debugging**:

   - Distributor: http://localhost:3000
   - Felix: http://localhost:4173
   - MamaRezepte: http://localhost:5174
   - Namo Frontend: http://localhost:5173
   - Namo API: http://localhost:8000

### Available Commands

```bash
# Development
make dev              # Start all development services
make dev-down         # Stop development environment
make logs-dev         # View development logs
make restart-dev      # Restart development services

# Production
make prod             # Start all production services
make prod-down        # Stop production environment
make logs             # View production logs
make restart          # Restart production services

# Individual services (development)
make felix-dev        # Start only Felix
make mama-rezepte-dev # Start only MamaRezepte
make namo-dev         # Start only Namo services

# Maintenance
make build            # Build all services
make clean            # Remove all containers and images
make health           # Check service health
make show-urls        # Display all service URLs

# Submodule management
make update-submodules # Update all git submodules
./update-submodules.sh # Alternative script for updating submodules
```

## 🌐 Adding New Projects

To add a new project to the hub:

1. **Add the project as a submodule**:

   ```bash
   git submodule add <project-repo-url> <project-name>
   cd <project-name>
   git checkout main  # or appropriate branch
   cd ..
   ```

2. **Update docker-compose files**:
   Add the new service to both `docker-compose.yml` and `docker-compose.dev.yml`:

   ```yaml
   # In docker-compose.yml (production)
   new-project:
     build:
       context: ./<project-name>
       dockerfile: Dockerfile
     container_name: new-project
     restart: unless-stopped
     networks:
       - grabler-network

   # In docker-compose.dev.yml (development)
   new-project:
     build:
       context: ./<project-name>
       dockerfile: Dockerfile.dev
     container_name: new-project-dev
     restart: unless-stopped
     ports:
       - "XXXX:3000"  # Choose an available port
     volumes:
       - ./<project-name>:/app
       - /app/node_modules
     networks:
       - grabler-network
   ```

3. **Update nginx configurations**:
   Add the new subdomain to both `proxy/nginx.conf` and `proxy/nginx.dev.conf`:

   ```nginx
   # New subdomain (newproject.grabler.me or newproject.localhost)
   server {
       listen 80;
       server_name newproject.grabler.me;  # or newproject.localhost for dev

       location / {
           proxy_pass http://new-project:80;  # or new-project-dev:3000 for dev
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

4. **Update proxy dependencies**:
   Add the new service to the proxy's `depends_on` section in both compose files.

5. **Test the integration**:
   ```bash
   make dev
   # Check that your new service is accessible
   ```

## 🔧 Submodule Management

cp docker-compose.namo.dev.yml docker-compose.newproject.dev.yml

# Edit these files to match your new project's service names

````

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
````

5. **Test the integration**:
   ```bash
   make dev
   # Check that your new service is accessible
   ```

## 🔧 Submodule Management

This project uses Git submodules to include separate projects. Here are the common commands:

### Updating Submodules

```bash
# Method 1: Use the Makefile
make update-submodules

# Method 2: Use the shell script
./update-submodules.sh

# Method 3: Manual git commands
git submodule update --init --recursive
git submodule foreach git pull origin main
```

### Adding a New Submodule

```bash
git submodule add <repository-url> <directory-name>
cd <directory-name>
git checkout main  # or the branch you want to track
cd ..
git add .gitmodules <directory-name>
git commit -m "Add <project-name> submodule"
```

### Working with Submodules

```bash
# Check status of all submodules
git submodule status

# Update a specific submodule to latest
git submodule update --remote <submodule-path>

# Reset a submodule if it's in a weird state
git submodule update --init --force <submodule-path>

# Remove a submodule (if needed)
git submodule deinit <submodule-path>
git rm <submodule-path>
rm -rf .git/modules/<submodule-path>
```

### Working on Submodule Code

When you want to make changes to a submodule:

```bash
cd <submodule-directory>
git checkout main  # or appropriate branch
# Make your changes
git add .
git commit -m "Your changes"
git push origin main

# Back in the hub repo
cd ..
git add <submodule-directory>
git commit -m "Update <submodule-name> to latest"
```

## 🔧 Configuration

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
